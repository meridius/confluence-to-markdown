FROM node:current-slim

WORKDIR /var/app
RUN mkdir -p /var/app
COPY . /var/app/

RUN apt-get update -qq \
    && apt-get install -y pandoc \
    && npm install

CMD ["npm", "run", "start"]
