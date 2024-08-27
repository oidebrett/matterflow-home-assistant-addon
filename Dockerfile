ARG BUILD_FROM
FROM $BUILD_FROM as base

ENV LANG C.UTF-8

WORKDIR /matterflow

RUN apk add --update --no-cache npm dumb-init git python3 py3-pip python3-dev && \
    echo "Installing MatterFlow"

RUN git clone https://github.com/MatterCoder/matterflow.git /matterflow && \
    mkdir /matterflow/dist && \
    jq -n --arg commit $(eval cd /matterflow;git rev-parse --short HEAD) '$commit' > /matterflow/dist/.hash ; \
    echo "Installed MatterFlow @ version $(cat /matterflow/dist/.hash)" 

WORKDIR /matterflow/web

RUN npm install
RUN npm install -g serve
RUN npm run build

# Copy data for add-on
COPY start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]

