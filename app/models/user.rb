class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :lockable, :timeoutable,
         :omniauthable, omniauth_providers: [:facebook]

  validates_presence_of :username

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      byebug
      user.email = auth.info.email || ""
      user.username = auth.info.name.parameterize
      user.name = auth.info.name
      # TODO: sent this to email
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.image
      # skip the confirmation emails
      # user.skip_confirmation!
    end
  end
end
