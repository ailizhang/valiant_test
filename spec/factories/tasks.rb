FactoryBot.define do
  factory :task do
    description { Faker::Lorem.paragraph }
    completed { true }
    completed_at { Time.now - 1.days }
  end
end
