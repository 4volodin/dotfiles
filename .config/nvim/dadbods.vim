let g:dadbods = []
let db = {
		\"name": "Test Postgres DB",
		\"url": "postgresql://postgres:@localhost/postgres"
		\}

call add(g:dadbods, db)

let db = {
		\"name": "DEV Stage",
		\"url": "postgresql://stage_user:dummypassword@test.example.com/stage"
		\}

call add(g:dadbods, db)

let db = {
		\"name": "DEV Main",
		\"url": "postgresql://main_user:dummypassword@test.example.com/main"
		\}

call add(g:dadbods, db)

" if g:db and b:db is set up -- b:db will be used.
" so g:db would serve as a default database (first in the list)
let g:db = g:dadbods[0].url
