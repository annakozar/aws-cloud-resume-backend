resource "aws_dynamodb_table" "ddbtable" {
  name             = "visitors_counter"
  hash_key         = "id"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  
  attribute {
    name = "id"
    type = "S"
  } 
}
