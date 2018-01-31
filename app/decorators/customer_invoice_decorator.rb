class CustomerInvoiceDecorator < InvoiceDecorator

  def edit_button_link
    h.link_to 'Edit', h.edit_admin_customer_invoice_path(self), class: 'btn btn-primary' , title: 'Edit'
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

  def recipient_detail
    h.render 'backend/admin/customer_invoices/partials/recipient' , invoice: self
  end

end
