class Event < ApplicationRecord

  serialize :recurring, Hash

  belongs_to :employee
  belongs_to :customer

  validates :title, presence: true
  validates :customer, presence: true
  validates :employee, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates_datetime :start , :end
  attr_accessor :date_range

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end

  def recurring=(value)
    if RecurringSelect.is_valid_rule?(value)
      super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
    else
      super(nil)
    end
  end

  def rule
    IceCube::Rule.from_hash recurring
  end
  #
  def schedule(start)
    schedule = IceCube::Schedule.new(start)
    schedule.add_recurrence_rule(rule)
    schedule
  end

  #
  def calendar_events(start_date)
    if recurring.empty?
      [self]
    else
      # start_date = start.to_date.beginning_of_month.beginning_of_week
      # end_date = start_date.to_date.end_of_month.end_of_week
      end_date = start_date.end_of_month.end_of_week
      schedule(start).occurrences(self.end).map do |date|
        Event.new(id: self.id ,title: self.title,start: date ,customer_id: self.customer_id , employee_id:self.employee_id ,contact: self.contact,description: self.description,created_at:self.created_at)
      end
    end
  end

end
