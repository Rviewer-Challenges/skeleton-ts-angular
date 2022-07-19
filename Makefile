CONTAINER_NAME=skeleton-angular

deps:
	@ docker run -w "/opt/app" -v "${PWD}:/opt/app" node:alpine yarn install

down:
	@ docker kill $(CONTAINER_NAME) || true
	@ docker rm $(CONTAINER_NAME)

up: deps
	@ docker run -p "3000:3000" -w "/opt/app" -v "${PWD}:/opt/app" -e CI=true --name $(CONTAINER_NAME) node:alpine yarn start

.PHONY: test
test: deps
	@ docker run -w "/opt/app" -v "${PWD}:/opt/app" node:alpine yarn test

.PHONY: coverage
coverage: deps
	@ docker run -w "/opt/app" -v "${PWD}:/opt/app" node:alpine yarn coverage
