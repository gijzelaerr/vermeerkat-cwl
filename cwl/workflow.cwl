cwlVersion: v1.0
class: Workflow
inputs:
  url:
   type: string
  mask:
   type: File

outputs:
  ms:
    type: Directory
    outputSource: h5toms/ms


steps:
  curl:
    run: curl.cwl
    in:
      url: url
    out: [downloaded]

  h5toms:
    run: h5toms.cwl
    in:
      h5: curl/downloaded
    out: [ms]

  rfimasker:
    run: rfimasker.cwl
    in:
      ms: h5toms/ms
      mask: mask
    out: [ms]

  aoflagger:
    run: aoflagger.cwl
    in:
      ms: rfimasker/ms
    out:
        [ms]

