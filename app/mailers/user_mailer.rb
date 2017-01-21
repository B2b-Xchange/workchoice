class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user

    mail to: user.email, subject: t(:mailer_user_account_activation_subject)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail to: user.email, subject: t(:mailer_user_password_reset_subject)
  end

  def contact_request(from, to, post, message)
    @from = from
    @to = to
    @post = post
    @message = message

    mail to: to.email, subject: t(:mailer_user_contact_subject, title: post.title)
  end
  
end
