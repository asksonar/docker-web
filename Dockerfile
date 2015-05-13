# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-ruby22:0.9.15

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# remove the default site
RUN rm /etc/nginx/sites-enabled/default
# set my default site
ADD server.conf /etc/nginx/sites-enabled/server.conf
# add environment variables to nginx
ADD env.conf /etc/nginx/main.d/env.conf

# this should also be set via -v /local/path/to/src:/home/app/webapp
RUN mkdir /home/app/webapp

# run bundle install upon startup
RUN mkdir -p /etc/my_init.d
ADD bundle_install.sh /etc/my_init.d/bundle_install.sh

# enable nginx and passenger
RUN rm -f /etc/service/nginx/down

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
