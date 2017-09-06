class Event < ApplicationRecord

  enum cost_type: [:fixed , :hourly]
  enum recurring_type: [:never , :after ,  :on_date]
  enum priority: [:normal , :low ,  :urgent]
  enum status: [:pending , :external , :scheduled , :travelling , :completed , :cancelled , :in_progress , :on_hold , :attention]
  acts_as_tree order: "created_at"
  serialize :recurring, Hash

  belongs_to :employee
  belongs_to :customer

  validates_inclusion_of    :cost_type        , in: cost_types.keys
  validates_inclusion_of    :recurring_type   , in: recurring_types.keys
  validates_inclusion_of    :status           , in: statuses.keys
  validates_inclusion_of    :priority         , in: priorities.keys
  validates_numericality_of :event_cost       , :total_cost , greater_than_or_equal_to: 0.0
  validates_numericality_of :recurring_end_time,  greater_than_or_equal_to: 0

  validates :title, presence: true
  validates :customer, presence: true
  validates :employee, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates_datetime :start , :end

  attr_accessor :date_range , :is_parent_update

  before_validation :set_event_cost
  before_create :set_recurring_end_date , if: Proc.new {|event| !event.on_date? && event.recurring? && event.parent_id.nil? && event.root?}
  after_create :set_job_id
  after_create :schedule_events , if: Proc.new { |event| event.recurring? && event.parent_id.nil? && event.root? }

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

  def is_parent_update?
    true
  end
  #
  def schedule(start)
    schedule = IceCube::Schedule.new(start)
    schedule.add_recurrence_rule(rule)
    schedule
  end

  def schedule_events start_date = nil , end_date = nil
    s_date = start_date.nil? ? start : start_date
    e_date = end_date.nil? ? recurring_end_at : end_date
    schedule(s_date).occurrences(e_date).map do |date|
      child = self.children.new

      child.title       = title
      child.description = description
      child.recurring   = recurring
      child.employee_id = employee_id
      child.customer_id = customer_id
      child.contact     = contact
      child.start       = date
      child.end         = set_end_date(date)
      child.priority    = priority
      child.recurring_type    = recurring_type

      child.total_cost  = total_cost
      child.cost_type  = cost_type

      child.save!

      # self.children.create({start: date ,   , total_cost: self.total_cost ,cost_type: self.cost_type , recurring: recurring , title: title , customer_id: self.customer_id , employee_id:self.employee_id ,contact: self.contact,description: self.description})
    end
  end

  def set_end_date date
    (date.to_time + self.root.time_diff_in_hours.hours).to_datetime
  end

  def time_diff_in_hours
    # TimeDifference.between(start, self.end).in_hours
    ((self.end - start) / 1.hour).round
  end
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

    def set_job_id
      self.job_id = "JCS#{id}"
      save
    end

    def set_recurring_end_date
      self.recurring_end_at = after? ? schedule(start).first(recurring_end_time.to_i).last : start + 2.years
    end

    def set_future_events

      parent = root? ? self : root
      parent.update_columns({title: self.title  , total_cost: self.total_cost ,cost_type: self.cost_type, end: self.end , customer_id: self.customer_id , employee_id: self.employee_id , contact: self.contact , description: self.description , recurring: self.recurring})
      parent.reload
      parent.delete_future_schedule_events_from  Time.now
      parent.schedule_events  Time.now
    end

    def set_event_cost
      if hourly?

      end
    end

end
