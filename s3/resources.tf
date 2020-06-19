provider "aws" {
  region = "${var.region}"
}


#root domain allow all s3 gets from internet
resource "aws_s3_bucket" "MyWebsiteRootDomain" {
  bucket = "${var.rootDomain}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetBucketObject",
      "Effect": "Allow",
      "Principal": "*" ,

      "Action": ["s3:GetObject"],
      "Resource": ["arn:aws:s3:::${var.rootDomain}/*" ]
    }
  ]
}
EOF

  tags {
    Name = "RootDomainWebsite"
  }
}

#redirect to root domain by excluding www
resource "aws_s3_bucket" "MyWebsiteSubDomain" {
  bucket = "${var.subDomain}"


  website {
    redirect_all_requests_to = "${var.rootDomain}"
  }
  tags {
    Name = "SubDomainWebsite"
  }

}


resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.MyWebsiteRootDomain.id}"
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"

}
