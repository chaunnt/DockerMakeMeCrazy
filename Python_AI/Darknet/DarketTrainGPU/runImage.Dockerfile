## Deploy image
FROM ai-id-base-image as deploy-image
WORKDIR /usr/src/app
COPY . /usr/src/app