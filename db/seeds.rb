# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Coment.destroy_all
Post.destroy_all
Tema.destroy_all
Foro.destroy_all
User.destroy_all

User.create(
  name: 'Marcelo',
  email: 'marcelo@gmail.com',
  password: '1234qwer',
  role: 'regular',
  email_confirmed: true,
  confirm_token: nil
)
User.create(
  name: 'Juan',
  email: 'hola@12.cl',
  password: '123456',
  role: 'admin',
  email_confirmed: true,
  confirm_token: nil
)
Foro.create(
  title: 'Tipical Chilean Food',
  description: 'Chilean gastronomy'
)
Foro.create(
  title: 'Games',
  description: 'All about Games'
)
Foro.create(
  title: 'Sports',
  description: 'Awesome food'
)
Foro.create(
  title: 'Movies',
  description: 'Behind camera and much more'
)
Foro.create(
  title: 'Plants',
  description: 'A complete universe of plants'
)
Foro.create(
  title: 'Pets',
  description: 'All about your favorites pets'
)

case Rails.env
when 'development'
  # Create Users
  5.times do
    User.create(
      name: Faker::Name.unique.first_name,
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password,
      role: 'regular',
      email_confirmed: true,
      confirm_token: nil
    )
  end
  User.create(
    name: 'Andres',
    email: 'jfcakhdk@uc.cl',
    password: '123456',
    role: 'regular',
    email_confirmed: true
  )
end

User.create(
  name: 'Pedro',
  email: 'juanfra.campos2@gmail.com',
  password: '123456',
  role: 'regular'
)
User.create(
  name: 'Cristobal',
  email: 'jfcampos1@uc.cl',
  password: '123456',
  role: 'regular'
)

# Create bets
user_ids = User.pluck(:id)
foros_ids = Foro.pluck(:id)
30.times do
  Tema.create(
    name: Faker::Name.title,
    description: Faker::StarWars.quote,
    foro_id: foros_ids.sample
  )
end

temas_ids = Tema.pluck(:id)
10.times do
  Post.create(
    title: Faker::Superhero.suffix,
    date: Time.zone.now,
    content: Faker::StarWars.quote,
    tema_id: temas_ids.sample,
    user_id: user_ids.sample
  )
end

posts_ids = Post.pluck(:id)
5.times do
  Coment.create(
    date: Time.zone.now,
    content: Faker::StarWars.quote,
    post_id: posts_ids.sample,
    user_id: user_ids.sample
  )
end
# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
