class Backend::Admin::CustomerInvoicesController < Backend::Admin::InvoicesController

  before_action :load_customers , only: [:new]

  def index
    @search   = CustomerInvoice.all.search(params[:q])
    @invoices = @search.result.includes(:recipient).paginate(page: params[:page], per_page: PER_PAGE).decorate || []
  end

  def edit
    @customer = @invoice.recipient
    @events = @invoice.events.includes(:customer , :employee).paginate(page: params[:page], per_page: PER_PAGE).decorate || []
  end

  def new
    @invoice = current_user.customer_invoices.new.decorate
  end

  def destroy
    super
  end

  private

  def find_recipient
    @customer = Customer.find_by_id invoice_params[:recipient_id]
  end

  def load_customers
    @recipients = Customer.all || []
  end

  def find_invoice
    @invoice = CustomerInvoice.find_by_id(params[:id]).decorate
  end

  def invoice_params
    super.merge!({type: 'CustomerInvoice'})
  end
end
