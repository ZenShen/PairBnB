Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FBOOK_KEY'], ENV['FBOOK_SECRET']
end