# Makefile for docker-no-latest

.PHONY: run docker-build docker-run cleanup create remove publish help

run:
	node server.js

# Define the publish target
publish:
	@echo "Switching to main branch..."
	git checkout main
	@echo "Incrementing version..."
	@current_version=$(npm pkg get version | tr -d '"'); \
	next_version=$(npm version patch --no-git-tag-version); \
	tag=v$$next_version; \
	if git rev-parse "v$$next_version" >/dev/null 2>&1; then \
		echo "Tag v$$next_version already exists. Deleting..."; \
		git tag -d v$$next_version; \
		git push --delete origin v$$next_version || true; \
	fi; \
	echo "Committing version bump..."; \
	echo "Version bump to $$next_version" > .version-bump-message; \
	git add package.json package-lock.json; \
	git commit -m "Bump version to $$next_version" || true; \
	npm version $$next_version --git-tag-version; \
	echo "Pushing changes and tags..."; \
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

help:
	@echo "Available targets:"
	@echo "  run           Run the server locally (node server.js)"
	@echo "  docker-build  Build the Docker image (docker build . -t docker-no-latest)"
	@echo "  docker-run    Run the Docker container (docker run -p 3000:3000 --name no-server docker-no-latest)"
	@echo "  cleanup       Stop, remove container and image (docker stop/rm/rmi)"
	@echo "  create        Build and run the Docker container"
	@echo "  remove        Stop, remove container and image (single line)"
	@echo "  publish       Switch to main, bump version, push changes and tags"
	@echo "  help          Show this help message"

.DEFAULT_GOAL := help
