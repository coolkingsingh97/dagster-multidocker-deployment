
#FROM python:3.7-slim
#RUN mkdir -p /opt/dagster/dagster_home /opt/dagster/app
#RUN pip install dagster-webserver dagster-postgres dagster-aws
# Copying code and workspace to /opt/dagster/app
#COPY repo.py workspace.yaml /opt/dagster/app/
#ENV DAGSTER_HOME=/opt/dagster/dagster_home/
# Copying dagster instance yaml to $DAGSTER_HOME
#COPY dagster.yaml /opt/dagster/dagster_home/
#WORKDIR /opt/dagster/app
#EXPOSE 3000
#ENTRYPOINT ["dagster-webserver","-h","0.0.0.0","-p","3000"]

FROM python:3.7-slim

# Change working directory
WORKDIR /opt/dagster/dagster_home
ENV DAGSTER_HOME=/opt/dagster/dagster_home

# Install dependencies & credentials
COPY requirements.txt .
COPY credentials/dagster-poc-1-5b5ff1cf78d7.json .
RUN pip install -r requirements.txt

# Copy config code
RUN mkdir -p $DAGSTER_HOME
COPY projectpoc1 ./projectpoc1
COPY dagster.yaml workspace.yaml $DAGSTER_HOME

CMD ["dagster-webserver", "-w", "workspace.yaml", "-h", "0.0.0.0", "-p", "3000"]
