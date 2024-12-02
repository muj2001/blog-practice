# db/seeds.rb

# Create Users
users = User.create!([
  { name: "Alice Smith", email: "alice@example.com", password: "password123" },
  { name: "Bob Jones", email: "bob@example.com", password: "password123" },
  { name: "Charlie Brown", email: "charlie@example.com", password: "password123" },
  { name: "Admin", email: "admin@admin.com", password: "admin123", admin: true }
])

p "Seeded till Users."

# Create Categories
categories = Category.create!([
  { name: "Technology" },
  { name: "Health" },
  { name: "Lifestyle" },
  { name: "Education" },
  { name: "Travel" }
])

p "Seeded till Categories."

# Create Posts with Sections and assign Categories
posts = Post.create!([
  {
    title: "Exploring the Future of AI",
    user: users.first,
    sections: [
      Section.new(title: "Introduction", body: "Artificial intelligence is evolving quickly."),
      Section.new(title: "Current Trends", body: "AI is impacting various industries.")
    ]
  },
  {
    title: "Benefits of a Healthy Lifestyle",
    user: users.second,
    sections: [
      Section.new(title: "Why Health Matters", body: "Living a healthy lifestyle is essential."),
      Section.new(title: "Practical Tips", body: "Exercise, diet, and sleep all play a role.")
    ]
  },
  {
    title: "Top Travel Destinations for 2024",
    user: users.third,
    sections: [
      Section.new(title: "Continent: Europe", body: "Europe has a rich history and beautiful landscapes."),
      Section.new(title: "Continent: Asia", body: "Asia offers diverse cultures and experiences.")
    ]
  }
])

p "Seeded till posts."

# Associate Categories with Posts
posts[0].categories << [ categories[0], categories[3] ]   # "Exploring the Future of AI" linked with "Technology" and "Education"
posts[1].categories << [ categories[1], categories[2] ]   # "Benefits of a Healthy Lifestyle" linked with "Health" and "Lifestyle"
posts[2].categories << [ categories[4] ]                  # "Top Travel Destinations for 2024" linked with "Travel"

p "Seeded till categories and posts"

# Create Comments on Posts and Sections
comments = Comment.create!([
  {
    body: "Great insights! I can't wait to see what the future holds.",
    user: users.second,
    commentable: posts.first
  },
  {
    body: "This is very informative. Thanks for sharing!",
    user: users.third,
    commentable: posts.first
  },
  {
    body: "I agree with this point, especially about the importance of health.",
    user: users.first,
    commentable: posts.second
  },
  {
    body: "I love this blogger's posts.",
    user: users.first,
    commentable: users.second
  }
])

puts "Seed data successfully created with posts, categories, and associations!"
