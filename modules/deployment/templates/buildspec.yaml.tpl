version: 0.2
env:
  variables:
    ROOT_BUCKET: "${dest_bucket}"
phases:
  build:
    commands:
      - echo Entered build phase ...
      - echo Build started on `date`
