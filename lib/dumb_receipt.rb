module DumbReceipt
  module JSON

    AUTH_SUCCESS = <<-JSON
      {
        "auth_token": "examplecu9ouV74T56dZAbJcHv1IYeciaamyj",
        "user":  {
          "email":  "alice@example.com",
          "name":  "Alice"
        }
      }
    JSON

    AUTH_FAILURE = <<-JSON
      {
        "error": {
          "type": "MissingRequiredField",
          "message": "Email address field is missing."
        }
      }
    JSON
  end
end
