module Paytm
  class BaseService
    private

    def paytm_response
      uri = URI.parse(paytm_url)
      req = paytm_request(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      res = http.request(req)
      JSON.parse(res.body)
    end

    def paytm_request(uri)
      headers = Hash.new
      headers['Content-Type'] = 'application/json'
      headers['x-mid'] = ENV['WALLET_MID']
      headers['x-checksum'] = paytm_checksum
      req = Net::HTTP::Post.new(uri.request_uri, headers)
      req.body = paytm_params
      return req
    end

    def paytm_checksum
      Paytm::PaytmChecksum.new.generateSignature(paytm_params, ENV['WALLET_KEY'])
    end

    def paytm_base_url
      paytm_env = Rails.env.development? ? 'staging-dashboard' : 'dashboard'
      "https://#{paytm_env}.paytm.com/bpay/api/v1/disburse/order/"
    end

  end
end