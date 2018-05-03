class Event < ApplicationRecord

  enum cost_type: [:fixed , :hourly]
  enum recurring_type: [:never , :after ,  :on_date]
  enum priority: [:normal , :low ,  :urgent]
  enum job_duration_type: [:minutes , :hours , :days]
  enum payment_type: [:transfer , :cheque , :cash]
  enum status: [:pending , :external , :scheduled , :travelling , :completed , :cancelled , :in_progress , :on_hold , :attention]
  acts_as_tree order: "created_at"
  serialize :recurring, Hash

  belongs_to :employee
  belongs_to :customer

  validates_inclusion_of    :cost_type        , in: cost_types.keys
  validates_inclusion_of    :recurring_type   , in: recurring_types.keys
  validates_inclusion_of    :status           , in: statuses.keys
  validates_inclusion_of    :priority         , in: priorities.keys
  validates_inclusion_of    :job_duration_type, in: job_duration_types.keys
  validates_inclusion_of    :payment_type, in: payment_types.keys
  validates_numericality_of :event_cost       , :job_duration , :total_cost , greater_than_or_equal_to: 0.0
  validates_numericality_of :recurring_end_time,  greater_than_or_equal_to: 0
  #
  validates :title, presence: true
  validates :customer, presence: true
  validates :employee, presence: true
  validates :start, presence: true ,if: Proc.new {|event| event.start_changed? }
  validates :end, presence: true , if: Proc.new {|event| event.end_changed? }
  validates_datetime :start , :end ,if: Proc.new {|event| event.start_changed? || event.end_changed? }
  validate :end_date_after_start_date? ,if: Proc.new {|event| event.start_changed? || event.end_changed? }
  validate :start_date_cannot_be_in_the_past , if: Proc.new {|event| event.start_changed? }


  attr_accessor :date_range , :is_parent_update
  before_create :set_recurring_end_date , if: Proc.new {|event| !event.on_date? && event.master?}
  before_create :set_event_cost , if: Proc.new { |event| event.master?}
  after_create :set_job_id
  after_save :schedule_future_events , if: Proc.new { |event| event.master? && event.recurring_changed? && event.recurring_was.empty? }

  scope :monthly , -> lambda { where("created_at >= ? and created_at <= ? " , lambda.to_date.beginning_of_month , lambda.to_date.end_of_month )}
  # def as_json(options={}
  #   # date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  #   #
  #   # json.id event.id
  #   # json.title event.title
  #   # json.start event.start.strftime(date_format)
  #   # json.end event.end.strftime(date_format)
  #   #
  #   # json.color event.color unless event.color.blank?
  #   # json.allDay event.all_day_event? ? true : false
  #   #
  #   # json.update_url event_path(event, method: :patch)
  #   # json.edit_url edit_event_path(event)
  #   super(:only => [:id, :title , :start , :end]
  #   )
  # end
  class << self
    Event.statuses.keys.each do |key|
      define_method("not_#{key}") do
        where.not(status: key)
      end
    end
  end

  def master?
    recurring? &&  parent_id.nil? && root?
  end

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

  def duration
    "#{start.strftime('%d/%m/%Y - %H:%M')} #{self.end.strftime('%d/%m/%Y - %H:%M')}"
  end
  def schedule_future_events
    delay.schedule_events
  end
  def schedule_events start_date = nil , end_date = nil
    s_date = start_date.nil? ? start : start_date
    e_date = end_date.nil? ? recurring_end_at : end_date
    schedule(s_date).occurrences(e_date).map do |date|
      next if self.start == date
      child = self.children.new
      self.attributes.each do |k,v|
        next if k == 'id' || k == 'created_at' || k == 'updated_at' || k == 'parent_id' # Skip if the key is id or created_at
        child[k] = v
      end
      child.start             = date
      child.end               = set_end_date(date)
      child.save!
    end
  end

  def set_end_date date
    (date.to_time + self.root.time_diff_in_hours.hours).to_datetime
  end

  def time_diff_in_hours
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
    def total_recurring_events
      schedule(start).occurrences(self.recurring_end_at).count
    end
    def set_event_cost
        self.event_cost = hourly? ? total_cost : (total_cost * 1.0)/total_recurring_events
    end
    def set_job_id
      self.job_id = "JCS#{id}"
      save
    end

    def set_recurring_end_date
      self.recurring_end_at = after? ? schedule(start).first(recurring_end_time.to_i).last : start + 6.month
    end

    def set_future_events
      parent = root? ? self : root
      parent.update_columns({title: self.title  , total_cost: self.total_cost ,payment_type: self.payment_type, cost_type: self.cost_type, end: self.end , customer_id: self.customer_id , employee_id: self.employee_id , contact: self.contact , description: self.description , recurring: self.recurring})
      parent.reload
      parent.delete_future_schedule_events_from  Time.now
      parent.schedule_events  Time.now
    end


  def end_date_after_start_date?
    e_date =  (self.end.to_time - 1.minute).to_datetime
    if e_date < start
      errors.add :base, "End date must be greater than start date."
    end
  end

  def start_date_cannot_be_in_the_past
    if start.present? && start < DateTime.now
      errors.add(:base, "Start date can't be in the past.")
    end
  end
end
