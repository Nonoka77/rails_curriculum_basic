class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render template: 'static_pages/error', status: 404, layout: 'application', content_type: 'text/html'
  end
  
  private

  def not_authenticated
    redirect_to login_path, warning: t('defaults.require_login')
  end
end
