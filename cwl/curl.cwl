cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerImageId: vermeerkat/curl
baseCommand: [curl, -O, -L, -C, -]
inputs:
  url:
    type: string
    inputBinding:
      position: 1
outputs:
  downloaded:
    type: File
    outputBinding:
      glob: "*"
