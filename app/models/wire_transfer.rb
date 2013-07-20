class WireTransfer < Transfer 
  include ActionView::Helpers::NumberHelper
  
  WITHDRAWAL_COMMISSION_RATE = BigDecimal("0.01")
  
  attr_accessible :bank_account_id, :bank_account_attributes

  belongs_to :bank_account

  accepts_nested_attributes_for :bank_account
  
  before_validation :check_bank_account_id

  validates :bank_account,
    :presence => true

  validates :currency,
    :inclusion => { :in => ["BRL"] }
 
  def execute
    # Placeholder for now
  end

  def check_bank_account_id
    if bank_account_id && account.bank_accounts.find(bank_account_id).blank?
      raise "Someone is trying to pull something fishy off"
    end
  end
  
  # active_scaffold methods
  def withdrawal_after_fee
    
    if self.amount < 0
      # deduct fee
      number_with_delimiter((1- WITHDRAWAL_COMMISSION_RATE) * self.amount , :delimiter => ',')
    else
      self.amount
    end
    
  end
  
  def deposit_after_fee
  end
  
  
  
end
