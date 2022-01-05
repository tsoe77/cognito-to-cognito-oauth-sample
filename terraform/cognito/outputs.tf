output "app1" {
  description = "app1 outputs"
  value = {
    user_pool_id    = aws_cognito_user_pool.app1.id
    app1_client1_id = aws_cognito_user_pool_client.app1_client1.id
  }
}

output "app2" {
  description = "app2 outputs"
  value = {
    user_pool_id      = aws_cognito_user_pool.app2.id
    app2_client1_id   = aws_cognito_user_pool_client.app2_client1.id
    app2_provider_id  = aws_cognito_identity_provider.app2_provider.id
    app2_oauth_domain = "${var.app2_domain_name}.auth.${var.aws_region}.amazoncognito.com"
  }
}
