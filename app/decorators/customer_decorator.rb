class CustomerDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
  def edit_link
    h.link_to 'Edit', h.edit_admin_customer_path(self), class: 'btn btn-primary' , title: 'Edit' , remote: true
  end

  def delete_link
    h.link_to 'Delete', h.admin_customer_path(self), class: 'btn btn-primary',method: :delete, data: {confirm: "Do you really want to delete this customer?"} ,  remote: true
  end

  def profile_link
    h.link_to full_name , h.admin_customer_path(self)
  end

  def invoices_link
    h.link_to 'Invoices' , h.admin_customer_customer_invoices_path(self), class: 'btn btn-primary' , title: 'Invoices'
  end

  def address
    "#{object.street} #{object.city}"
  end

  def full_name
    object.first_name + " " + object.last_name
  end

  def full_address
    return "#{object.street}, #{object.city}, #{object.postcode}" if object.street && object.city && object.postcode
    return "#{object.city}, #{object.postcode}" if object.city && object.postcode
    return "#{object.street}, #{object.postcode}" if object.street && object.postcode
    return "#{object.city}" if object.city
    return "#{object.postcode}" if object.postcode
  end

  def modal_form
    h.render 'backend/admin/customers/partials/modal' , customer: self
  end

  def form
    h.render 'backend/admin/customers/partials/form' , customer: self
  end

  def row
    h.render 'backend/admin/customers/partials/table_row' , customer: self
  end

end
