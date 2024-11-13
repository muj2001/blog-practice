# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create Categories
categories = [ 'Technology', 'Health', 'Lifestyle', 'Business', 'Education' ]
categories.each do |category|
  Category.create!(name: category)
end

# Create Users
users = [
  { name: 'John Doe', email: 'john@example.com', password: 'password123', password_confirmation: 'password123' },
  { name: 'Jane Smith', email: 'jane@example.com', password: 'password123', password_confirmation: 'password123' },
  { name: 'Alice Johnson', email: 'alice@example.com', password: 'password123', password_confirmation: 'password123' },
  { name: 'Bob Brown', email: 'bob@example.com', password: 'password123', password_confirmation: 'password123' }
]

users.each do |user|
  User.create!(user)
end

# Create Posts
users.each_with_index do |user, index|
  category = Category.all.sample  # Select a random category
  Post.create!(
    title: "Post Title #{index + 1}",
    body: "This is the content of post #{index + 1}. It belongs to the #{category.name} category.",
    user_id: User.find_by(email: user[:email]).id,
    category_id: category.id
  )
end

# Create Comments
posts = Post.all
users = User.all

posts.each do |post|
  # Randomly assign users to comment on posts
  rand(1..3).times do
    Comment.create!(
      body: "This is a comment on #{post.title}.",
      user_id: users.sample.id,
      post_id: post.id
    )
  end
end

puts "Seed data created successfully!"
