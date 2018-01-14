class CustomerInvoice < Invoice
  belongs_to :recipient, class_name: 'Customer'

end