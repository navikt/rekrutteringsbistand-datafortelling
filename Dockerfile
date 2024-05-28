FROM python:3.11-slim

# Create a virtual environment in which we install the Python packages described in the requirements file
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy necessary files to the docker image
COPY run.sh .
COPY *.qmd .

# Give the "python" user execution rights to the script "run.sh"
RUN chmod +x run.sh

# Specifies the entry point for the Docker image to be the "run.sh" script
ENTRYPOINT ["./run.sh"]