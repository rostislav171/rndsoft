# app/mailers/example_mailer.rb

class ExampleMailer < ApplicationMailer
  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Ждем вас на нашем сайте!')
  end
end
