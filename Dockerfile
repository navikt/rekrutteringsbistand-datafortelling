FROM gcr.io/distroless/cc AS cc
FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/python:3.13-dev AS compile-image

USER root
RUN apk add --update jq curl

WORKDIR /quarto

RUN adduser -m -d /quarto/ -u 1069 -s /bin/bash quarto && \
    chown -R quarto:quarto /quarto/

RUN QUARTO_VERSION=$(curl https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | jq '.tag_name' | sed -e 's/[\"v]//g') && \
wget https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
tar -xvzf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    mv quarto-${QUARTO_VERSION}/bin/* /usr/local/bin && \
    mv quarto-${QUARTO_VERSION}/share /usr/local/share/ && \
rm -rf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz


#FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/python:3.13 AS runner-image

USER quarto
#
#COPY --chown=python:python --from=compile-image /opt/venv /opt/venv
#COPY --chown=python:python --from=compile-image quarto-dist/ quarto-dist/
#RUN ln -s /quarto/quarto-dist/bin/quarto /usr/local/bin/quarto

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

#ENV PATH="/opt/venv/bin:$PATH"
#RUN python3 -m venv /opt/venv

COPY run.sh .
COPY *.qmd .

#RUN chown python:python /quarto -R
#
#ENV DENO_DIR=/quarto/deno
#ENV XDG_CACHE_HOME=/quarto/cache
#ENV XDG_DATA_HOME=/quarto/share
#
#USER 1069

RUN chmod +x run.sh
ENTRYPOINT ["./run.sh"]