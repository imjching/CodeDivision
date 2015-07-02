class Word < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  before_save :generate_sorted_name

  def generate_sorted_name
    self.sorted_name = self.name.downcase.split(//).sort.join
  end

  def anagrams
    Word.where(sorted_name: self.sorted_name)
  end
end