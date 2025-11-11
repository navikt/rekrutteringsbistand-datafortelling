FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/python:3.13-dev as compile-image

USER root
RUN apk add --update jq curl

WORKDIR /quarto
COPY run.sh .

RUN adduser -D -h /quarto/ -u 1069 -s /bin/bash quarto && \
    chown -R quarto:quarto /quarto/ && chmod +x run.sh

RUN QUARTO_VERSION=$(curl https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | jq '.tag_name' | sed -e 's/[\"v]//g') && \
wget https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
tar -xvzf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    mv quarto-${QUARTO_VERSION}/bin/* /usr/local/bin && \
    mv quarto-${QUARTO_VERSION}/share /usr/local/share/ && \
rm -rf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz

FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/python:3.13 AS runner

USER quarto

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY *.qmd .

ENTRYPOINT ["./run.sh"]