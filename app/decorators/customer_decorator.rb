class CustomerDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{object.first_name} #{object.last_name}"
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

  def form
    h.render 'backend/admin/customers/partials/form' , customer: self
  end

  def row
    h.render 'backend/admin/customers/partials/table_row' , customer: self
  end

end
