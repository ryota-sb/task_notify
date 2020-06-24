# EC2サーバのIP、EC2サーバにログインするユーザ名、サーバのロール
server '18.181.142.39', user: 'ryota', roles: %w{app db web}

# デプロイするサーバにsshログインする鍵情報
set :ssh_options, keys: '~/.ssh/tasknotify_key_rsa'