FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  xvfb \
  qt5-default \
  libqt5webkit5-dev \
  gstreamer1.0-plugins-base \
  gstreamer1.0-tools \
  gstreamer1.0-x
ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY . $APP_HOME
ENV BUNDLE_PATH /bundle
RUN bundle install
RUN curl -sL https://deb.nodesource.com/setup_8.x |   bash -
RUN  apt-get install -y nodejs
CMD tail -f /dev/null
