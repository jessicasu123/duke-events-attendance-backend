class ShowEnvController < ApplicationController
    respond_to :html
    layout false
    skip_before_action :require_user, raise: false
  
    def index
      @env = request.env
      @user = request.env['authenticator.rack_user']
    end
  
  end