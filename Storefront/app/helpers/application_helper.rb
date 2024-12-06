module ApplicationHelper

  def alert_class(type)
    case type.to_sym
    when :success, :notice
      'alert-success'
    when :error, :alert
      'alert-error'
    else
      'alert-default'
    end
  end
    
end
