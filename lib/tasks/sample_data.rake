
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

        tags = %w[ christmas birthday graduation congratulations ]
        tags.each do |tag|
            Tag.create(:tag => tag)
        end

        # Create the templates.
        image_files = Dir.glob("app/assets/images/card_images/*").map do |image_file| 
            image_file.gsub(/app\/assets\/images\/card_images\//, "") 
        end

        image_files.each do |image_file_name|
            template = Template.create!(:image_name => image_file_name)
            template.tags << Tag.find(Random.rand(tags.size) + 1)           # Add a random tag
            template.save
        end

        User.all(:limit => 30).each do |user|
            10.times do 

                card = user.sent_cards.create!(
                    :greeting => Faker::Lorem.sentence(5)[0..40], 
                    :template => Template.find(Random.rand(image_files.size)+1),
                    :recipient => User.find(Random.rand(30)+1),
                    :hash_value => "#{Time.now}#{Faker::Lorem.sentence(5)[0..40]}".hash)
                5.times do 
                    sig = Signature.new(:signer_id => User.find(Random.rand(30) + 1).id)
                    if Random.rand(2) == 1
                        sig.signed = true
                        sig.message =  Faker::Lorem.sentence(5)[0..40]
                    end
                    card.signatures << sig
                    sig.save
                    card.save
                end
            end
        end
    end
end
