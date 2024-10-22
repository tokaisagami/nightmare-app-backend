# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: 'user1@example.com', password: 'password')
User.create(email: 'user2@example.com', password: 'password')

Nightmare.create(user_id: 1, description: '悪夢の説明１', modified_description: '改変後の説明１', ending_type: 'ハッピーエンド', published: true)
Nightmare.create(user_id: 2, description: '悪夢の説明２', modified_description: '改変後の説明２', ending_type: 'バッドエンド', published: false)
