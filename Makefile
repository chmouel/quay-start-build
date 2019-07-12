PREFIX=quay.io/openshift-pipeline
NAME=$(PREFIX)/quay-start-build:latest
CATALOG_IMAGES=s2i openshift-cli
SECRET_NAME=approbottoken
TEMPLATE=catalog-image-openshift-pipeline-build.yaml.tmpl

.PHONY: all
all: build push

build:
	docker build -t ${NAME} -f Dockerfile .

push:
	docker push ${NAME}

install:
	@kubectl get secret ${SECRET_NAME} >/dev/null || { echo "You need to create the secret eg: kubectl create secret generic ${SECRET_NAME} --from-literal=token=YOURTOKEN"; exit 1;}
	@for image in ${CATALOG_IMAGES};do \
		sed "s,%TARGET%,$$image,;s,%IMAGE_NAME%,${NAME}," ${TEMPLATE} | kubectl apply -f-; \
	done
