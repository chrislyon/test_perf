##
## Lecture de POSCOD
##

f()
{
        sqlplus system/manager <<!!
        alter system flush buffer_cache;
        alter system flush shared_pool;
        select sum(UPDTICK_0) from SEED.POSCOD;
!!
}

time f

