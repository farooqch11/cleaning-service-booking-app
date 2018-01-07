class InvoiceDecorator < ApplicationDecorator
  delegate_all
  decorates_association :recipient
  def amount_in_currency(price)
    h.number_to_currency(price, :unit => "£")
  end

  def formatted_net_amount
    amount_in_currency(object.net_amount)
  end

  def formatted_tax_amount
    amount_in_currency(object.tax_amount)
  end
  def formatted_total_amount
    amount_in_currency(object.calculate_total_amount)
  end
  def invoice_no
    h.content_tag(:h3 , "INVOICE NO. # #{object.identifier }")
  end
  def formatted_issue_date
    object.issue_date.present? ? object.issue_date.strftime('%B %d, %Y') : '-'
  end

  def formatted_due_date
    object.due_date.present? ? object.due_date.strftime('%d %B %Y') : '-'
  end

  def download_link
    h.link_to 'Download', h.admin_invoice_download_path(self), class: 'btn btn-primary' , method: :post
                        end

  def pdf_download_name
    "JCS-#{object.identifier }.pdf"
  end

  def previous_balance
    amount_in_currency(0.0)
  end

end
