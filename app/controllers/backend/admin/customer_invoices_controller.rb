class Backend::Admin::CustomerInvoicesController < Backend::Admin::InvoicesController

  before_action :load_customers , only: [:new]

  def index
    @search   = CustomerInvoice.all.search(params[:q])
    @invoices = @search.result.includes(:recipient).paginate(page: params[:page], per_page: PER_PAGE).decorate || []
  end

  def show
    @events = @invoice.events.includes(:customer , :employee).paginate(page: params[:page], per_page: PER_PAGE).decorate || []
  end

  def edit
    @events = @invoice.events.includes(:customer , :employee).paginate(page: params[:page], per_page: PER_PAGE).decorate || []
  end

  def update
    @invoice.line_items.each do |line_item|
      line_item.set_net_amount_quantity
      line_item.save
    end
    # @invoice.total_amount = @invoice.events.not_cancelled.sum(:event_cost)
    if @invoice.calculate_net_amount
      flash[:success] = "Invoice was successfully updated."
    else
      flash[:errors] = @invoice.errors.full_messages
    end
    redirect_to :back
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
