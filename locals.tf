
locals {
  s3_policy = jsonencode(
    {
      "Version" : "2008-10-17",
      "Id" : "PolicyForCloudFrontPrivateContent",
      "Statement" : [
        {
          "Sid" : "AllowCloudFrontServicePrincipal",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "cloudfront.amazonaws.com"
          },
          "Action" : "s3:GetObject",
          "Resource" : "${aws_s3_bucket.my_bucket.arn}/*",
          "Condition" : {
            "StringEquals" : {
              "AWS:SourceArn" : aws_cloudfront_distribution.s3_distribution.arn
            }
          }
        }
      ]
    }
  )
}
