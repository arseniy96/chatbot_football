CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
      provider:                         ENV.fetch('GOOGLE_PROVIDER'),
      google_storage_access_key_id:     ENV.fetch('GOOGLE_ACCESS_KEY_ID'),
      google_storage_secret_access_key: ENV.fetch('GOOGLE_SECRET_ACCESS_KEY')
  }
  config.fog_directory = 'chatbot_football'
end