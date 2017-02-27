cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: DockerRequirement
    dockerFile: |
       FROM kernsuite/base:2
       RUN docker-apt-install casalite
    dockerImageId: vermeerkat/casalite
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ms)
        writable: true

baseCommand: "casa"
arguments: [$( inputs.ms.basename )]

inputs:
  ms: Directory

outputs:
  ms:
    type: Directory
    outputBinding:
      glob: $( inputs.ms.basename )
