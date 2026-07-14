output "api_id" {
  description = "ID of the HTTP API."
  value       = aws_apigatewayv2_api.this.id
}

output "api_endpoint" {
  description = "Endpoint URL for the HTTP API."
  value       = aws_apigatewayv2_api.this.api_endpoint
}
