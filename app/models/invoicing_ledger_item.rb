class InvoicingLedgerItem < ActiveRecord::Base

  acts_as_ledger_item

  validates :period_start, :period_end , presence: true
  validate :end_after_start
  validate :due_date_after_issue_date

  belongs_to :sender, class_name: 'Admin'
  has_many :line_items, class_name: 'InvoicingLineItem', foreign_key: :ledger_item_id
  has_many :events, through: :line_items

  accepts_nested_attributes_for :line_items

  before_create :set_identifier
  before_create :calculate_net_amount
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


end
