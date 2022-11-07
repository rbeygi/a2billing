FROM hibou/asterisk:13
LABEL maintainer="RezaB r-beygi@hotmail.com"

RUN touch /etc/asterisk/additional_a2billing_iax.conf
RUN touch /etc/asterisk/additional_a2billing_sip.conf
RUN echo \#include additional_a2billing_sip.conf >> /etc/asterisk/sip.conf
RUN echo \#include additional_a2billing_iax.conf >> /etc/asterisk/iax.conf

RUN mkdir /sounds
WORKDIR /sounds
COPY ./addons/sounds .
RUN chmod +x install_a2b_sounds.sh ; ./install_a2b_sounds.sh
