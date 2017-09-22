class EventSerializer < ActiveModel::Serializer
  attributes :id, :start , :end , :allDay , :title, :description , :backgroundColor  , :employee_name , :customer_name
  attributes :edit_url
  attributes :update_url

  def backgroundColor
    object.employee.color
  end

  def employee_name
    object.employee.first_name if object.employee.present?
  end

  def customer_name
    object.customer.first_name if object.customer.present?
  end

  def edit_url
    edit_admin_event_path(object)
  end

  def allDay
   object.all_day_event? ? true : false
  end

  def start
    object.start.strftime(date_format) || ""
  end

  def end
    object.end.strftime(date_format)
  end

  def update_url
    admin_event_path(object, method: :patch)
  end

  def current_user_is_owner
    scope == object
  end

  def date_format
    object.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  end
end
