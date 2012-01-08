Factory.define :task do |f|
  f.sequence(:name) { |n| "Task #{n}" }
  f.association :user
end
