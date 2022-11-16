# The Cloud Resume Challenge

## Summary

Source code for [The Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/the-challenge/).

Combines boilerplate from their [Codepen example](https://codepen.io/emzarts/pen/OXzmym) with an exported HTML MS Word resume.

## Setup
* aws-cli
```bash
# install
brew update && brew install awscli

# config
aws configure
```

## Usage
* aws-cli
```bash
# create a bucket (globally unique name w/kebab-case)
bucket_name="pythoninthegrass-cloud-resume"
aws s3 mb s3://${bucket_name}

# list buckets
aws s3 ls

# enable website
aws s3 website s3://${bucket_name} --index-document index.html --error-document error.html

# set permissions
aws s3api put-bucket-acl --bucket $bucket_name --acl public-read
aws s3api put-bucket-policy --bucket $bucket_name --policy file://app/policy_s3.json

# sync via aws cli
aws s3 sync app/ s3://${bucket_name}

# delete files
aws s3 rm s3://${bucket_name}/policy_s3.json.example
```

## TODO
* Outstanding steps: 5 - 16  
  5. ~~[HTTPS](https://cloudresumechallenge.dev/docs/the-challenge/aws/#5-https)~~  
    * Currently the built-in _ugly_ [ACM URL](https://d25082olbhf53e.cloudfront.net)  
    * Either setup `aws_acm_certificate` or use [Namecheap TF provider](https://registry.terraform.io/providers/namecheap/namecheap/latest/docs) to link custom/non-AWS Route53 domain  
  6. DNS
  7. Javascript
  8. Database
  9.  API
  10. Python
  11. Tests
  12. Infrastructure as Code
  13. ~~Source Control~~
  14. CI/CD (Front end)
  15. Blog post
* DevOps Flavor
  * [Terraform](https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/)

## Further Reading
[Quick setup - AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

[Hosting a static website using Amazon S3 - Amazon Simple Storage Service](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)

[AWS Certified Cloud Practitioner 2020 - A Cloud Guru](https://learn.acloud.guru/course/aws-certified-cloud-practitioner)

[Setting Up an S3 Static Website Using AWS CLI | A Cloud Guru](https://acloudguru.com/hands-on-labs/setting-up-an-s3-static-website-using-aws-cli)

[Hosting an Angular application on Amazon S3 using GitHub Actions - DEV Community 👩‍💻👨‍💻](https://dev.to/rodrigokamada/hosting-an-angular-application-on-amazon-s3-using-github-actions-3h6g)

[PX to REM Converter Online](https://codebeautify.org/px-to-rem-converter)
