# mysqlx::minion
# helper class
#  This is a helper class to take in hashes and feed them to our defined types
#
#mysqlx::databases:
# dbtocreate: {
#  ensure: 'present',
#  user: 'somedbuser',
#  password: 'monkey-fly-mosquito',
#  host: 'localhost'
# }
# somedatabase: {
#  ensure: 'present',
#  user: 'somedbuser',
#  password: 'monkey-fly-mosquito',
#  host: 'localhost'
#}
#mysqlx::grants:
#  somedbrwuser: {
#    ensure:   'present',
#    user:     'somedbrwuser',
#    database: 'somedatabase',
#    grant:    'all',
#    host:     '%'
# }
#mysqlx::users:
#  somedbrwuser: {
#    ensure:   'present',
#    database: 'somedatabase',
#    password: 'somepassword',
#    host:     '%'
# }

class mysqlx::minion(
  $databases = false,
  $grants    = false,
  $users     = false,
  ){
  Database{} -> Database_user{} -> Database_grant{}
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
