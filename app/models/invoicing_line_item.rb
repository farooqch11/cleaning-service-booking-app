class InvoicingLineItem < ActiveRecord::Base
  # acts_as_line_item

  belongs_to :ledger_item, class_name: 'InvoicingLedgerItem'
  belongs_to :event

  before_create :set_net_amount_quantity

  def total_amount
    (quantity * net_amount)
  end

  def set_net_amount_quantity
    self.net_amount = self.event.event_cost
    self.quantity   = self.event.time_diff_in_hours
  end

end
