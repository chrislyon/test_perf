##
## Lecture de POSCOD
##

f()
{
        sqlplus system/manager <<!!
        alter system flush buffer_cache;
        alter system flush shared_pool;
        select count(*) from SEED.POSCOD;
!!
}

time f

