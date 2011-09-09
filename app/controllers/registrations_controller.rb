require 'rubygems'
require 'net/ldap'

class RegistrationsController < Devise::RegistrationsController
  
  filter_parameter_logging :ldap_user, :ldap_pass
  
  def new
    super
  end

  def create
    build_resource

    if ldap_authenticated? && resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => redirect_location(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end

  private

  def ldap_authenticated?
    ldap = Net::LDAP.new
    ldap.host = 'localhost'
    ldap.port = 389
    ldap.auth params[:ldap_user], params[:ldap_pass]
    ldap.bind
  end
end
