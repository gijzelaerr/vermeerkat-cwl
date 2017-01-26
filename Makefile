.PHONY: run images

all: run


.virtualenv:
	virtualenv -p python2 .virtualenv
	.virtualenv/bin/pip install -r requirements.txt

images:
	$(MAKE) -C images

run: images .virtualenv
	.virtualenv/bin/cwltoil workflow.cwl job.cwl
