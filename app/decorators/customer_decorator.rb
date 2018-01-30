class CustomerDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
  def edit_link
    h.link_to 'Edit', h.edit_admin_customer_path(self), class: 'btn btn-primary' , title: 'Edit'
  end

  def delete_link
    h.link_to 'Delete', h.admin_customer_path(self), class: 'btn btn-primary',:method => :delete, data: {:confirm => "Are you sure?"}
  end

  def profile_link
    h.link_to object.full_name , h.admin_customer_path(self)
  end

  def invoices_link
    h.link_to 'Invoices' , h.admin_customer_customer_invoices_path(self), class: 'btn btn-primary' , title: 'Invoices'
  end

  def address
    "#{object.street} #{object.city}"
  end
end
