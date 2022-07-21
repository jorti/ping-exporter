ARG FEDORA_ARCH=x86_64
ARG FEDORA_VERSION=36
FROM registry.fedoraproject.org/fedora:${FEDORA_VERSION}-${FEDORA_ARCH}

RUN dnf update --setopt=install_weak_deps=False --nodocs -y && \
    dnf install -y --setopt=install_weak_deps=False --nodocs python3 fping && \
    dnf clean all && \
    useradd ping-exporter
COPY ping-exporter.py /usr/local/bin/ping-exporter.py
LABEL maintainer="Juan Orti Alcaine <jortialc@redhat.com>" \
    description="Prometheus ping exporter"
USER ping-exporter:ping-exporter
ENTRYPOINT ["/usr/local/bin/ping-exporter.py"]
