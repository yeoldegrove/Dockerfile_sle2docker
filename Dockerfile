FROM opensuse:latest
MAINTAINER docker@yeoldegrove.de

RUN zypper addrepo http://download.opensuse.org/repositories/Virtualization:/containers/openSUSE_13.2/Virtualization:containers.repo && \
    zypper --gpg-auto-import-keys --non-interactive refresh && \
    zypper --gpg-auto-import-keys --non-interactive update && \
    zypper --gpg-auto-import-keys --non-interactive install --auto-agree-with-licenses sle2docker git patch
RUN zypper --gpg-auto-import-keys --non-interactive refresh && \
    zypper --gpg-auto-import-keys --non-interactive update
RUN git clone https://github.com/jpetazzo/dind.git /usr/local/wrapdocker

COPY patch_wrapdocker.patch /tmp/

RUN patch -b -p2 /usr/local/wrapdocker/wrapdocker </tmp/patch_wrapdocker.patch

ENTRYPOINT ["/usr/local/wrapdocker/wrapdocker"]
CMD ["--help"]
