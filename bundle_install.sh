#!/bin/sh
cd /home/app/webapp
gem install bundler
bundle install --deployment
