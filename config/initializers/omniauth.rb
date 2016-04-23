OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '232020127155218', '201b7050b52e48a6d879a9544b0d5060',
           :scope => 'email,public_profile', :display => 'popup'
  provider :linkedin, '77wods3i15m22h', '3gs5fGTo86gMD91o',
           :scope => 'r_basicprofile r_emailaddress',
           :fields => ["first-name", "last-name", "email-address"]
  
end