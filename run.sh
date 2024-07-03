#!/bin/bash

quarto render main.qmd

curl -X PUT -F index.html=@main.html \
    https://${NADA_HOST}/quarto/update/${QUARTO_ID_OVERSIKT} \
    -H "Authorization:Bearer ${TEAM_TOKEN}"