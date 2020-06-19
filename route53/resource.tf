provider "aws" {
  region = "${var.region}"
}

resource "aws_route53_record" "Root-A-Record" {
  zone_id = "${var.HostedZoneID}"
  name = "${var.rootDomain}"
  type = "A"
  alias {
    name = "${var.s3RootWebsiteDomain}"
    zone_id = "${var.s3RootWebsiteHostedZoneID}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "SubDomain-A-Record" {
  zone_id = "${var.HostedZoneID}"
  name = "${var.subDomain}"
  type = "A"
  alias {
    name = "${var.S3WebsiteSubDomain}"
    zone_id = "${var.s3RootWebsiteHostedZoneID}"
    evaluate_target_health = false
  }
}