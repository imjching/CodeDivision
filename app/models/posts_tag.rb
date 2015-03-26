class PostsTag < ActiveRecord::Base
  belongs_to :tag, dependent: :destroy
  belongs_to :post, dependent: :destroy

  validates :tag_id, uniqueness: { scope: :post_id, message: "already exists for this post" }
end