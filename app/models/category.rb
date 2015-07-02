class Category < ActiveRecord::Base
  before_save :generate_slug
  has_many :posts

  def generate_slug
    self.slug = self.name.parameterize if self.slug.nil?
  end
end