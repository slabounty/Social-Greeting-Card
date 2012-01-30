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

Factory.define :signer, :parent => :user do |signer|
    signer.email             "signer@example.com"
end

Factory.define :admin, :parent => :user do |admin|
    admin.admin             true
end

Factory.sequence :email do |n|
    "person-#{n}@example.com"
end

Factory.define :template do |template|
    template.image_name     "birthday_cake.jpeg"
end

Factory.define :card do |card|
    card.greeting           "Hello World!"
    card.sender             :sender
    card.recipient          :recipient
    card.template           :template
    card.hash_value         "abcdef123456"
end

Factory.define :tag do |tag|
    tag.tag                 "congratulations"
end

Factory.define :signature do |signature|
    signature.signer        :signer
    signature.card          :card
    signature.message       "congratulations"
end
