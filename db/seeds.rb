# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create Public Wikis

10.times do Wiki.create!(
    title: Faker::Book.unique.title, 
    body: RandomData.random_paragraph
    )
end

# Create Private Wikis
10.times do Wiki.create!(
    title: Faker::Book.unique.title, 
    body: RandomData.random_paragraph, 
    private: true
    )
end

wikis = Wiki.all


#Create Users

15.times do 
    
    user = User.new(
        email: Faker::Internet.unique.email, 
        role: [0,1,2].sample, 
        password: 'password', 
        password_confirmation: 'password',
        confirmed_at: Faker::Time.between(DateTime.now - 1, DateTime.now)
    )
    user.skip_confirmation!
    user.save!
end
users = User.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"