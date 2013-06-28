class UserMailer < BitcoinCentralMailer
  def registration_confirmation(user)
    @user = user
    
    mail :to => user.email,
      :subject => (I18n.t :sign_up_confirmation)
  end
  
  def invoice_payment_notification(invoice)
    @user = invoice.user
    @invoice = invoice
    
    mail :to => @user.email,
      :subject => I18n.t("emails.invoice_payment_notification.subject")
  end
  
  def withdrawal_processed_notification(withdrawal)
    @user = withdrawal.account
    @withdrawal = withdrawal
    @withdrawal.bank_account.ag[2..-1] = '*' * (@withdrawal.bank_account.ag.length - 2)
    @withdrawal.bank_account.cc[3..-1] = '*' * (@withdrawal.bank_account.cc.length - 3)
    
    mail :to => @user.email,
      :subject => I18n.t("emails.withdrawal_processed_notification.subject")
  end
  
  def trade_notification(user, sales, purchases)
    @sales = sales
    @purchases = purchases
    
    mail :to => user.email,
      :subject => I18n.t("emails.trade_notification.subject")
  end
end
