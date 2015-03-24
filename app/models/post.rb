class Post < ActiveRecord::Base
  before_save :generate_secret_key_and_slug
  belongs_to :category

  validates :title, uniqueness: true, presence: true, length: { minimum: 4, maximum: 32 }, format: /[a-zA-Z0-9_\.]+/
  validates :content, presence: true
  validates :author_email, presence: true, format: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/

  def generate_secret_key_and_slug
    self.author_key = SecureRandom.uuid if self.author_key.nil?
    self.slug = self.title.parameterize if self.slug.nil?
  end
end