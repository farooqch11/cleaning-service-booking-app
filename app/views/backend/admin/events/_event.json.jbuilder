date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.id event.id
json.employee_name event.employee.full_name
json.customer_name event.customer.full_name
json.title event.title
json.start event.start.strftime(date_format)
json.end event.end.strftime(date_format)

json.color event.color unless event.color.blank?
json.allDay event.all_day_event? ? true : false

json.update_url admin_event_path(event, method: :patch)
json.delete_url admin_event_path(event, method: :delete)
json.edit_url edit_admin_event_path(event)
