class Photo < ActiveRecord::Base
  mount_uploader :photo_path, PhotoUploader
  belongs_to :album

  validates :photo_path, presence: true
  validates :album_id, presence: true, uniqueness: { scope: :photo_path }

  before_destroy :remember_image
  after_destroy :remove_img

  protected
  def remember_image
    @image_name = self[:photo_path]
  end

  def remove_img
    File.delete("#{APP_ROOT.join('public', 'uploads')}/#{@image_name}")
    File.delete("#{APP_ROOT.join('public', 'uploads')}/thumb_#{@image_name}")
  end
end
