FROM phusion/baseimage:0.9.13

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
#######################################################################################

# prepare for installation
RUN apt-get update

# install mysql server
RUN apt-get install -y mysql-server

# setup service script
RUN mkdir /etc/service/mysql
ADD mysql.sh /etc/service/mysql/run
RUN chmod +x /etc/service/mysql/run

# setup init script
ADD mysql_setup.sh /etc/my_init.d/mysql_setup.sh
RUN chmod +x /etc/my_init.d/mysql_setup.sh

# expose port
EXPOSE 3306

# define volume mount
VOLUME ["/var/lib/mysql"]

#######################################################################################
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
