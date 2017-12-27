class Backend::Admin::CustomerInvoicesController < Backend::Admin::AdminsController

  before_action :load_customers , only: [:new , :edit]
  before_action :find_invoice , only: [:edit , :show]
  before_action :find_customer , only: [:create]
  before_action :load_events , only: [:create]

  def index
    @search   = CustomerInvoice.all.search(params[:q])
    @invoices = @search.result.paginate(page: params[:page], per_page: PER_PAGE).decorate || []
  end

  def edit

  end

  def new
    @invoice = current_user.customer_invoices.new
  end

  def show
    # pdf_creator = Invoicing::LedgerItem::PdfGenerator.new(@invoice)
    # pdf_file = pdf_creator.render Rails.root.join('/path/to/pdf')
  end

  def create
    @invoice = current_user.customer_invoices.new(invoice_params)
    @events.each do |event|
      @invoice.line_items.build(event: event)
    end
    @invoice.currency = "USD"
    if @invoice.valid? && @invoice.save!
      flash[:success]    = "Invoice Successfully created."
      redirect_to edit_admin_customer_invoice_url(@invoice)
    else
      load_customers
      flash[:errors] = @invoice.errors.full_messages
      puts @invoice.errors.full_messages
      render 'new'
    end
  end

  private

  def find_customer
    @customer = Customer.find_by_id invoice_params[:recipient_id]
  end

  def load_customers
    @customers = Customer.all || []
  end

  def find_invoice
    @invoice = CustomerInvoice.find_by_id(params[:id]).decorate
  end

  def load_events
    @events = @customer.events.where("created_at >= ? and created_at <= ? " , invoice_params[:period_start] , invoice_params[:period_end]) || []
  end

  def invoice_params
    params.require(:customer_invoice).permit(:recipient_id, :issue_date , :due_date , :description , :period_start , :period_end)
  end
end
