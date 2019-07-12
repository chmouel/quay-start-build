PREFIX=quay.io/openshift-pipeline
NAME=$(PREFIX)/quay-start-build:latest
CATALOG_IMAGES=s2i openshift-cli
SECRET_NAME=approbottoken

.PHONY: all
all: build push

build:
	docker build -t ${NAME} -f Dockerfile .

push:
	docker push ${NAME}

install:
	@oc get secret ${SECRET_NAME} >/dev/null || { echo "You need to create the secret eg: oc create secret generic ${SECRET_NAME} --from-literal=token=YOURTOKEN"; exit 1;}
	@for image in ${CATALOG_IMAGES};do \
		sed "s,%TARGET%,$$image,;s,%IMAGE_NAME%,${NAME}," openshift-pipeline.yaml.tmpl | oc apply -f-; \
	done
