class Backend::Admin::InvoicesController < Backend::Admin::AdminsController

  # before_action :get_employees , except: [:index]
  # before_action :get_ , only: [:index]
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create

  end

  private

  def get_employees
    @employees = Employee.all
  end
end
