FROM ruby:2.6.3

RUN apt-get update -q 
RUN apt-get install -y nodejs curl git postgresql

RUN mkdir /app

RUN adduser -S -D -H -h /app rubyuser

ADD . /app
WORKDIR /app

RUN gem install bundler

RUN bundle install

RUN rake assets:precompile

# Expose port
EXPOSE 3000

RUN chmod -R 777 /app/db/
RUN chmod -R 777 /app/tmp/
RUN chmod -R 777 log

USER rubyuser

CMD ["bundle","exec","puma","-C","config/puma.rb"]
