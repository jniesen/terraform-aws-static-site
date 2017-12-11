data "archive_file" "src" {
  count       = "${var.deploy_content == "false" ? 0 : 1}"

  type        = "zip"
  source_dir  = "${var.site_source}"
  output_path = "source.zip"
}

resource "aws_s3_bucket" "src" {
  count       = "${var.deploy_content == "false" ? 0 : 1}"

  bucket = "source-${var.root_name}"
  acl    = "private"

  tags {
    Name = "source-${var.root_name}"
  }
}

resource "aws_s3_bucket_object" "src" {
  count       = "${var.deploy_content == "false" ? 0 : 1}"

  bucket = "${aws_s3_bucket.src.id}"
  key    = "source-${data.archive_file.src.output_md5}.zip"
  source = "source.zip"
  etag   = "${data.archive_file.src.output_md5}"
}

resource "aws_codebuild_project" "src" {
  count       = "${var.deploy_content == "false" ? 0 : 1}"

  environment {
    type         = "LINUX_CONTAINER"
    image        = "aws/codebuild/ubuntu-base:14.04"
    compute_type = "BUILD_GENERAL1_SMALL"
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  source {
    type = "S3"
    location = "${aws_s3_bucket_object.src.id}"
  }
}
