cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: DockerRequirement
    dockerFile: |
       FROM kernsuite/base:1
       RUN docker-apt-install python-rfimasker
    dockerImageId: vermeerkat/rfimasker
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ms)
        writable: true

baseCommand: "/usr/bin/mask_ms.py"

inputs:
  ms:
    type: Directory
    inputBinding:
      position: 2
  mask:
    type: File
    inputBinding:
      prefix: -m
      position: 1

outputs:
  ms:
    type: Directory
    outputBinding:
      glob: $( inputs.ms.basename )
