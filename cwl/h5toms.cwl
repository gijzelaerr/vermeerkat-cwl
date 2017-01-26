cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerImageId: vermeerkat/h5toms
baseCommand: [h5toms.py, -o, result.ms]
inputs:
  h5:
    type: File
    inputBinding:
      position: 1
outputs:
  ms:
    type: Directory
    outputBinding:
      glob: "result.ms"
