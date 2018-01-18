class InvoicingLedgerItem < ActiveRecord::Base

  enum status: [:pending , :paid , :cancelled]
  # acts_as_ledger_item

  validates :period_start, :period_end , presence: true
  validate :end_after_start
  validate :due_date_after_issue_date
  validates_inclusion_of :status, in: statuses.keys

  belongs_to :sender, class_name: 'Admin'
  has_many :line_items, class_name: 'InvoicingLineItem', foreign_key: :ledger_item_id , dependent: :destroy
  has_many :events, through: :line_items

  before_validation :set_currency
  before_create :set_identifier
  after_create :calculate_net_amount

  accepts_nested_attributes_for :line_items

  default_scope -> {order created_at: :desc}

  def calculate_net_amount
    self.total_amount = events.not_cancelled.sum(:event_cost)
    self.tax_amount   = 0.0
    self.save!
  end


  private

  def due_date_after_issue_date
    return true if issue_date.blank? || due_date.blank?
    errors.add(:due_date, "must be after the issue date") if issue_date > due_date
  end

  def end_after_start
    errors.add(:period_end, "must be after the start date") if period_start > period_end
  end

  def set_identifier
    self.identifier = SecureRandom.hex(5)
  end

  def set_currency
    self.currency ='£'
  end


end
