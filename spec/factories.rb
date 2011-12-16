# User symbol :user get Factory Girl to simulate teh User model.
Factory.define :user do |user|
    user.first_name             "Scott"
    user.last_name              "LaBounty"
    user.email                  "slabounty@socialgreeting.com"
    user.password               "foobar"
    user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
    "person-#{n}@example.com"
end
