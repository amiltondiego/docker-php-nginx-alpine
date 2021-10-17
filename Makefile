CONTAINER = docker-php-nginx-alpine
IMAGE = amiltondiego/docker-php-nginx-alpine
TAG = latest

run:
	@ docker run -p 80:80 -v $(CURDIR):/app/public --name $(CONTAINER) -P $(IMAGE):$(TAG)

image:
	@ docker build -t $(IMAGE):$(TAG) .

remove:
	@ docker rm -f $(CONTAINER)

destroy:
	@ docker rmi $(IMAGE)

push:
	@ docker push $(IMAGE)