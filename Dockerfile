FROM ambakshi/perforce-base
MAINTAINER Asif Shaikh <ripclaw_ffb@hotmail.com>

ENV P4_VERSION 18.2

RUN curl -sSL -O http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4 && mv p4 /usr/bin/p4 && chmod +x /usr/bin/p4
RUN curl -sSL -O http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4p && mv p4p /usr/bin/p4p && chmod +x /usr/bin/p4p
RUN curl -sSL -O https://swarm.workshop.perforce.com/view/guest/frank_compagner/p4p_clean.py && mv p4p_clean.py /usr/bin/p4p_clean.py && chmod +x /usr/bin/p4p_clean.py

ENV P4TARGET perforce:1666
ENV P4PORT 1666
ENV P4PCACHE /cache

VOLUME ["$P4PCACHE"]

EXPOSE 1666

CMD ["/usr/bin/p4p"]
