#!/bin/bash

quarto render formidlingstall.qmd

curl -X PUT -F index.html=@formidlingstall.html \
    https://${NADA_HOST}/quarto/update/${QUARTO_ID} \
    -H "Authorization:Bearer ${TEAM_TOKEN}"