variable "name" { type = string }
variable "location" { type = string }
variable "tags" { 
  type = map(string)
  default = { Environment = "Dev", Project = "MTech-AVD" }
}
