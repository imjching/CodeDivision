require 'faker'

ActiveRecord::Base.transaction do
  10.times do
    Category.create(name: Faker::Commerce.department)
  end

  30.times do
    Post.create(title: Faker::Commerce.product_name,
                content: Faker::Lorem.sentence(100),
                author_email: Faker::Internet.email,
                category_id: rand(10) + 1)
  end
end
