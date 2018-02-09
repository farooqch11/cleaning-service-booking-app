class ApplicationDecorator < Draper::Decorator
  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end
  def self.collection_decorator_class
    PaginatingDecorator
  end

  def amount_in_currency(price)
    h.number_to_currency(price, :unit => "£")
  end

  def modal_title
    object.new_record? ? "Create #{object.class.name}" : "Edit #{object.class.name}"
  end

  def modal
    h.render 'backend/admin/shared/modal' , object: self
  end
  
  def show_link
    h.link_to 'View', [:admin , self] , class: 'btn btn-primary' , title: 'View'
  end

  def delete_link
    h.link_to 'Delete', [:admin , self], class: 'btn btn-primary',method: :delete, data: {confirm: "Do you really want to delete this #{object.class.name}?" , commit: "Yes" , cancel: 'No'} ,  remote: true
  end

end
