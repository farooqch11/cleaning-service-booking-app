class Invoice < InvoicingLedgerItem
  acts_as_invoice
  validates :recipient      , presence: true

end