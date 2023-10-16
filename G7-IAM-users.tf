
# Create IAM resource user A and B 
resource "aws_iam_user" "user_a" {
  name = "User-A"
}

# Create IAM resource User B
resource "aws_iam_user" "user_b" {
  name = "User-B"
}

# create IAM policies for s3 bucket A 

resource "aws_iam_policy" "s3_policy_a" {
  name        = "s3_policy_a"
  description = "Policy for S3 Bucket A"

  policy = data.aws_iam_policy_document.s3_policy_a.json
}

# create IAM policies for s3 bucket B

resource "aws_iam_policy" "s3_policy_b" {
  name        = "s3_policy_b"
  description = "Policy for S3 Bucket B"

  policy = data.aws_iam_policy_document.s3_policy_b.json
}

#Define IAM policy document 

data "aws_iam_policy_document" "s3_policy_a" {
  statement {
    actions   = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::s3-bucket_a/*"]
  }
}

data "aws_iam_policy_document" "s3_policy_b" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::s3-bucket_b/*"]
  }
}

#attach policies to Users 

resource "aws_iam_policy_attachment" "attach_policy_user_a" {
  name       = "attach_policy_user_a"
  policy_arn = aws_iam_policy.s3_policy_a.arn
  users      = [aws_iam_user.user_a.name]
}

resource "aws_iam_policy_attachment" "attach_policy_user_b" {
  name       = "attach_policy_user_b"
  policy_arn = aws_iam_policy.s3_policy_b.arn
  users      = [aws_iam_user.user_b.name]
}
