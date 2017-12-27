class InvoicingLineItem < ActiveRecord::Base
  acts_as_line_item

  belongs_to :ledger_item, class_name: 'InvoicingLedgerItem'
  belongs_to :event
end
