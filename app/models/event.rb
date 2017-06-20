class Event < ApplicationRecord
  validates :title, presence: true
  attr_accessor :date_range
  belongs_to :eventable, polymorphic: true

  accepts_nested_attributes_for :eventable , :allow_destroy => true

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
end
