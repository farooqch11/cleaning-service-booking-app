class Backend::Admin::EmployeesController < Backend::Admin::AdminsController

  def index

  end

  def new
    @employee = User.new
  end

  def create

  end
end
