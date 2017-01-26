.PHONY: run images

all: run


clean:
	rm -rf .virtualenv

.virtualenv:
	virtualenv -p python2 .virtualenv
	.virtualenv/bin/pip install --upgrade pip setuptools
	.virtualenv/bin/pip install -r requirements.txt

images:
	$(MAKE) -C images

run: images .virtualenv
	.virtualenv/bin/cwl-runner --outdir results --cachedir cache cwl/workflow.cwl cwl/job.cwl
