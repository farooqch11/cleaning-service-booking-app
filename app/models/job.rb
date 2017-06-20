class Job < ApplicationRecord
  has_one :event, as: :eventable
end
