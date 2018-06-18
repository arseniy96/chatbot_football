class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def vkontakte
    @user = User.find_for_vkontakte_oauth request.env["omniauth.auth"]
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Vkontakte"
      sign_in_and_redirect root_path, event: :authentication
    else
      flash[:notice] = "Authentication Error"
      redirect_to root_path
    end
  end

end
