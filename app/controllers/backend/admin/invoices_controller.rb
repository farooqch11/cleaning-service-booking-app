class Backend::Admin::InvoicesController < Backend::Admin::AdminsController


  before_action :find_invoice , only: [:show , :download , :destroy ,  :edit , :show , :update]

  def new
    @invoice = Invoice.new
  end

  def show

  end

  def create
    @invoice = current_user.invoices.new(invoice_params)
    respond_to do |format|
      if @invoice.save
        flash.now[:success] = 'Invoice was successfully created.'
        format.html { redirect_to @invoice }
        format.json { render action: 'show', status: :created, location: @invoice }
        format.js   { }
      else
        puts @invoice.errors.full_messages
        format.html { render action: 'new' }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
        format.js   { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    respond_to do |format|
      if @invoice.destroy
        flash.now[:success] = 'Successfully Deleted.'
        format.html { redirect_to :back}
        format.js   { }
      else
        format.js   { }
      end
    end
  end

  def download
    pdf = WickedPdf.new.pdf_from_string(render_to_string(:action => :show, :layout => "pdf.html.haml"))
    send_data(pdf,
              :filename => @invoice.pdf_download_name,encoding:                       'TEXT',
              :disposition => 'attachment')
  end

  private

  def find_invoice
    @invoice = InvoicingLedgerItem.find_by_id(params[:id] || params[:invoice_id]).decorate
  end

  def get_employees
    @employees = Employee.all
  end

  def invoice_params
    params.require(:invoice).permit(:recipient_id, :issue_date , :due_date , :description , :period_start , :period_end)
  end

  def load_events
    # @events = find_recipient.events.where("created_at >= ? and created_at <= ? " , invoice_params[:period_start] , invoice_params[:period_end]) || []
    @events = Event.all
  end

end
