resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "ScoresDatabase"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Id"

  attribute {
    name = "Id"
    type = "S"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "score-bucket-csv-firstname-birthday"

  tags = {
    Name        = "Scores Bucket"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = "scores.csv"
  acl    = "private"  
  source = "/home/ec2-user/terraform/scores.csv"
  etag = filemd5("/home/ec2-user/terraform/scores.csv")
  content_type = "text/csv"
}

/*
resource "aws_s3_bucket_object" "object2" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = "new_scores"
  acl    = "private"  
  source = "/home/ec2-user/terraform/new_scores.csv"
  etag = filemd5("/home/ec2-user/terraform/new_scores.csv")
  content_type = "text/csv"
}
*/
