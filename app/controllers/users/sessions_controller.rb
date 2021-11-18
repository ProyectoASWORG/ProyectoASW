class Users::SessionsController < Devise::SessionsController
    def destroy
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        # the `now: true` option sets the flash for this request 
        set_flash_message! :notice, :signed_out, now: true if signed_out
        redirect_to root_path 
    end 

    def after_sign_out_path_for(_resource_or_scope)
        return
    end

    def after_sign_in_path_for(_resource_or_scope)
        return
    end
end