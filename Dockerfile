FROM node:14-alpine

# Dependencies
# RUN apk update && apk upgrade && \
#    apk add --no-cache bash gawk sed grep bc coreutils git openssh

ENV NODE_ENV=production \
  MONGODB_URI=mongodb://db-dev-midespacho-mongo-1af91578.mongo.ondigitalocean.com?authSource=admin&replicaSet=db-dev-midespacho-mongo&tls=true \
  COLLECTION=agenda-schedule-jobs \
  BASE_PATH=/

RUN mkdir -p /agendash
WORKDIR /agendash

COPY package.json /agendash/
RUN npm install && npm cache clean --force

COPY . /agendash
RUN chmod +x /agendash/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/agendash/entrypoint.sh"]
