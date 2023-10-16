
#s3 bucket A  with ownership control and ACL
resource "aws_s3_bucket" "s3-bucket_a" {
  bucket = var.s3-bucket-a

}

resource "aws_s3_bucket_ownership_controls" "s3-bucket_a" {
  bucket = aws_s3_bucket.s3-bucket_a.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3-bucket_a" {
  depends_on = [aws_s3_bucket_ownership_controls.s3-bucket_a]

  bucket = aws_s3_bucket.s3-bucket_a.id
  acl    = "private"
}


#s3 bucket B with ownership control and ACL

resource "aws_s3_bucket" "s3-bucket_b" {
  bucket = var.s3-bucket-b

}

resource "aws_s3_bucket_ownership_controls" "s3-bucket_b" {
  bucket = aws_s3_bucket.s3-bucket_b.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3-bucket_b" {
  depends_on = [aws_s3_bucket_ownership_controls.s3-bucket_b]

  bucket = aws_s3_bucket.s3-bucket_b.id
  acl    = "private"
}

#S3 event trigger for Lambda
resource "aws_lambda_permission" "bucket_a_trigger" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "s3.amazonaws.com"

  source_arn = aws_s3_bucket.s3-bucket_a.arn
}
