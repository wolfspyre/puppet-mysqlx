# mysqlx::minion
# helper class
#  This is a helper class to take in hashes and feed them to our defined types
#mysql::databases:
# dbtocreate: {
#  ensure: 'present',
#  user: 'somedbuser',
#  password: 'monkey-fly-mosquito',
#  host: 'localhost'
# }
#mysql::grants:
#  foodbrwuser: {
#    ensure:   'present',
#    user:     'foodbrwuser',
#    database: 'somedatabase',
#    grant:    'all',
#    host:     '%'
# }
#mysql::users:
#  foodbrwuser: {
#    ensure:   'present',
#    database: 'database',
#    password: 'somepassword',
#    host:     '%'
# }

class mysqlx::minion(
  $databases = false,
  $grants    = false,
  $users     = false,
  ){
  if $databases {
    validate_hash($databases)
    #we have databases we should create
    create_resources( 'mysql::db', $databases )
  }
  if $grants {
    validate_hash($grants)
    #we have grants to create
    create_resources( 'mysqlx::grant', $grants )
  }
  if $users{
    validate_hash($users)
    #we have users we should add
    create_resources( 'mysqlx::user', $users )
  }
}
