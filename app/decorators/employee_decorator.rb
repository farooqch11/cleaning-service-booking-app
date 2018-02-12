class EmployeeDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def form
    h.render 'backend/admin/employees/partials/form' , employee: self
  end

  def row
    h.render 'backend/admin/employees/partials/table_row' , employee: self
  end

  def edit_link
    h.link_to 'Edit', h.edit_admin_employee_path(self), class: 'btn btn-primary' , title: 'Edit' , remote: true
  end
end
