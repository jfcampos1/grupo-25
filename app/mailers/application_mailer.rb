# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'foreados.2018@gmail.com'
  layout 'mailer'
end
