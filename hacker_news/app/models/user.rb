class User < ActiveRecord::Base
  before_save :update_password
  has_many :posts

  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 20 }
  validates :password, presence: true, length: { minimum: 4, maximum: 20 }

  def self.authenticate(params)
    user = User.find_by_username(params[:username])
    if user && user.password == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
      user
    else
      nil
    end
  end

  private
  def update_password
    password_salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(self.password, password_salt)
    self.password_salt = password_salt
  end
end
