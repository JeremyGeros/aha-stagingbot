db = URI.parse(ENV['DATABASE_URL'])

ActiveRecord::Base.establish_connection(
  adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  host:     db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: 'utf8'
)

class Server < ActiveRecord::Base
  # attrs
  # id, name, claimed, claimed_by, claimed_at, claimed_for, auto_claimed
end
