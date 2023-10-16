# Define an AWS data source for IAM policy document

data "aws_iam_policy_document" "s3_access_policy" {
  statement {
    actions = ["s3:GetObject", "s3:PutObject"]
    effect  = "Allow"

    resources = [
      "arn:aws:s3:::s3-bucket-a/*", 
      "arn:aws:s3:::s3-bucket-a/*"
    ]
  }
}

# Create an IAM role for Lambda and attach the inline policy
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name   = "lambda_s3_policy"
    policy = data.aws_iam_policy_document.s3_access_policy.json
  }
}
