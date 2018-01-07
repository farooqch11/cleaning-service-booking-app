class Backend::Admin::InvoicesController < Backend::Admin::AdminsController

  # before_action :get_employees , except: [:index]
  before_action :find_invoice , only: [:show , :download]
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def show

  end

  def create

  end

  def download
    html = render_to_string(:action => :show, :layout => "pdf.html.haml")
    pdf = WickedPdf.new.pdf_from_string(html)
    send_data(pdf,
              :filename => @invoice.pdf_download_name,
              :disposition => 'attachment')
  end

  private

  def find_invoice
    @invoice = InvoicingLedgerItem.find_by_id(params[:id] || params[:invoice_id]).decorate
  end

  def get_employees
    @employees = Employee.all
  end


end
