class Post < ActiveRecord::Base
  before_save :generate_slug
  belongs_to :user
  has_many :tags, dependent: :destroy

  validates :title, uniqueness: { scope: :user_id, message: "already exists" },
                    presence: true, length: { minimum: 4, maximum: 32 },
                    format: /[a-zA-Z0-9_\.]+/
  validates :content, presence: true

  def generate_slug
    self.slug = self.title.parameterize if self.slug.nil?
  end

  def get_tags_string
    string = ""
    tags.each { |x| string << x.name << "," }
    string[0...-1]
  end
end