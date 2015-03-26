class Post < ActiveRecord::Base
  before_save :generate_slug
  belongs_to :user
  has_many :posts_tags
  has_many :tags, through: :posts_tags

  validates :title, uniqueness: { scope: :user_id, message: "already exists" },
                    presence: true, length: { minimum: 4, maximum: 32 },
                    format: /[a-zA-Z0-9_\.]+/
  validates :content, presence: true

  def generate_slug
    self.slug = self.title.parameterize if self.slug.nil?
  end

  def get_tags_string
    string = ""
    self.tags.each do |x|
      string << x.name << ","
    end
    string[0, string.length - 1]
  end
end