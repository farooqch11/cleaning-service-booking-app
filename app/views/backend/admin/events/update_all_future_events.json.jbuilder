json.success !@is_terminate
if not @is_terminate
  json.message "Successfully updated"
  json.data do
    json.array! @calendar_events do |event|
      json.partial! 'backend/admin/events/event', event: event
    end
  end
else
  json.errors ["Error! Can't update event already exists on #{@check_date}"]
end

