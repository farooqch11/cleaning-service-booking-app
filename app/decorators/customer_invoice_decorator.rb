class CustomerInvoiceDecorator < InvoiceDecorator
  delegate_all
  decorates_association :recipient
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  delegate_all

  def edit_button_link
    h.link_to 'Edit', h.edit_admin_customer_invoice_path(self), class: 'btn btn-primary' , title: 'Edit'
  end

  def delete_button_link
    h.link_to 'Delete', h.admin_customer_invoice_path(self), class: 'btn btn-primary',:method => :delete, data: {:confirm => "Are you sure?"}
  end

end
