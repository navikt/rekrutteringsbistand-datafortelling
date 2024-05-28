FROM python:3.11-slim

# Install the Python packages described in the requirements file
RUN python3 -m pip install --upgrade pip
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Copy necessary files to the docker image
COPY run.sh .
COPY *.qmd .

# Give the "python" user execution rights to the script "run.sh"
RUN chmod +x run.sh

# Specifies the entry point for the Docker image to be the "run.sh" script
ENTRYPOINT ["./run.sh"]