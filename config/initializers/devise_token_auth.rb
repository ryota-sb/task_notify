DeviseTokenAuth.setup do |config|
  config.token_cost = Rails.env.test? ? 4 : 10

  # リクエストごとにトークンを更新するか
  config.change_headers_on_each_request = false

  # トークン有効期限 1ヵ月
  config.token_lifespan = 1.month

  # ヘッダーの名前対応
  config.headers_names = { 
    :'access-token' => 'access-token',
    :'client' => 'client',
    :'expiry' => 'expiry',
    :'uid' => 'uid',
    :'token-type' => 'token-type'
  }
end
