#!/bin/bash
bundle exec rails db:setup
xvfb-run -a bundle exec rspec $@
