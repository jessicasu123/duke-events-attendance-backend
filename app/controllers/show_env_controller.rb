class ShowEnvController < ApplicationController
    respond_to :html
    layout false
    skip_filter :require_user
  
    def index
      #raise "hello"
      @env = request.env
      @user = request.env['authenticator.rack_user']
    end
  
  end