output "hello_world" {
  value = "hello Avi Demo"
}

resource "null_resource" "test_directory" {
  provisioner "local-exec" {
    command = "pwd"
  }
}
