module Paytm
  class PaytmWalletTransfer < BaseService
    attr_reader :phone_number, :amount, :order_id
    
    def initialize(user_id: , amount: , phone_number:)
      @phone_number = phone_number
      @amount = amount.to_s
      @order_id = SecureRandom.hex
    end
    
    def transfer
      response_body = HashWithIndifferentAccess.new(paytm_response)
    end
    
    private
    
    def paytm_params
      '{"orderId":"' + order_id.to_s + '","beneficiaryPhoneNo":"' + phone_number.to_s + '","amount":"' + amount.to_s + '","subwalletGuid":"' + ENV['WALLET_GUID'] + '"}'
    end
    
    def paytm_url
      paytm_base_url + 'wallet/gratification'
    end
  end
end