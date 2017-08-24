class Event < ApplicationRecord

  enum cost_type: [:fixed , :hourly]
  acts_as_tree order: "created_at"
  serialize :recurring, Hash

  belongs_to :employee
  belongs_to :customer

  validates_inclusion_of    :cost_type  , in: cost_types.keys
  validates_numericality_of :event_cost , :total_cost , greater_than_or_equal_to: 0.0

  validates :title, presence: true
  validates :customer, presence: true
  validates :employee, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates_datetime :start , :end
  attr_accessor :date_range , :is_parent_update

  before_validation :set_event_cost , if: Proc.new { |event| event.fixed? && event.recurring?}
  after_create :schedule_events , if: Proc.new { |event| event.recurring? && event.parent_id.nil? && event.root? }
  after_update :set_future_events , if: Proc.new { |event| event.recurring? && event.recurring_changed?}

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
  def recurring?
    recurring.present?
  end
  #
  def schedule(start)
    schedule = IceCube::Schedule.new(start)
    schedule.add_recurrence_rule(rule)
    schedule
  end

  def schedule_events start_date = nil , end_date = nil
    s_date = start_date.nil? ? start : start_date
    e_date = end_date.nil? ? self.end : end_date
    schedule(s_date).occurrences(e_date).map do |date|
      self.children.create({start: date , end: date , recurring: recurring , title: title , customer_id: self.customer_id , employee_id:self.employee_id ,contact: self.contact,description: self.description})
    end
  end

  def delete_future_schedule_events_from start_date = nil
    s_date = start_date.nil? ? start : start_date
    children_events = children.where("start > ? " , start_date) || []
    children_events.each do |event|
      event.destroy
    end

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
        Event.new(id: self.id ,title: self.title,start: date , end: date , customer_id: self.customer_id , employee_id:self.employee_id ,contact: self.contact,description: self.description,created_at:self.created_at)
      end
    end
  end
  private

    def set_future_events

      parent = root? ? self : root
      parent.update_columns({title: self.title , recurring: self.recurring})
      parent.reload
      parent.delete_future_schedule_events_from  Time.now
      parent.schedule_events  Time.now
    end

    def set_event_cost

    end

end
