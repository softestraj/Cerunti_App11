class User < ActiveRecord::Base

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

   attr_accessible :first_name,:last_name,:email,:sex, :password
   acts_as_authentic do |config|
	   config.require_password_confirmation = false
	   config.login_field = :email

	   config.validates_format_of :email, :with => Authlogic::Regex.email, :message => I18n.t('error_messages.email_invalid', :default => I18n.t('models.users.should_be_email'))
	   config.validates_length_of_password_field_options = {:minimum => 6,  :if => :require_password?}
   end

   def name
   self.first_name + " " + self.last_name
   end
   
end
