FactoryGirl.define do
  factory :status_message do
    status  'UP'
    message 'Service is up and running'
  end

  factory :empty_status_message, parent: :status_message do
    status   nil
    message  nil
  end

  factory :status_message_without_status, parent: :status_message do
    status  nil
    message 'Everything is ok'
  end

  factory :status_not_allowed, parent: :status_message do
    status  'Unknown'
    message nil
  end
end
