ARG BUILD_FROM
FROM $BUILD_FROM as base

ENV LANG C.UTF-8

# Dependencies and build
FROM base as dependencies_and_build

WORKDIR /matterflow

RUN apk add --update --no-cache npm dumb-init git python3 py3-pip python3-dev && \
    echo "Installing MatterFlow"

RUN git clone https://github.com/MatterCoder/matterflow.git /matterflow && \
    mkdir /matterflow/dist && \
    jq -n --arg commit $(eval cd /matterflow;git rev-parse --short HEAD) '$commit' > /matterflow/dist/.hash ; \
    echo "Installed MatterFlow @ version $(cat /matterflow/dist/.hash)" 

#WORKDIR /matterflow/api

#ENV VIRTUAL_ENV=./venv
#RUN python3 -m venv $VIRTUAL_ENV
#ENV PATH="$VIRTUAL_ENV/bin:$PATH"

#RUN $VIRTUAL_ENV/bin/pip install pipenv

# Install dependencies:
#RUN . /matterflow/api/venv/bin/activate && pipenv install

#RUN echo "SECRET_KEY=tmp" > mf/.environment

#EXPOSE 8000

#WORKDIR /matterflow/api/mf

# Copy data for add-on
COPY start.sh /
RUN chmod a+x /start.sh

WORKDIR /matterflow/web

RUN npm install

EXPOSE 5173
ENTRYPOINT ["/start.sh"]

LABEL io.hass.version="VERSION" io.hass.type="addon" io.hass.arch="armhf|aarch64|i386|amd64"