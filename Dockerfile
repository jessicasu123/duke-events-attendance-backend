FROM ruby:2.6.3

RUN apt-get update -q 
RUN apt-get install -y nodejs curl git postgresql

RUN mkdir /app

RUN adduser -S -D -H -h /app rubyuser

RUN chmod go+w /app

ADD . /app
WORKDIR /app

RUN gem install bundler

RUN bundle install

RUN rake assets:precompile

# Expose port
EXPOSE 3000

RUN chmod -R 777 log

USER rubyuser

CMD ["puma","-C","config/puma.rb"]
