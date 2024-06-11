#!/bin/bash

quarto render formidlingstall.ipynb --execute

curl -X PUT -F index.html=@formidlingstall.html \
    https://${NADA_HOST}/quarto/update/${QUARTO_ID} \
    -H "Authorization:Bearer ${TEAM_TOKEN}"

quarto render oversikt.ipynb --execute

curl -X PUT -F index.html=@oversikt.html \
    https://${NADA_HOST}/quarto/update/${QUARTO_ID_OVERSIKT} \
    -H "Authorization:Bearer ${TEAM_TOKEN}"