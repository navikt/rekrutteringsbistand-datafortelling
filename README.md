# rekrutteringsbistand-datafortelling

# Komme i gang (WiP)

### Pre requisites

Installer [python3.11](https://www.python.org/downloads/).

Opprett et virtuelt pythonmiljø i root til prosjektet: `python3.11 -m venv .venv`.

Aktiver det virtuelle miljøet: `source .venv/bin/activate`.

Installer Python-pakker: `pip3 install -r requirements.txt`.

### Git pre-commit hooks

Installer pre-commit pakke: `pip3 install pre-commit`.

Installer git hook-skriptene: `pre-commit install`.

### Lokal utvikling

Logg inn i GCP med `gcloud auth application-default login`.

Kjør quarto lokalt for å generere en datafortelling: `quarto render <datafortellingsnavn>.qmd`.

