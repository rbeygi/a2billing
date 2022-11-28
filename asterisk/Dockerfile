FROM andrius/asterisk
LABEL maintainer="RezaB r-beygi@hotmail.com"

COPY ./asterisk/extensions.conf /etc/asterisk/extensions.conf
COPY ./asterisk/sip.conf /etc/asterisk/sip.conf

RUN touch /etc/asterisk/additional_a2billing_iax.conf
RUN touch /etc/asterisk/additional_a2billing_sip.conf
RUN echo \#include additional_a2billing_sip.conf >> /etc/asterisk/sip.conf
RUN echo \#include additional_a2billing_iax.conf >> /etc/asterisk/iax.conf
