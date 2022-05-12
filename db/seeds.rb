# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Article.destroy_all
Comment.destroy_all

user = User.create!(
        email: 'admin@example.com',
        password: 'password', 
        role: :admin
    )

first_id = Article.create!(
    title: Faker::Lorem.sentence(word_count: 3, supplemental: false, 
                                        random_words_to_add: 0).chop,
    body: Faker::Lorem.sentence(word_count: rand(10..25), supplemental: false,
                                        random_words_to_add: 0).chop,
    user_id: user.id
).id

25.times do |index| 
    user = User.create!(
        email: Faker::Internet.email,
        password: 'password'
    )

    article = Article.create!(
        title: Faker::Lorem.sentence(word_count: 3, supplemental: false, 
                                            random_words_to_add: 0).chop,
        body: Faker::Lorem.sentence(word_count: rand(10..25), supplemental: false,
                                            random_words_to_add: 0).chop,
        user_id: user.id
    )

    rand(1..5).times do
        Comment.create!(
            body: Faker::Lorem.sentence(word_count: rand(10..25), supplemental: false,
                                                random_words_to_add: 0).chop,
            user_id: user.id,
            article: Article.find(rand(first_id..(first_id+index)))                                           
        )
    end

    system('clear')
    print "Seeding in progress: \n"
    print '['
    (1..index).each do
        print '#'
    end

    ((index+1)..24).each do
        print '.'
    end
    print "]\n"
end

p "Created #{User.count} users, #{Article.count} articles, #{Comment.count} comments"