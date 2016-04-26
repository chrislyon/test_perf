## -----------------------
## test Lecture Ecriture
## -----------------------

CNX_BASE=system/manager

## ------------------------
## Vide le cache de la BDD
## ------------------------
flush_base()
{
        sqlplus $CNX_BASE <<!!
        alter system flush buffer_cache;
        alter system flush shared_pool;
!!
}

create_user_perf()
{
	sqlplus $CNX_BASE <<!!
	select * from all_users;
!!
}

log()
{
	ts=$(date "+%j %X")
	printf "%s : %s\n" "$ts" "$1"
}

log "debut du traitement"
log "Flush base"
flush_base
log "create user perf"
create_user_perf
log "Fin   du traitement"

