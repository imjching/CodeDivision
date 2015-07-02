class User < ActiveRecord::Base
  before_save :update_password
  has_many :albums

  validates :email, presence: true,
                    uniqueness: true,
                    format: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/,
                    length: { maximum: 100 }
  validates :password, presence: true, length: { minimum: 4 }
  validates :full_name, presence: true, length: { minimum: 4 }

  def self.authenticate(params)
    user = User.find_by_email(params[:email])
    user && user.password == BCrypt::Engine.hash_secret(params[:password], user.password_salt) ? user : nil
  end

  def create_default_album
    albums.create(name: "Default album")
  end

  def photo_count
    count = 0
    albums.each do |album|
      count += album.photos.count
    end
    count
  end

  private
  def update_password
    password_salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(self.password, password_salt)
    self.password_salt = password_salt
  end
end
