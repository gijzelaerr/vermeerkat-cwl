cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: DockerRequirement
    dockerFile: |
      FROM kernsuite/base:1
      RUN docker-apt-install curl
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
