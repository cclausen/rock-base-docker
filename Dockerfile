FROM ubuntu:14.04 
RUN apt-get -y update && apt-get install -y ruby2.0 wget expect
RUN mkdir /opt/rock
RUN cd /opt/rock/ && wget https://raw.githubusercontent.com/rock-core/buildconf/master/bootstrap.sh
RUN chmod +x /opt/rock/bootstrap.sh
RUN echo '#!/usr/bin/expect\n\
set timeout -1\n\
spawn ./bootstrap.sh ruby2.0 localdev\n\
expect -re ".*github.*" { send "\r" }\n\
expect -re ".*bootstrapping anyway.*" { send "\r" }\n\
expect -re ".*So, what do you want.*" { send "\r" }\n\
expect eof\n\
#interact\n\
' >> /opt/rock/expect_bootstrap.exp
RUN chmod +x /opt/rock/expect_bootstrap.exp
RUN cd /opt/rock/ && ./expect_bootstrap.exp
