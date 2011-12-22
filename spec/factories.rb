# User symbol :user get Factory Girl to simulate teh User model.
Factory.define :user do |user|
    user.first_name             "Example"
    user.last_name              "User"
    user.email                  "example@example.com"
    user.password               "foobar"
    user.password_confirmation  "foobar"
end

Factory.define :sender, :parent => :user do |sender|
    sender.email                "sender@example.com"
end

Factory.define :recipient, :parent => :user do |recipient|
    recipient.email             "recipient@example.com"
end

Factory.sequence :email do |n|
    "person-#{n}@example.com"
end

Factory.define :card do |card|
    card.greeting       "Hello World!"
    card.sender         :sender
    card.recipient      :recipient
end
