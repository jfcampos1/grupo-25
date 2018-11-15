# frozen_string_literal: true

class MailConfirmationMailer < ApplicationMailer
  def new_user_email(user)
    @user = user
    @url = 'https://foro-g25-software.herokuapp.com'
    mail subject: "Registration Confirmation for #{user.name}", to: user.email
  end
end
