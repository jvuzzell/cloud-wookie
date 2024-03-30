resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = var.identity_pool_name
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id         = var.user_pool_client_id
    provider_name     = "cognito-idp.${var.aws_region}.amazonaws.com/${var.user_pool_id}"
    server_side_token_check = false
  }
}

resource "aws_iam_role" "authenticated_role" {
  name = "${var.identity_pool_name}_authenticated_role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRoleWithWebIdentity",
        Effect    = "Allow",
        Principal = {
          Federated = "cognito-identity.amazonaws.com"
        },
        Condition = {
          "StringEquals": {
            "cognito-identity.amazonaws.com:aud": aws_cognito_identity_pool.main.id
          },
          "ForAnyValue:StringLike": {
            "cognito-identity.amazonaws.com:amr": "authenticated"
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "authenticated_policy" {
  name = "${var.identity_pool_name}_authenticated_policy"
  role = aws_iam_role.authenticated_role.id

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action   = "secretsmanager:GetSecretValue",
        Effect   = "Allow",
        Resource = "*"
      },
    ]
  })
}

resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = aws_cognito_identity_pool.main.id

  roles = {
    "authenticated" = aws_iam_role.authenticated_role.arn
  }
}
