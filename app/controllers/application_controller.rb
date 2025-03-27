class ApplicationController < ActionController::Base
  before_action :require_login
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  add_flash_types :info, :success, :warning, :error

  private

  def not_authenticated
    redirect_to login_path, error: t("defaults.flash_message.require_login")
  end
end
