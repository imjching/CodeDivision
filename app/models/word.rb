class Word < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  def anagrams
    Word.where(sorted_name: self.sorted_name)
  end
end