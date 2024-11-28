docker network create guestbook-network

docker run -d \
  --name guestbook-db \
  --network guestbook-network \
  -e POSTGRES_DB=guestbook \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=secret \
  -p 5432:5432 \
  postgres:17
docker run -d \
  --name guestbook-app \
  --network guestbook-network \
  -v "$(pwd):/var/www/html" \
  -p 8000:80 \
  guestbook-app
docker exec -it guestbook-app composer install 
docker exec -it guestbook-app chown -R www-data:www-data /var/www/html
docker exec -it guestbook-app chmod -R 775 /var/www/html/storage
docker exec -it guestbook-app chmod -R 775 /var/www/html/bootstrap/cache
docker exec -it guestbook-app php artisan key:generate