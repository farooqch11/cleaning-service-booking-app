json.array! @calendar_events do |event|
  json.partial! 'backend/admin/events/event', event: event
end
