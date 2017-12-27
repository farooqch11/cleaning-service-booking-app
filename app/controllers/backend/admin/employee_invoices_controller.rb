class Backend::Admin::EmployeeInvoicesController < Backend::Admin::AdminsController

  def index

  end

  def new
    @invoice = EmployeeInvoice.new
  end
end
