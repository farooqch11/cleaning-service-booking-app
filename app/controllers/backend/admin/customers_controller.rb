class Backend::Admin::CustomersController < Backend::Admin::AdminsController

  require 'will_paginate/array'

  before_action :set_customer ,only: [:edit ,:update , :destroy]

  def index
    @customers = Customer.all.paginate(:page => params[:page], :per_page => 10) || []
  end

  def new
    @customer = Customer.new
  end

  def edit

  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = 'Customer was successfully updated.'
      redirect_to admin_customers_url
    else
      flash[:errors] = @customer.errors.full_messages
      render action: 'edit'
    end

  end

  def destroy
    @customer.destroy
    flash[:notice] = 'Customer was successfully Deleted.'
    redirect_to admin_customers_url
  end

  def create
    @customer =  Customer.create(customer_params)
    if @customer.errors.any?
      flash[:notice] = @customer.errors.full_messages
      render 'new'
    else
      flash[:success] = "You have successfully created an customer."
      redirect_to admin_customers_url
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name , :email ,:phone , :street , :city , :postcode , :gender)
  end

  def set_customer
    @customer =  Customer.find(params[:id])

  end
end
