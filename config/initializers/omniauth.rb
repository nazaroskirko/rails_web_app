OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_OAUTH_CLIENT'], ENV['GOOGLE_OAUTH_SECRET'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}, access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',prompt: "consent"}
end
