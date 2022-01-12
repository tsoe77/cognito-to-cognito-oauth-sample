# app1 pool
resource "aws_cognito_user_pool" "app1" {
  name                     = var.app1_user_pool_name
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
}

resource "aws_cognito_user_pool_domain" "app1" {
  domain       = var.app1_domain_name
  user_pool_id = aws_cognito_user_pool.app1.id
}

resource "aws_cognito_user_pool_client" "app1_client1" {
  name                                 = "app1_client1"
  user_pool_id                         = aws_cognito_user_pool.app1.id
  allowed_oauth_flows_user_pool_client = true
  # generate_secret      = true
  allowed_oauth_flows  = ["code"]
  allowed_oauth_scopes = ["openid"]
  callback_urls = [
    "https://${var.app2_domain_name}.auth.${var.aws_region}.amazoncognito.com/oauth2/idpresponse",
  ]
  logout_urls                   = ["http://localhost:8001"]
  prevent_user_existence_errors = "ENABLED"
  supported_identity_providers  = ["COGNITO"]
}

resource "aws_cognito_user_pool_ui_customization" "app1_client1" {
  client_id = aws_cognito_user_pool_client.app1_client1.id

  css          = file("custom-cognito-hosted-ui.css")
  image_file   = filebase64("logo.png")
  user_pool_id = aws_cognito_user_pool_domain.app1.user_pool_id
}

# app2 pool
resource "aws_cognito_user_pool" "app2" {
  name                     = var.app2_user_pool_name
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
}

resource "aws_cognito_user_pool_domain" "app2" {
  domain       = var.app2_domain_name
  user_pool_id = aws_cognito_user_pool.app2.id
}

resource "aws_cognito_user_pool_client" "app2_client1" {
  name                                 = "app2_client1"
  user_pool_id                         = aws_cognito_user_pool.app2.id
  allowed_oauth_flows_user_pool_client = true
  # generate_secret      = true
  allowed_oauth_flows  = ["code"]
  allowed_oauth_scopes = ["openid"]
  callback_urls = [
    "http://localhost:8002",
  ]
  logout_urls                   = ["http://localhost:8002"]
  prevent_user_existence_errors = "ENABLED"
  supported_identity_providers  = [var.provider_name, "COGNITO"]

  depends_on = [aws_cognito_identity_provider.app2_provider]
}

# app2 Integration

resource "aws_cognito_identity_provider" "app2_provider" {
  user_pool_id  = aws_cognito_user_pool.app2.id
  provider_name = var.provider_name
  provider_type = var.provider_type

  provider_details = {
    attributes_url_add_attributes = false
    client_id                     = aws_cognito_user_pool_client.app1_client1.id
    # client_secret                 = aws_cognito_user_pool_client.app1_client1.client_secret
    attributes_request_method = "GET"
    authorize_scopes          = "openid"
    oidc_issuer               = "https://cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.app1.id}"
    authorize_url             = "https://${var.app1_domain_name}.auth.${var.aws_region}.amazoncognito.com/oauth2/authorize"
    token_url                 = "https://${var.app1_domain_name}.auth.${var.aws_region}.amazoncognito.com/oauth2/token"
    attributes_url            = "https://${var.app1_domain_name}.auth.${var.aws_region}.amazoncognito.com/oauth2/userInfo"
    jwks_uri                  = "https://cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.app1.id}/.well-known/jwks.json"
  }

  attribute_mapping = {
    email          = "email"
    username       = "sub"
    email_verified = "email_verified"
  }

  depends_on = [
    aws_cognito_user_pool_domain.app1,
    aws_cognito_user_pool_client.app1_client1
  ]
}
