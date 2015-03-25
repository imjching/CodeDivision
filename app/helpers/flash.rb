helpers do
  def redirect_with_flash(url, type, message)
    session[:flash_type] = type
    session[:flash_message] = message
    redirect to(url)
  end

  def current_flash
    session[:flash_message]
  end

  def current_flash_type
    session[:flash_type]
  end

  def has_flash?
    !current_flash.nil?
  end

  def clear_flash
    session.delete("flash_message").delete("flash_type")
  end
end