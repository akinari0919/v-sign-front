FROM node:16.13.1-alpine

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN yarn global add @vue/cli
COPY package.json .
RUN yarn install

COPY . .

RUN yarn run build
