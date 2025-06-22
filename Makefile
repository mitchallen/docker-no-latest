# Makefile for docker-no-latest

.PHONY: run docker-build docker-run cleanup create remove publish

run:
	node server.js

# Define the publish target
publish:
	@echo "Switching to main branch..."
	git checkout main
	@echo "Incrementing version..."
	npm version patch
	@echo "Pushing changes and tags..."
	git push && git push --tags

docker-build:
	docker build . -t docker-no-latest

docker-run:
	docker run -p 3000:3000 --name no-server docker-no-latest

cleanup:
	docker stop no-server || true
	docker rm no-server || true
	docker rmi docker-no-latest || true

create:
	docker build . -t docker-no-latest && docker run -p 3000:3000 --name no-server docker-no-latest

remove:
	docker stop no-server || true && docker rm no-server || true && docker rmi docker-no-latest || true
