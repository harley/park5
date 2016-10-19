OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '180807378662921', '2084f4f8ab99ed89b44dc3a7e91f3c70',
	scope: 'email,public_profile', display: 'popup'
end