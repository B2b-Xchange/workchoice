OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :facebook, ENV['OA_FACEBOOK_ID'], ENV['OA_FACEBOOK_SECRET'],
#           :scope => 'email,public_profile', :display => 'popup'
  provider :linkedin, ENV['OA_LINKEDIN_ID'], ENV['OA_LINKEDIN_SECRET'],
           :scope => 'r_basicprofile r_emailaddress',
           :fields => ["first-name", "last-name", "email-address"]
  provider :xing, ENV['OA_XING_ID'], ENV['OA_XING_SECRET']
  
end
