json.array! @events do |event|
  date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  json.title event.title
  json.description event.description
  json.start event.start.strftime(date_format)
  json.end event.end.strftime(date_format)
  # json.color event.color unless event.color.blank?
  json.className 'color-blue'
  json.allDay event.all_day_event? ? true : false
  json.update_url admin_event_path(event, method: :patch)
  json.edit_url edit_admin_event_path(event)
  json.employee_name event.customer.full_name if event.customer.present?
  json.customer_name event.employee.full_name if event.customer.present?
end
