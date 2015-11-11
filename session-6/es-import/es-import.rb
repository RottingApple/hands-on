require 'active_record'
require 'elasticsearch'
require 'ruby-progressbar'

ActiveRecord::Base.establish_connection(adapter: 'postgresql', host: 'localhost', port: 5432, user: 'postgres', database: 'oz')

class Contract < ActiveRecord::Base
  self.primary_key = 'id'
end

progressbar = ProgressBar.create(title: 'Loading contracts', total: Contract.count, throttle_rate: 1, format: '%a | %e %B %p%% %t')

BATCH_SIZE = 1000
es = Elasticsearch::Client.new
requests = []

Contract.find_each(batch_size: BATCH_SIZE) do |contract|
  requests << {index: {_index: 'contracts', _type: 'contract', _id: contract.id, data: {
    name:         contract.name,
    identifier:   contract.identifier,
    department:   contract.department,
    customer:     contract.customer,
    supplier:     contract.supplier,
    supplier_ico: contract.supplier_ico,
    total_amount: contract.total_amount,
    note:         contract.note,
    published_on: contract.published_on
  }}}

  progressbar.increment

  if requests.length >= BATCH_SIZE
    es.bulk(body: requests)
    requests = []
  end
end

if requests.length > 0
  es.bulk(body: requests)
end
