## Deploy image
FROM ai-id-base-image as deploy-image
COPY dataset/ darknet
COPY start-container.sh start-container.sh
CMD [ "/bin/sh", "-c", "./start-container.sh" ]
