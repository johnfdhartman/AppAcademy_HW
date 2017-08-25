class UserMailer < ApplicationMailer
  default from: 'stuff@stuff.yeah'

  def welcome_email(user)
    nil
  end
end
