class EmployeeInvoice < Invoice
  belongs_to :recipient, class_name: 'Employee'
end