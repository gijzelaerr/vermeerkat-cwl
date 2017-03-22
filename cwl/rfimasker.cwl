cwlVersion: v1.0
class: CommandLineTool

$namespaces:
  cwltool: http://commonwl.org/cwltool#
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
  - class: cwltool:InplaceUpdateRequirement
    inplaceUpdate: true

baseCommand: "/usr/bin/mask_ms.py"
arguments: [ "-m", $( inputs.mask.path ), $( inputs.ms.basename ), ]

inputs:
  ms:
    type: Directory
  mask:
    type: File

outputs:
  ms:
    type: Directory
    outputBinding:
      glob: $( inputs.ms.basename )
