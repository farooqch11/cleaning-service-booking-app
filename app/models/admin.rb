class Admin < User
  has_many :employees
  has_many :employee_invoices , foreign_key: 'sender_id'
  has_many :customer_invoices , foreign_key: 'sender_id'
  has_many :invoices , foreign_key: 'sender_id'
end
