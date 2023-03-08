# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# CREATE ADMIN USER
User.create(
    name: Rails.application.credentials.admin_user_name.presence || 'admin',
    email: Rails.application.credentials.admin_user_email.presence || 'admin@admin.com',
    password: Rails.application.credentials.admin_user_pass.presence || 'adminpass',
    role: User.roles[1]
)
  
#   puts "#{users.count} users created"