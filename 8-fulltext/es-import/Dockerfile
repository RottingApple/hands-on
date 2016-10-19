FROM ruby:2.0

RUN gem install activerecord pg elasticsearch ruby-progressbar

ADD es-import.rb /es-import.rb

ENTRYPOINT ["ruby", "/es-import.rb"]
