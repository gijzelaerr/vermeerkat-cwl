cwlVersion: v1.0
class: CommandLineTool

$namespaces:
  cwltool: http://commonwl.org/cwltool#
requirements:
  - class: DockerRequirement
    dockerFile: |
       FROM kernsuite/base:1
       RUN docker-apt-install aoflagger
    dockerImageId: vermeerkat/aoflagger
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ms)
        writable: true
  - class: cwltool:InplaceUpdateRequirement
    inplaceUpdate: true

baseCommand: "aoflagger"
arguments: [$( inputs.ms.basename )]

inputs:
  ms: Directory

outputs:
  ms:
    type: Directory
    outputBinding:
      glob: $( inputs.ms.basename )
