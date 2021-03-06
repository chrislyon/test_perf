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

test_select()
{
	sqlplus $CNX_BASE <<!!
	select * from all_users;
!!
}

create_TBS_perf()
{
	sqlplus $CNX_BASE <<!!
	CREATE TABLESPACE PERF DATAFILE 
	  '/ado/X3V7PU9/database/data/PERF.tbs'
	  SIZE 1000M REUSE 
	  AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;
!!
}

create_user_perf()
{
	sqlplus $CNX_BASE <<!!
	create user perf identified by tiger
	default tablespace PERF
	quota unlimited on PERF;
	alter user perf identified by tiger ACCOUNT UNLOCK;
	grant create session to perf;
	grant select any table to perf;
	grant create table to perf;
!!
}

drop_user_perf()
{
	sqlplus $CNX_BASE <<!!
	drop user perf cascade;
	drop tablespace PERF including contents and datafiles;
!!
}

log()
{
	ts=$(date "+%j %X")
	printf "%s : %s\n" "$ts" "$1"
}

create_table_perf()
{
	sqlplus $CNX_BASE <<!!
	connect perf/tiger
	create table perf_table as select * from SEED.POSCOD;
	select count(*) from perf_table;
!!
}

log "debut du traitement"
>log/create.log
log "drop user perf"
drop_user_perf
log "create TBS perf"
create_TBS_perf 2>&1 >>log/create.log
log "create user perf"
create_user_perf 2>&1 >>log/create.log
log "Flush base"
flush_base 2>&1 >>log/create.log
log "==> Debut du test"
time create_table_perf
log "Fin   du traitement"

