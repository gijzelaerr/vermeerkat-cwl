cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: DockerRequirement
    dockerPull: vermeerkat/aoflagger
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.ms)
baseCommand: [aoflagger]
inputs:
  ms:
    type: Directory
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  ms:
    type: Directory
    outputBinding:
      glob: $(inputs.ms)
