class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def flash_messages_from_model(model)
    return unless model.errors.any?
    
    # Iterate through each error message and set individual flash messages
    model.errors.full_messages.each do |msg|
      clean_msg = msg.split(' ', 2).last
     flash.now[:error] = clean_msg
    end
  end
  
end
