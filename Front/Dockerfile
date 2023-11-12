FROM node as node 
ADD ./ /app

WORKDIR /app

RUN npm install 


EXPOSE 8000

CMD [ "npm", "run", "dev", "--", "--host" , "--port","8000"]

