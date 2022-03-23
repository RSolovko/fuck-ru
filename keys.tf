resource "aws_key_pair" "ssh" {
    key_name   = random_uuid.id.result
    public_key = tls_private_key.t.public_key_openssh
}
provider "tls" {}
resource "tls_private_key" "t" {
    algorithm = "RSA"
}
provider "local" {}
resource "local_file" "key" {
    content  = tls_private_key.t.private_key_pem
    filename = "id_rsa.${var.aws_region}"
    provisioner "local-exec" {
        command = "chmod 600 id_rsa.${var.aws_region}"
    }
}
