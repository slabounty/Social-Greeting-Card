
namespace :db do
    desc "Fill database with sample data"

    task :populate => :environment do
        require 'faker'
        Rake::Task['db:reset'].invoke
        admin = User.create!(:first_name => "Example",
                     :last_name => "User",
                     :email => "example@railstutorial.org",
                     :password => "foobar",
                     :confirmation_password => "foobar")
        admin.toggle!(:admin)
        99.times do |n|
            first_name = Faker::Name.first_name
            last_name = Faker::Name.last_name
            email = "example-#{n+1}@railstutorial.org"
            password = "password"
            User.create!(:first_name => first_name,
                         :last_name => last_name,
                         :email => email,
                         :password => password,
                         :password_confirmation => password)


        end

        User.all(:limit => 30).each do |user|
            10.times do 
                user.sent_cards.create!(:greeting => Faker::Lorem.sentence(5)[0..40], :recipient => User.find(Random.rand(30)+1))
                # user.sent_cards.create!(:greeting => "Hello from #{user.first_name}", :recipient => User.find(Random.rand(30)+1))
            end
        end
    end
end
