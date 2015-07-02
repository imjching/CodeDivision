require 'uri'

URI_LENGTH = 7

class Url < ActiveRecord::Base
  before_save :generate_short_uri
  belongs_to :user
  validates :redirect_url, presence: true, format: URI::regexp(%w(http https))
  validates_uniqueness_of :redirect_url, scope: :user_id

  def url_visit
    self.click_count += 1
    self.save
  end

  private

  def generate_short_uri
    unless self.short_uri
      while self.short_uri.nil? || Url.where(short_uri: self.short_uri).count == 1
        self.short_uri = [*'0'..'9',*'A'..'Z',*'a'..'z'].sample(URI_LENGTH).join
      end
    end
  end
end