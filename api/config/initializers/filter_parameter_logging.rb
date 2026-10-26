# Keep sensitive values out of logs (UU PDP). Matching is by partial key name,
# so nested keys such as authentication[password] are filtered too.
Rails.application.config.filter_parameters += [
  :password, :passw, :secret, :token, :authorization, :email,
  :_key, :crypt, :salt, :certificate, :otp, :ssn
]
