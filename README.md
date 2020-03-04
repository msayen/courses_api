# Course enrollment API prototype

## Setup
### Local environment
Required Ruby version is `2.6.5`.
```
bundle install
rails db:create
rails db:migrate
rails db:seed
rails spec
rails s
```
### With docker compose
```
docker-compose run courses-api rails db:create db:migrate db:seed
docker-compose up
```
API will be available on `localhost:3000`

## Postman 
You can explore API with attached Postman collection. Import collection from [json file](postman/courses-api.postman_collection.json) under `postman` folder.
