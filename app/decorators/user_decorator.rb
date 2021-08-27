class UserDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{model.last_name} #{model.first_name}"
  end
end
