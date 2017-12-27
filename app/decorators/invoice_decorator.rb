class InvoiceDecorator < ApplicationDecorator
  delegate_all

  def formated_issue_date
    object.issue_date.strftime('%B %d, %Y')
  end

  def formated_due_date
    object.issue_date.strftime('%d %B %Y')
  end

end
