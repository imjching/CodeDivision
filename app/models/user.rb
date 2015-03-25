require 'bcrypt'

class User < ActiveRecord::Base

  validates :email, uniqueness: true,
                    presence: true,
                    format: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/,
                    length: { maximum: 100 }
  validates :full_name, presence: true, length: { minimum: 4 }

  def self.create(params)
    params.delete("retype_password")
    password_salt = BCrypt::Engine.generate_salt
    params[:password] = BCrypt::Engine.hash_secret(params[:password], password_salt)
    params[:password_salt] = password_salt
    super(params)
  end

  def self.authenticate(params)
    user = User.find_by_email(params[:email])
    return nil if user.nil?
    return user if user.password == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
    return nil
  end
end