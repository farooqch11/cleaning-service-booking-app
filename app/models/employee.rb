class Employee < User

  validates_numericality_of :hourly_rate , greater_than_or_equal_to: 0.0
  has_many :events
  validates :color, presence: true

end
