#create lambda function 

resource "aws_lambda_function" "lambda_function" {
  filename = file("${path.module}/lambda_function.py")
  function_name = "image_proccessor"
  runtime = "python3.9"
  handler = "lambda_function.handler"
  role = aws_iam_role.lambda_role.arn
}



