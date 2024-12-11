class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  around_action :handle_cancan_access_denied

  def flash_messages_from_model(model)
    return unless model.errors.any?
    
    # Iterate through each error message and set individual flash messages
    model.errors.full_messages.each do |msg|
      clean_msg = msg.split(' ', 2).last
      puts clean_msg
      flash.now[:error] = clean_msg
    end
  end
  
  def render_404
    render file: Rails.root.join("public", "404.html"), status: :not_found, layout: false
  end

  private

  def handle_cancan_access_denied(&action)
    begin
      action.call
    rescue CanCan::AccessDenied => exception
      render file: Rails.root.join("public", "403.html"), status: :forbidden, layout: false
      return
    rescue ActiveRecord::RecordNotFound => exception
      render file: Rails.root.join("public", "404.html"), status: :not_found, layout: false
      return
    rescue StandardError => exception
      render file: Rails.root.join("public", "500.html"), status: :internal_server_error, layout: false
      return
    end
  end


end
