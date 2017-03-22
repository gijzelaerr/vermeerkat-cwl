.PHONY: run images

all: run


clean:
	rm -rf .virtualenv

.virtualenv:
	virtualenv -p python2 .virtualenv
	.virtualenv/bin/pip install --upgrade pip setuptools
	.virtualenv/bin/pip install -r requirements.txt

data/rfi_mask.pickle:
	cd data && tar zxvf rfi_mask.pickle.tgz

run: .virtualenv data/rfi_mask.pickle
	.virtualenv/bin/cwltool --enable-ext --outdir results --cachedir cache cwl/workflow.cwl cwl/job.cwl
