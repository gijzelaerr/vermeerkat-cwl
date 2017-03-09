cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: DockerRequirement
    dockerImageId: vermeerkat/casa_flagdata
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.vis)
        writable: true
      - entryname: parameters.json
        entry: $(JSON.stringify(inputs))

baseCommand: "/usr/local/bin/casawrap.py"
arguments: ["flagdata"]

outputs:
  ms:
    type: Directory
    outputBinding:
      glob: $( inputs.vis.basename )

inputs:
  vis:
    type: Directory
    doc: "Name of MS file or calibration table"
  mode:
    type:
      - "null"
      - type: enum
        symbols: [manual, list, clip, quack, shadow, elevation, tfcrop, extend, unflag, summary]
    doc: "Flagging mode"
    default: manual
  field:
    type: string?
    doc: "Field names or field index numbers:'' ==> all, field='0~2,3C286'"
  spw:
    type: string?
    doc: "Spectral-window/frequency/channel: '' ==> all, spw='0:17~19'"
  antenna:
    type: string?
    doc: "Antenna/baselines: '' ==> all, antenna ='3,VA04'"
  timerange:
    type: string?
    doc: "Time range: '' ==> all,timerange='09:14:0~09:54:0'"
  correlation:
    type: string?
    doc: "Correlation: '' ==> all, correlation='XX,YY'"
  scan:
    type: string?
    doc: "Scan numbers: '' ==> all"
  intent:
    type: string?
    doc: "Observation intent: '' ==> all, intent='CAL*POINT*'"
  array:
    type: string?
    doc: "(Sub)array numbers: '' ==> all"
  uvrange:
    type: string?
    doc: "UV range: '' ==> all; uvrange ='0~100klambda', default units=meters"
  observation:
    type: string?
    doc: "Observation ID: '' ==> all"
  feed:
    type: string?
    doc: " Multi-feed numbers: Not yet implemented"
  autocorr:
    type: boolean?
    doc: "Flag only the auto-correlations"
    default: False
  inpfile:
    type:
      - "null"
      - File
      - type: array
        items: string
    doc: "Input ASCII file, list of files or Python list of strings with flag commands"
  reason:
    type:
      - "null"
      - type: array
        items: string
    doc: "Select by REASON types"
  tbuff:
    type:
      - "null"
      - type: array
        items: float
    doc: "List of time buffers (sec) to pad timerange in flag commands"
  datacolumn:
    type: string?
    doc: "Data column on which to operate (data,corrected,model,weight,etc.)"
    default: corrected
  clipminmax:
    type:
      - "null"
      - type: array
        items: float
    doc: "Range to use for clipping"
  clipoutside:
    type: boolean?
    doc: "Clip outside the range, or within it"
    default: True
  channelavg:
    type: boolean?
    doc: "Average over channels (scalar average)"
    default: False
  clipzeros:
    type: boolean?
    doc: "Clip zero-value data"
    default: False
  quackinterval:
    type: float?
    doc: "Quack n seconds from scan beginning or end"
    default: 0.0
  quackmode:
    type:
      - "null"
      - type: enum
        symbols: [beg, endb, end, tail]
    doc: "Quack mode. 'beg' ==> first n seconds of scan.'endb' ==> last n seconds of scan. 'end' ==> all but first n seconds of scan. 'tail' ==> all but last n seconds of scan."
    default: beg
  quackincrement:
    type: boolean?
    doc: "Flag incrementally in time?"
    default: False
  tolerance:
    type: float?
    doc: "Amount of shadow allowed (in meters)"
    default: 0.0
  addantenna:
    type: File?
    doc: "File name or dictionary with additional antenna names, positions and diameters"
  lowerlimit:
    type: int?
    doc: "Lower limiting elevation (in degrees)"
    default: 0
  upperlimit:
    type: int?
    doc: "Upper limiting elevation (in degrees)"
    default: 90
  ntime:
    type:
      - "null"
      - float
      - int
      - string
    doc: "Time-range to use for each chunk (in seconds or minutes)"
    default: scan
  combinescans:
    type: boolean?
    doc: "Accumulate data across scans depending on the value of ntime."
    default: False
  timecutoff:
    type: float?
    doc: "Flagging thresholds in units of deviation from the fit"
    default: 4.0
  freqcutoff:
    type: float?
    doc: "Flagging thresholds in units of deviation from the fit"
    default: 3.0
  timefit:
    type:
      - "null"
      - type: enum
        symbols: [poly, line]
    doc: "Fitting function for the time direction (poly/line)"
    default: line
  freqfit:
    type:
      - "null"
      - type: enum
        symbols: [poly, line]
    doc: "Fitting function for the frequency direction (poly/line)"
    default: poly
  maxnpieces:
    type: int?
    doc: "Number of pieces in the polynomial-fits (for 'freqfit' or 'timefit' ='poly')"
    default: 7
  flagdimension:
    type:
      - "null"
      - type: enum
        symbols: [freq, time, freqtime, timefreq]
    doc: "Dimensions along which to calculate fits (freq/time/freqtime/timefreq)"
    default: freqtime
  usewindowstats:
    type:
      - "null"
      - type: enum
        symbols: [none, sum, std, both]
    doc: "Calculate additional flags using sliding window statistics (none,sum,std,both)"
    default: none
  halfwin:
    type: int?
    doc: "Half-width of sliding window to use with 'usewindowstats' (1,2,3)."
    default: 1
  extendflags:
    type: boolean?
    doc: "Extend flags along time, frequency and correlation."
    default: True
  extendpols:
    type: boolean?
    doc: "If any correlation is flagged, flag all correlations"
    default: True
  growtime:
    type: float?
    doc: "Flag all 'ntime' integrations if more than X% of the timerange is flagged (0-100)"
    default: 50.0
  growfreq:
    type: float?
    doc: "Flag all selected channels if more than X% of the frequency range is flagged(0-100)"
    default: 50.0
  growaround:
    type: boolean?
    doc: "Flag data based on surrounding flags"
    default: False
  flagneartime:
    type: boolean?
    doc: "Flag one timestep before and after a flagged one (True/False)"
    default: False
  flagnearfreq:
    type: boolean?
    doc: "Flag one channel before and after a flagged one (True/False)"
    default: False
  minrel:
    type: float?
    doc: "minimum number of flags (relative)"
    default: 0.0
  maxrel:
    type: float?
    doc: "maximum number of flags (relative)"
    default: 1.0
  minabs:
    type: int?
    doc: "minimum number of flags (absolute)"
    default: 0
  maxabs:
    type: int?
    doc: "maximum number of flags (absolute). Use a negative value to indicate infinity."
    default: -1
  spwchan:
    type: boolean?
    doc: "Print summary of channels per spw"
    default: False
  spwcorr:
    type: boolean?
    doc: "Print summary of correlation per spw"
    default: False
  basecnt:
    type: boolean?
    doc: "Print summary counts per baseline"
    default: False
  name:
    type: string?
    doc: "Name of this summary report (key in summary dictionary)"
    default: Summary
  action:
    type:
      - "null"
      - type: enum
        symbols: [none, apply, calculate]
    doc: "Action to perform in MS and/or in inpfile (none/apply/calculate)"
  display:
    type:
      - "null"
      - type: enum
        symbols: [data, report, both]
    doc: "Display data and/or end-of-MS reports at runtime (data/report/both)."
  flagbackup:
    type: boolean?
    doc: "Back up the state of flags before the run"
    default: True
  savepars:
    type: boolean?
    doc: "Save the current parameters to the FLAG_CMD table or to a file"
    default: False
  cmdreason:
    type: string?
    doc: "Reason to save to output file or to FLAG_CMD table."
  outfile:
    type: File?
    doc: "Name of output file to save current parameters. If empty, save to FLAG_CMD"
