class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :name, presence: true
  validates :user_id, presence: true

  def random_thumb
    if photos.empty?
      "http://placehold.it/250x250"
    else
      photos.sample.photo_path.thumb.url
    end
  end
end
