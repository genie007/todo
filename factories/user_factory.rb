Factory.define :user do |f|
  f.password "secret"
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end

