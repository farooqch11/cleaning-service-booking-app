class EventDecorator < ApplicationDecorator
  delegate_all
  decorates_association :employee
  decorates_association :customer

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def edit_link
    h.link_to 'Edit', h.edit_admin_event_path(self), class: 'btn btn-primary' , title: 'Edit' , remote: true
  end

  def formatted_event_cost
    amount_in_currency(object.event_cost)
  end

  def formatted_total_cost
    amount_in_currency(object.event_cost * object.time_diff_in_hours)
  end

  def formatted_start_date
    object.start.strftime('%d/%m/%Y - %H:%M')
  end
end
