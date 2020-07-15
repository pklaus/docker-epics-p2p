## ======================================
# 1st stage: take p2p from a full blown EPICS Base image
#            and copy it to a new root folder along with all its dependencies.
#            https://blog.oddbit.com/post/2015-02-05-creating-minimal-docker-images/
FROM pklaus/epics_base:7.0.4_debian AS dockerizer
USER root

# Install Python and a Python2 compatible version of larsks/dockerize
RUN apt-get update && apt-get install -yq python python-pip rsync \
 && pip install https://github.com/larsks/dockerize/archive/a903419.zip

# Move the executable "p2p" to a more prominent location
RUN mv /epics/base/bin/*/p2p /epics/

# Dockerize
RUN dockerize -L preserve -n -u scs -o /p2p_root --verbose /epics/p2p \
 && find /p2p_root/ -ls \
 && rm /p2p_root/Dockerfile \
 # /epics is owned by scs in this image and should also be in later one:
 && chown -R scs:users /p2p_root/epics


## =========================================
#  2th stage: Finally put together our image
#             from scratch for minimal size.
FROM scratch AS final

USER scs

COPY --from=dockerizer /p2p_root /

ENV EPICS_CA_AUTO_ADDR_LIST=NO

ENV PATH=/

WORKDIR /epics

ENTRYPOINT ["/epics/p2p"]
CMD ["-h"]
