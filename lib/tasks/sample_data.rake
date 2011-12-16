require 'faker'

namespace :db do
    desc "Fill database with sample data"

    task :populate => :environment do
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
    end
end
