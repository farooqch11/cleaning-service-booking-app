class Backend::BackendController < ApplicationController
  before_action :authenticate_user!
  layout 'backend'

end