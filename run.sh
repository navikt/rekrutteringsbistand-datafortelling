#!/bin/bash

quarto render formidlingstall.ipynb --execute

curl -X PUT -F index.html=@formidlingstall.html \
    https://${NADA_HOST}/quarto/update/${QUARTO_ID} \
    -H "Authorization:Bearer ${TEAM_TOKEN}"

quarto render main.qmd

curl -X PUT -F index.html=@main.html \
    https://${NADA_HOST}/quarto/update/${QUARTO_ID_OVERSIKT} \
    -H "Authorization:Bearer ${TEAM_TOKEN}"