FROM node:10-alpine
WORKDIR /usr/src/app

COPY ./${SERVICE_NAME} .

RUN npm install -global pm2

RUN npm install --production 

EXPOSE ${SERVICE_PORT}

CMD [ "pm2-runtime", "pm2.json" ]