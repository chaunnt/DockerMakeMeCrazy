## Deploy image
FROM ai-id-base-image as deploy-image
COPY dataset/ darknet
COPY train.sh train.sh
CMD [ "/bin/sh", "-c", "./train.sh" ]
