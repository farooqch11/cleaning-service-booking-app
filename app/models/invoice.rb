class Invoice < InvoicingLedgerItem
  validates :recipient      , presence: true

end