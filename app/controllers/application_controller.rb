class ApplicationController < ActionController::Base
    before_action :require_user

 def logout
   reset_session
   redirect_to "/Shibboleth.sso/Logout?return=https://shib.oit.duke.edu/cgi-bin/logout.pl"
 end

protected
 def require_user
   rack_user = request.env['authenticator.rack_user']
   puts rack_user
   if(rack_user.netid.present?)
    @current_user = rack_user
   else
    render  :file => "public/401.html", :status => :unauthorized, :layout => false
   end
 end

 private 
    attr_reader :current_user
    helper_method :current_user
end
