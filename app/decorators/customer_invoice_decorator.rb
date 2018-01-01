class CustomerInvoiceDecorator < InvoiceDecorator

  def edit_button_link
    h.link_to 'Edit', h.edit_admin_customer_invoice_path(self), class: 'btn btn-primary' , title: 'Edit'
  end

  def delete_button_link
    h.link_to 'Delete', h.admin_customer_invoice_path(self), class: 'btn btn-primary',:method => :delete, data: {:confirm => "Are you sure?"}
  end

  def recipient_full_name
    recipient.full_name
  end

  def recipient_phone
    recipient.phone
  end

  def recipient_type
    "Client"
  end
end
