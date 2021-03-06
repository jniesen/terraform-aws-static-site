data "archive_file" "src" {
  count = "${var.deploy_content == "false" ? 0 : 1}"

  type        = "zip"
  source_dir  = "${var.site_source}"
  output_path = "source.zip"
}

data "template_file" "buildspec" {
  count    = "${var.deploy_content == "false" ? 0 : 1}"
  template = "${file("${path.module}/templates/buildspec.yaml.tpl")}"

  vars {
    dest_bucket = "${var.root_name}"
  }
}

data "template_file" "service_policy" {
  count    = "${var.deploy_content == "false" ? 0 : 1}"
  template = "${file("${path.module}/templates/service_policy.json.tpl")}"

  vars {
    src_bucket  = "${aws_s3_bucket.src.id}"
    dest_bucket = "${var.root_name}"
  }
}

resource "aws_s3_bucket" "src" {
  count = "${var.deploy_content == "false" ? 0 : 1}"

  bucket     = "source-${var.root_name}"
  acl        = "private"

  versioning {
    enabled = "true"
  }

  tags {
    Name = "source-${var.root_name}"
  }
}

resource "aws_s3_bucket_object" "src" {
  count = "${var.deploy_content == "false" ? 0 : 1}"

  bucket = "${aws_s3_bucket.src.id}"
  key    = "source.zip"
  source = "source.zip"
  etag   = "${data.archive_file.src.output_md5}"
}

resource "aws_iam_role_policy" "build" {
  name   = "StaticSiteCodeBuildServicePolicy"
  role   = "${aws_iam_role.build.id}"
  policy = "${data.template_file.service_policy.rendered}"
}

resource "aws_iam_role" "build" {
  name = "StaticSiteCodeBuildServiceRole"
  assume_role_policy = "${file("${path.module}/files/assume_role_policy.json")}"
}

resource "aws_codebuild_project" "src" {
  count        = "${var.deploy_content == "false" ? 0 : 1}"
  name         = "${replace(var.root_name, ".", "-")}"
  service_role = "${aws_iam_role.build.arn}"

  environment {
    type         = "LINUX_CONTAINER"
    image        = "aws/codebuild/ubuntu-base:14.04"
    compute_type = "BUILD_GENERAL1_SMALL"
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  source {
    type      = "S3"
    location  = "${aws_s3_bucket.src.arn}/${aws_s3_bucket_object.src.id}"
    buildspec = "${data.template_file.buildspec.rendered}"
  }
}
