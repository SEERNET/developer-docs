FROM node:8.11.4

WORKDIR /app/website

EXPOSE 3000 35729 9005
COPY ./docs /app/docs
COPY ./website /app/website
RUN yarn install
RUN npm install -g firebase-tools firebase-admin

CMD ["yarn", "start"]
