class ErrorsController < ApplicationController
  def show
    render status_code.to_s, status: status_code
  end

  protected

  def status_code
    params[:code] || 500
  end

  def layout_by_resource
     "errors"
  end
end
