#
#     Copyright (c) 2001 Matsushita Electric Industrial Co., Ltd.
#     All rights reserved.
#     $Id: dot-gdbinit,v 1.1.1.1 2008/08/28 03:09:48 ytakeuchi Exp $
#
#     gdb macros for PiE-Linux
#
##alias	gdba		'gdbserver scarlett:2345 --attach '

############################################################################
# For Installation
#
# 1. Setting of .gdbinit
#
#      Please describe such as the followings to the top of your ~/.gdbinit .
#
#        ex)
#         source ~/estb02/doc/develop/dot-gdbinit
#         define eth
#           target remote 10.73.176.34:2345
#         end
#         define pield
#           add-symbol-file ~/pprosrc/root/usr/src/pie/pie/pie/pied.out 0x08000000
#         end
#         define linuxld
#           add-symbol-file ~/pprosrc/root/usr/src/linux/vmlinux 0x98000000
#         end
#         #--- Customize below here!
#
#        * ~/.gdbinit is read automatically when you start gdb.
#        * You can use the newest setting ONLY by updating estb02.
#
# 2. Usage of commands
#
#      You can see list of commands and help of a command
#      by using "help" command on gdb.
#
#      (a)Display list of all commands defined in this file
#
#           (gdb) help user-defined
#           (gdb) help user
#
#      (b)Display help of a command
#
#           (gdb) help <command name>
#
#           ex)
#            (gdb) help tsklist
#
# 3. Custumization of emacs in using gdb
#
#  3.1. How to change default command in doing "M-x gdb" on emacs.
#       ("Run gdb (like this): gdb" <= this command)
#
#       [How to do]
#         Describe the following to your .emacs .
#
#          (defvar gud-gdb-history (list "mn10300-linux-gdb"))
#
#       [Remark]
#         * You can change above "mn10300-linux-gdb" to 
#           "mn10300-linux-gdb ~/work/pprosrc/root/usr/src/linux/vmlinux"
#           or so on.
#         * This setting is only for GNU Emacs 20.7.2 .
#           Sorry, I have never checked other versions.
#         * If the above setting does not work on old emacs,
#           try the following.
#           (setq gdb-command-name "mn10300-linux-gdb")
#
# 4. Change record
#
#      Refer to the end of a file.
#

############################################################################
# Command List
#  
#        Essential Symbol Information(P=PiE symbol, L=Linux symbol)
#        Version Dependency(3=Supported only V3.0 PiE-Kernel)
#                    |
#                    V
# <Basic Operation>
#  (eth)         : [   ] Connect to gdbserver with ether (gdbserver)
#                         * need to custumize on your environment
#   com1         : [   ] Connect to kernel monitor with serial 0
#                        (kernel gdb)
#   com2         : [   ] Connect to kernel monitor with serial 1
#                        (kernel gdb)
#   ksta         : [   ] Escape from while(knl_debug); (kernel gdb)
#  (pield)       : [   ] Load PiE debug information (kernel gdb)
#                         * need to custumize on your environment
#  (linuxld)     : [   ] Load Linux debug information (kernel gdb)
#                         * need to custumize on your environment
#   regs         : [   ] Print registers
#   sj           : [   ] Step instruction with printing pc and sp
# <A Control Block Information for a PiE-Kernel Resource>
#   tsk          : [P  ] Print TCB (task)
#   sem          : [P  ] Print SEMCB (semaphore)
#   mtx          : [P  ] Print MTXCB (mutex)
#   cnd          : [P  ] Print CNDCB (condition variable)
#   obj          : [P  ] Print OBJCB (object lock)
#   flg          : [P  ] Print FLGCB (event flag)
#   que          : [P  ] Print QUECB (queue)
#   rdv          : [P  ] Print RDVCB (rendezvous)
#   cyc          : [P  ] Print CYCCB (cyclic handler)
#   mpl          : [P  ] Print MPLCB (variable length memory pool)
#   mpf          : [P  ] Print MPFCB (fixed length memory pool)
# <List of All Elements for a PiE-Kernel Resource>
#   tsklist      : [P 3] Print list of all tasks
#   semlist      : [P 3] Print list of all samaphores
#   mtxlist      : [P 3] Print list of all mutexes
#   cndlist      : [P 3] Print list of all condition variables
#   objlist      : [P 3] Print list of all object lockes
#   flglist      : [P 3] Print list of all event flags
#   quelist      : [P 3] Print list of all queues
#   rdvlist      : [P 3] Print list of all rendezvouses
#   cyclist      : [P 3] Print list of all cyclic handlers
#   mpllist      : [P 3] Print list of all variable length memory pools
#   mpflist      : [P 3] Print list of all fixed length memory pools
#   veclist      : [P  ] Print list of all interrupt vector
#                        configurated in cfg files.
#   intlist      : [P  ] Print list of all interrupt vector
#                        registered to PiE Kernel
# <Management Queue>
#   mngque       : [P  ] Print indexes of RCBs linked to management queue
#   tskquelist   : [P  ] Print indexes of tasks linked to task management
#                        queue
#   cycquelist   : [P 3] Print indexes of cyclic handlers linked
#                        to cyclic handler management queue
# <System>
#   sysinfo      : [ L ] Print system information (/proc information)
# <Process>
#   pieproc      : [P 3] Print task_struct of Linux processes/threads
#                        on PiE context with GDBSERVER
#   piecurrent   : [P 3] Print current process information
#                        on PiE context with GDBSERVER
#   proc         : [ L ] Print task_struct of Linux processes/threads
#   proclist     : [ L ] Print list of all Linux processes/threads
#   current      : [ L ] Print current process information
#   btany        : [ L ] Print backtrace for any processes
#   proc_by_pid  : [PL3] Print Linux processes/threads information 
#                        by assigning process ID
#                        (almost nearly equal to "proc")
#   proc_by_tskid: [PL3] Print Linux processes/threads information 
#                        by assigning task ID
#   show_ts      : [ L ] Print Linux processes/threads information 
#                        by assigning address of task_struct
#   procmeminfo  : [ L ] Print Linux processes/threads memory information
#                        by assigning task_struct address.
#   procmem_by_pid:[ L ] Print Linux processes/threads memory information
#                        by assigning process ID.
# <Task>
#   tsk_by_pid   : [PL3] Print TCB by assigning process ID
#   tsk_by_tskid : [PL3] Print TCB by assigning task ID
#                        (almost nearly equal to "tsk")
#   stkuse       : [P 3] Print task stack consumption rate
#   stkuselist   : [P 3] Print list of task stack consumption rate
#   stklist      : [P 3] Print list of the top of stack data for all tasks
#   stkinfo      : [   ] Print stack symbol information
# <Alarm>
#   almlist      : [P 3] Print list of all alarm messages
# <Address Operation>
#   v2p          : [ L ] Translate virtual address on current process
#                        to physical address
#   v2p_pid      : [ L ] Translate virtual address on any process
#                        to physical address
#
# <Internal Function> (used only in .gdbinit)
#   qingnum      : [P  ] Calcurate number of elements linked to rcb.que
#   qinglist     : [P  ] Print indexes of RCBs linked to rcb.que
#   qinglist_t   : [P  ] Print indexes of RCBs linked to rcb.que with type
#   print_cb     : [P  ] Print control block
#   procstat     : [ L ] Convert from state on task_struct to process status 
#   tskstat      : [P  ] Convert from taskstat on TCB to task status 
#   quemsg       : [P 3] Print queue message data
############################################################################

############################################################################
# << Internal Value >>
#
#shell stty -echo nl

define setarch
  set $MN2WS0002 = (unsigned int)1
  set $PARAGON = (unsigned int)2
  set $Peaks = (unsigned int)3
  set $PeaksLite = (unsigned int)4
  set $PeaksPro = (unsigned int)5

  set $arch = mn10300_build_arch
  set $build = mn10300_build_conf
  if $arch == $MN2WS0002
    set $buswidth = 0xae000000
  else
    if $arch == $PARAGON || $arch == $Peaks || $arch == $PeaksPro
      set $buswidth = 0xb0001ffc
    else
      if $arch == $PeaksLite
        set $buswidth = 0xac001ffc
      end
    end
  end
end

############################################################################
# << Basic Operation >>
#

#---------------------------------------------------------------------------
# Connect to gdbserver with ether (gdbserver)
#
#  * Describe in your .gdbinit and custumize on your environment.
#  * You must change IP address and port number, "10.73.176.hoge:hoge",
#    of server machine.                           ^^^^^^^^^^^^^^ ^^^^
#                                                      IP        PORT
#---------------------------------------------------------------------------
#define eth
#  target remote 10.73.176.hoge:hoge
#end
#document eth
#Connect to server with ether (gdbserver debug).
#| <usage>
#|   eth
#end

#---------------------------------------------------------------------------
# Connect to kernel monitor with serial 0 (kernel gdb)
#---------------------------------------------------------------------------
define com1
  set remotebaud 38400
  target remote /dev/ttyUSB0
  p/x $pc
end

document com1
Connect for serial debugging (serial 0)
end

#---------------------------------------------------------------------------
# Connect to kernel monitor with serial 1 (kernel gdb)
#---------------------------------------------------------------------------
define com2
  set remotebaud 38400
  target remote /dev/ttyS1
  p/x $pc
end

document com2
Connect for serial debugging (serial 1)
end

#---------------------------------------------------------------------------
# Escape from while(knl_debug); (kernel gdb)
#---------------------------------------------------------------------------
define ksta
  set knl_debug = 1
end

document ksta
Escape debug loop in PiE-Kernel (knl_boot.c).
end

#---------------------------------------------------------------------------
# Load PiE debug information (kernel gdb)
#
#  * Use in the case of executing
#    as "mn10300-linux-gdb pprosrc/root/usr/src/linux/vmlinux".
#  * Describe in your .gdbinit and custumize on your environment.
#---------------------------------------------------------------------------
#define pield
#  add-symbol-file /hoge/hoge/target.out 0x08000000
#end
#document pield
#Load dubug information and symbols of PiE process.
#| <usage>
#|   pield
#end

#---------------------------------------------------------------------------
# Load Linux debug information (kernel gdb)
#
#  * Use in the case of executing
#    as "mn10300-linux-gdb pie-target.out".
#  * Describe in your .gdbinit and custumize on your environment.
#---------------------------------------------------------------------------
#define linuxld
#  add-symbol-file /hoge/hoge/pprosrc/root/usr/src/linux/vmlinux 0x98000000
#end
#document linuxld
#Load dubug information and symbols of linux kernel.
#| <usage>
#|   linuxld
#end

#---------------------------------------------------------------------------
# Print registers
#
#  * This is created to print them with shorter lines than "info register".
#---------------------------------------------------------------------------
define regs
  printf "d0=0x%08x d1=0x%08x d2=0x%08x d3=0x%08x\n", $d0, $d1, $d2, $d3
  printf "a0=0x%08x a1=0x%08x a2=0x%08x a3=0x%08x\n", $a0, $a1, $a2, $a3
#	printf "r0=0x%08x r1=0x%08x r2=0x%08x r3=0x%08x\n", $r0, $r1, $r2, $r3
#	printf "r4=0x%08x r5=0x%08x r6=0x%08x r7=0x%08x\n", $r4, $r5, $r6, $r7
	printf "pc=0x%08x sp=0x%08x psw=0x%08x\n", $pc, $sp, $psw
end

document regs
Print registers.
| <usage>
|   regs
end

#---------------------------------------------------------------------------
# Step instruction with printing pc and sp
# 
#  * This is almost the same as that of the followings.
#    After
#     (gdb) display/i $pc
#    do
#     (gdb) si
#     (gdb) p/x $sp
#---------------------------------------------------------------------------
define sj
  echo EXEC PC=
  x/i $pc
  si
  printf " CURR PC=0x%08x\n", $pc
  printf "      SP=0x%08x\n", $sp
end

document sj
Execute instruction with printing PC and SP
| <usage>
|   sj
end

#---------------------------------------------------------------------------
# Display always $pc
#---------------------------------------------------------------------------
define disppc
  display/i $pc
end

############################################################################
# <Internal Function>
#

#---------------------------------------------------------------------------
# Calculate the number of elements linked to rcb.que
#---------------------------------------------------------------------------
define qingnum
  set $h = $arg0
  if $h == 0
    echo NULL
  else
    set $c = (((Que *)$h)->next)
    set $x = 0
    while $c != $h
      #-- check addr
      if ((int)($c) & 0x38000000) == 0x00000000
        printf "CRASHED!"
        set $x = -1
        set $c = $h
      else
        set $x = $x + 1
        set $c = ((RCB *)$c)->que.next
      end
    end
    if $x >= 0
      printf "%3d", $x
    end
  end
end

document qingnum
Calculate the number of cells linking a management queue.
| <usage>
|   qingnum addr
|
|     addr : address of a management queue
|
| <ex>
|   (gdb) qingnum &knl_ReadyQue
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print indexes of RCBs linked to rcb.que with type
#
# [SYNOPSIS]
#   qinglist_t <pointer to rcb.que> <type (KNL_TYPE_*)>
#---------------------------------------------------------------------------
define qinglist_t
  set $h = $arg0
  set $t = $arg1
  if $h == 0
    echo NULL
  else
    set $c = ((RCB *)$h)->que.next
    if $c != $h
      while $c != $h
        #-- check addr
        if ((int)($c) & 0x38000000) == 0x00000000
          printf "CRASHED!"
          set $c = $h
        else
          set $i = ((RCB *)$c)->id & 0x0000ffff
          if $t == 0x01
            if *(int *)&knl_VINFO_KERNEL == 0x03000000
              if $i == MAXTASK + 1
                echo TMR \0
              else
                printf "%d ", $i
              end
            else
              if *(int *)&knl_VINFO_KERNEL == 0x02000000
                if $i == 0
                  echo IDL \0
                else
                  if $i == MAXTASK + 1
                    echo INI \0
                  else
                    if $i == MAXTASK + 2
                      echo TMR \0
                    else
                      printf "%d ", $i
                    end
                  end
                end
              else
                printf "%d ", $i
              end                
            end
          else
            printf "%d ", $i
          end
          set $c = ((RCB *)$c)->que.next
        end
      end
    else
      echo no
    end
  end
end

document qinglist_t
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print indexes of RCBs linked to rcb.que
#---------------------------------------------------------------------------
define qinglist
  set $h = $arg0
  if $h == 0
    echo NULL
  else
    set $c = ((RCB *)$h)->que.next
    if $c != $h
      while $c != $h
        #-- check addr
        if ((int)($c) & 0x38000000) == 0x00000000
          printf "CRASHED!"
          set $c = $h
        else
          printf "%d ", ((RCB *)$c)->id & 0x0000ffff
          set $c = ((RCB *)$c)->que.next
        end
      end
    else
      echo no
    end
  end
end

document qinglist
Print list of index of cells linking a management queue.
| <usage>
|   qinglist addr
|
|     addr : address of a management queue
|
| <ex>
|   (gdb) qinglist &knl_ReadyQue
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print control block of kernel resources
#
# [SYNOPSIS]
#   print_cb <id|index>                        --- arg0 (*1)
#            <&(knl_cbmh.???)|&(knl_*CBArray)> --- arg1 (*2)
#            <-2(V3.0 mechanism)|
#             -1(V1.5 mechanism)|
#             MAX???(V2.0, V3.0)>              --- arg2 (*2)
#            <resource name>                   --- arg3
#
# (*1): In the case of id, it's checked whether it matches rcb.id or not.
#       In the case of index, it's not checked.
# (*2): In the case arg1 = &knl_*CBArray(&knl_SEMCBArray, etc),
#       if V2.0 or V3.0, then assign arg2 to MAX???(MAXSEM, etc),
#       if V1.5, then assign arg2 to -1 .
#       (id or index is not checked in using -1)
#       In the case arg1 = &(knl_cbmh.???)(&(knl_cbmh.sem), etc),
#       assign arg2 to -2 .
#
# [EXAMPLE]
#   print_cb 2 knl_TCBArray -1 task                  --- V1.5
#   print_cb 2 knl_MTXCBArray MAXMTX mutex           --- V2.0 or V3.0
#   print_cb 0x02000002 &(knl_cbmh.sem) -2 semaphore --- V3.0
#---------------------------------------------------------------------------
define print_cb
  if (int)$arg2 < -1
    set $static = 0
  else
    set $static = 1
  end
  if $static == 0
    set $cbmh = $arg1
    if $cbmh == &(knl_cbmh.tsk)
      set $max = ($cbmh)->max + 1
    else
      set $max = ($cbmh)->max
    end
    set $cbmc = ($cbmh)->cell
  else
    set $cbarray = $arg1
    set $max = $arg2
  end
  set $id = $arg0
  set $idx = $id & 0x0000ffff
  set $type = ($id & 0xff000000)
  if $id != $idx && $type != 0x01000000
    echo This ID is not $arg3's\n
  else
    if $id != $idx
      printf "<<CB[id=%08x]>>\n", $id
    else
      printf "<<CB[idx=%d]>>\n", $idx
    end
    if $idx > $max && 0 <= $max
      printf "Nonexistent.\n"
      printf "Index (%d) ", $idx
      printf "must be less than the number of $arg3s (%d + 1) .\n", $max
    else
      if $static == 0
        set $cb = ($cbmc)[$idx].cbp
      else
        set $cb = &(($cbarray)[$idx])
      end
      if $cb == 0
        echo Nonexistent.\n
        echo This $arg3 has never created.\n
      else
        #-- check addr
        if ((int)($cb) & 0x38000000) == 0x00000000
          printf "Pointer of CB has been crashed.\n"
        else
          if $id != $idx && $id != ($cb)->rcb.id
            echo Nonexistent.\n
            echo This dynamical creative arg3 has already deleted.\n
          else
            printf "addr=0x%08x\n", $cb
            output/x *($cb)
            echo \n
          end
        end
      end
    end
  end
end

document print_cb
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print queue message data
#
# [SYNOPSIS]
#  quemsg <pointer of QUEMSGCB> <size of message data to print>
#
# [EXAMPLE]
#   quemsg 0x80004000 8
#---------------------------------------------------------------------------
define quemsg
  set $c = (QUEMSGCB *)$arg0
  set $s = (int)$arg1
  printf "%08x %08x ", ($c)->que_id, ($c)->rcb.id
  if ($c)->sender_task == 0
    printf "  INTR "
  else
    printf "%6d ", (($c)->sender_task & 0x0000ffff)
  end
  printf "%7d ", ($c)->almtime
  set $i = 0
  while $i < $s
    printf "%02x ", ($c)->contents[$i]
    set $i++
  end
end

document quemsg
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print task stack consumption rate
#
# [SYNOPSIS]
#  print_stkuse <pointer of TCB>
#
# [EXAMPLE]
#   print_stkuse &knl_TCBArray[3]
#---------------------------------------------------------------------------
define print_stkuse
  set $c = $arg0
  set $t = ((TCB *)$c)->inittaskstack
  set $s = ((TCB *)$c)->stacksize
  if ((TCB *)$c)->taskstat == 0x00000000
    printf "---------- DORMANT ----------"
#    printf "     -"
#    printf "          -          - "
    printf "       "
  else
    #--- bottom check
    set $is = (InitStack *)((unsigned int)($t + $s) - 464)
#    set $is = (InitStack *)((unsigned int)($t + $s) - 44) #Pure-PiE
    if (($is)->taskentry != ((TCB *)$c)->taskentry || \
        ($is)->taskarg != ((TCB *)$c)->taskarg || \
        ($is)->taskid != (INT)((((TCB *)$c)->rcb.id) & 0x0000ffff))
      printf "  x"
    else
      printf "  o"
    end
    #--- peak check
    set $ad = $t
    while ((*($ad)) == 0) && ((unsigned int)$ad < (unsigned int)($t + $s))
      set $ad += 4
    end
    set $u = (($t + $s) - $ad)
    printf " %8d/%8d", $u, $s
    printf " %3d%%", ($u * 100) / $s
    if ($s - $u) < 128
      printf " * "
    else
      printf "   "
    end
  end
  #--- entry
  output/a ((TCB *)$c)->taskentry
end

document print_stkuse
(Internal macro by tak)
end


############################################################################
# << System >>
#

#---------------------------------------------------------------------------
# Print system information (/proc information)
#---------------------------------------------------------------------------
define sysinfo
  # include/asm-mn103e01/param.h
  set $HZ = 100
  # include/linux/kernel.h
  set $SI_LOAD_SHIFT = 16
  # include/linux/sched.h
  set $FSHIFT = 11
  set $FIXED_1 = (1 << $FSHIFT)
  # include/asm-mn103e01/page.h
  set $PAGE_SHIFT = 12
  set $PAGE_SIZE = (1 << $PAGE_SHIFT)
  # include/linux/mmzone.h
  set $MAX_NR_ZONES = 3
  set $ZONE_HIGHMEM = 2
  # include/linux/swap.h
  set $SWP_WRITEOK = 3
  set $SWAP_MAP_BAD = 0x8000
  set $INACTIVE_SHIFT = 6
  #---------- kernel/info.c:sys_sysinfo()
  #----- base calcurate
#  set $val_uptime		= jiffies / $HZ
#  set $val_loads0		= avenrun[0] << ($SI_LOAD_SHIFT - $FSHIFT)
#  set $val_loads1		= avenrun[1] << ($SI_LOAD_SHIFT - $FSHIFT)
#  set $val_loads2		= avenrun[2] << ($SI_LOAD_SHIFT - $FSHIFT)
#  set $val_procs		= nr_threads - 1
  #----- arch/mn103e01/mm/init.c:si_meminfo()
  set $val_totalram		= totalram_pages
  set $val_sharedram		= 0
  # [freeram] mm/page_alloc.c:nr_free_pages()
  set $pgdat = pgdat_list
  set $sum = 0
  while ($pgdat != 0)
    set $zone = $pgdat->node_zones
    while ($zone < $pgdat->node_zones + $MAX_NR_ZONES)
      set $sum += $zone->free_pages
      set $zone++
    end
    set $pgdat = $pgdat->node_next
  end
  set $val_freeram = $sum
  # [bufferram] include/asm-mn103e01/atomic.h:atomic_read()
  set $val_bufferram = (&buffermem_pages)->counter
  set $val_totalhigh = totalhigh_pages
  # [freehigh] mm/page_alloc.c:nr_free_highpages()
  set $pgdat = pgdat_list
  set $pages = 0
  while ($pgdat != 0)
    set $pages += $pgdat->node_zones[$ZONE_HIGHMEM].free_pages
    set $pgdat = $pgdat->node_next
  end
  set $val_freehigh = $pages
  set $val_mem_unit = $PAGE_SIZE
  
  #----- mm/swapfile.c:si_swapinfo()
  
  set $freeswap = 0
  set $totalswap = 0
  set $i = 0
  while ($i < nr_swapfiles)
    if ((swap_info[$i].flags & $SWP_WRITEOK) != $SWP_WRITEOK)
    else
      set $j = 0
      while ($j < swap_info[$i].max)
        set $swap_map = swap_info[$i].swap_map[$j]
        if ($swap_map == $SWAP_MAP_BAD)
        else
          if ($swap_map == 0)
            set $freeswap++
          else
            set $totalswap++
          end
        end
        set $j++
      end
    end
    set $i++
  end
  set $val_freeswap = $freeswap
  set $val_totalswap = $totalswap
  
  #----- here (adjustment for overflow)
  
  set $mem_total = $val_totalram + $val_totalswap
  set $end = 0
  if ($mem_total < $val_totalram || $mem_total < $val_totalswap)
    set $end = 1
  else
    set $bitcount = 0
    set $mem_unit = $val_mem_unit
    while ($mem_unit > 1 && $end == 0)
      set $bitcount++
      set $mem_unit >>= 1
      set $sav_total = $mem_total
      set $mem_total <<= 1
      if ($mem_total < $sav_total)
        set $end = 1
      end
    end
  end
  
  if ($end == 0)
    set $val_mem_unit = 1
    set $val_totalram <<= $bitcount
    set $val_freeram <<= $bitcount
    set $val_sharedram <<= $bitcount
    set $val_bufferram <<= $bitcount
    set $val_totalswap <<= $bitcount
    set $val_freeswap <<= $bitcount
    set $val_totalhigh <<= $bitcount
    set $val_freehigh <<= $bitcount
  end

#  #----- [val_inact_clean] mm/page_alloc.c:nr_inactive_clean_pages()
#  set $pgdat = pgdat_list
#  set $sum = 0
#  while ($pgdat != 0)
#    set $zone = $pgdat->node_zones
#    while ($zone < $pgdat->node_zones + $MAX_NR_ZONES)
#      set $sum += $zone->inactive_clean_pages
#      set $zone++
#    end
#    set $pgdat = $pgdat->node_next
#  end
#  set $val_inact_clean = $sum
#  #----- [val_inact_target] include/linux/swap.h
#  if ((memory_pressure >> $INACTIVE_SHIFT) < (num_physpages / 4))
#    set $val_inact_target = (memory_pressure >> $INACTIVE_SHIFT)
#  else
#    set $val_inact_target = (num_physpages / 4)
#  end
  ###----- PRINTING
  #----- uptime
  set $val_uptime		= jiffies
  set $idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime
  printf "#uptime : "
  printf "%lu.%02lu %lu.%02lu\n", \
	$val_uptime / $HZ, $val_uptime % $HZ, $idle / $HZ, $idle % $HZ
  #----- loadavg
  printf "#loadavg: %d.%02d %d.%02d %d.%02d %d/%d %d\n", \
	(avenrun[0] + ($FIXED_1 / 200)) >> $FSHIFT, \
	(((avenrun[0] + ($FIXED_1 / 200)) & ($FIXED_1 - 1))* 100) >> $FSHIFT, \
	(avenrun[1] + ($FIXED_1 / 200)) >> $FSHIFT, \
	(((avenrun[1] + ($FIXED_1 / 200)) & ($FIXED_1 - 1))* 100) >> $FSHIFT, \
	(avenrun[2] + ($FIXED_1 / 200)) >> $FSHIFT, \
	(((avenrun[2] + ($FIXED_1 / 200)) & ($FIXED_1 - 1))* 100) >> $FSHIFT, \
	nr_running, nr_threads, last_pid
  #----- meminfo
  printf "#meminfo: \n"
#  set $KB_SHIFT = ($PAGE_SHIFT - 10)
#  set $B_SHIFT = ($PAGE_SHIFT)
  set $KB_SHIFT = 10
  set $PAGE_KB_SHIFT = ($PAGE_SHIFT - $KB_SHIFT)
  set $B_SHIFT = 0
  printf "        total:    used:    free:  shared: buffers:  cached:\n"
  printf "Mem:  %8lu %8lu %8lu %8lu %8lu %8u\n", \
	($val_totalram) >> $B_SHIFT, \
	($val_totalram - $val_freeram) >> $B_SHIFT, \
	($val_freeram) >> $B_SHIFT, \
	($val_sharedram) >> $B_SHIFT, \
	($val_bufferram) >> $B_SHIFT, \
	((&page_cache_size)->counter) << $PAGE_SHIFT
  printf "Swap: %8lu %8lu %8lu\n", \
	($val_totalswap) >> $B_SHIFT, \
	($val_totalswap - $val_freeswap) >> $B_SHIFT, \
	($val_freeswap) >> $B_SHIFT
  printf "MemTotal:     %8lu kB\n", ($val_totalram) >> $KB_SHIFT
  printf "MemFree:      %8lu kB\n", ($val_freeram) >> $KB_SHIFT
  printf "MemShared:    %8lu kB\n", ($val_sharedram) >> $KB_SHIFT
  printf "Buffers:      %8lu kB\n", ($val_bufferram) >> $KB_SHIFT
  printf "Cached:       %8lu kB\n", \
	((&page_cache_size)->counter - swapper_space.nrpages) <<  $PAGE_KB_SHIFT
  printf "SwapCached:   %8lu kB\n", (swapper_space.nrpages) << $PAGE_KB_SHIFT
  printf "Active:       %8u kB\n", (nr_active_pages) << $PAGE_KB_SHIFT
  printf "Inactive:     %8u kB\n", (nr_inactive_pages) << $PAGE_KB_SHIFT
#  printf "Inact_dirty:  %8u kB\n", (nr_inactive_dirty_pages) << $PAGE_KB_SHIFT
#  printf "Inact_clean:  %8u kB\n", ($val_inact_clean) << $PAGE_KB_SHIFT
#  printf "Inact_target: %8lu kB\n", ($val_inact_target) << $PAGE_KB_SHIFT
  printf "HighTotal:    %8lu kB\n", ($val_totalhigh) >> $KB_SHIFT
  printf "HighFree:     %8lu kB\n", ($val_freehigh) >> $KB_SHIFT
  printf "LowTotal:     %8lu kB\n", \
	($val_totalram - $val_totalhigh) >> $KB_SHIFT
  printf "LowFree:      %8lu kB\n", ($val_freeram - $val_freehigh) >> $KB_SHIFT
  printf "SwapTotal:    %8lu kB\n", ($val_totalswap) >> $KB_SHIFT
  printf "SwapFree:     %8lu kB\n", ($val_freeswap) >> $KB_SHIFT
end

document sysinfo
Print system information.
| <usage>
|   sysinfo
|
| <ex>
|   (gdb) sysinfo
|   #uptime : 155.26 0.27
|   #loadavg: 2.20 0.99 0.37 1/127 130
|   #meminfo:
|           total:    used:    free:  shared: buffers:  cached:
|   Mem:  31739904 29884416  1855488       0        0  14692352
|   Swap:        0        0        0
|   MemTotal:     30996 kB
|   MemFree:       1808 kB
|   MemShared:        0 kB
|   Buffers:          0 kB
|   Cached:       14348 kB
|   SwapCached:       0 kB
|   Active:        5148 kB
|   Inact_dirty:   9128 kB
|   Inact_clean:     72 kB
|   Inact_target:     0 kB
|   HighTotal:        0 kB
|   HighFree:         0 kB
|   LowTotal:     30998 kB
|   LowFree:       1808 kB
|   SwapTotal:        0 kB
|   SwapFree:         0 kB
|
| <output format>
|   Refer to manual proc ("man proc") or
|   usr/src/linux/Documentation/filesystems/proc.txt
|
| <caution>
|   - Necessary Symbols: Linux
end

############################################################################
# << Process >>
#

#---------------------------------------------------------------------------
# Print status of Linux process
#
# [EXAMPLE]
#   procstat 0x00000000
#---------------------------------------------------------------------------
define procstat
  if $arg0 == 0
    printf "RUNNING     "
  else
    if $arg0 == 1
      printf "BLOCK(INT)  "
    else
      if $arg0 == 2
        printf "BLOCK(UNINT)"
      else
        if $arg0 == 4
          printf "STOPPED     "
        else
          if $arg0 == 8
            printf "TRACED      "
          else
            if $arg0 == 16
              printf "ZOMBIE      "
            else
              if $arg0 == 32
                printf "DEAD        "
              else
                printf "???         "
              end
            end
          end
        end
      end
    end
  end
end

document procstat
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print process information
#---------------------------------------------------------------------------
define procinfo
  set $t = (struct task_struct *)$arg0
  printf "<<Process/Thread>>\n"
##  printf "command    : "
##  print_comm $t
##  printf "\n"
  printf "command    : %s\n", &($t->comm)
  printf "task_struct: 0x%08x\n", $t
  printf "pid        : %d\n", ($t)->pid
  printf "state      : "
  procstat ($t)->state
  printf "\n"
  printf "policy     :"
  set $t_policy = ($t)->policy
  if $t_policy == 0
    printf " OTHER"
  else
    if $t_policy == 1
      printf " FIFO"
    else
      printf " RR"
    end
  end
  printf "\n"
  printf "nice       : %d(%d)\n", ($t)->prio, ($t)->static_prio
  printf "pri        : %d\n", ($t)->rt_priority
  printf "keep pc    : "
  set $tmp = (struct pt_regs *)(($t)->thread.sp0)
  if $tmp == 0
    printf "none"
  else
    output/a ((struct pt_regs *)(($t)->thread.sp0))->pc
  end
  printf "\n"
  printf "PiE task   : "
  if (pie_mm == ((struct task_struct *)$t)->mm)
    set $tskentry = ((unsigned long *)$t->thread.usp)[2]
    set $tskidx = ((unsigned long *)$t->thread.usp)[3]
    printf "ID=0x%08x idx=%d entry=", ($tskidx | 0x01000000), $tskidx
    output/a $tskentry
    printf "\n"
  else
    printf "This process is not PiE.\n"
  end
end

document procinfo
Print Linux processes/threads information by assigning task_struct address.
| <usage>
|   procinfo address
|
|     address : address of task_struct
|
| <ex>
|   (gdb) procinfo 0x9017e000
|
| <output format>
|   Refer to "proc_by_pid"
|
| <caution>
|   - Necessary Symbols: Linux
end

#---------------------------------------------------------------------------
# Print process information for memroy
#---------------------------------------------------------------------------
define procmeminfo
  set $t = (struct task_struct *)$arg0
  set $PAGE_SHIFT=12
  set $KB_SHIFT=10
  set $PAGE_KB_SHIFT=($PAGE_SHIFT - $KB_SHIFT)
  set $VM_GROWSDOWN=0x00000100
  set $VM_WRITE=0x00000002
  set $VM_EXEC=0x00000004
  set $VM_EXECUTABLE=0x00001000

  set $vmsize = $t->mm->total_vm  << $PAGE_KB_SHIFT
  set $vmlock = $t->mm->locked_vm  << $PAGE_KB_SHIFT
  set $vmrss = $t->mm->rss << $PAGE_KB_SHIFT
  set $vmdata = 0
  set $vmstk = 0
  set $vmexe = 0
  set $vmlib = 0

  set $vma = (struct vm_area_struct *)$t->mm->mmap
  while $vma != 0
    set $len = ($vma->vm_end - $vma->vm_start) >> $KB_SHIFT
    if $vma->vm_file == 0
	if ($vma->vm_flags & $VM_GROWSDOWN) != 0
	    set $vmstk = $vmstk + $len
	else
	    set $vmdata = $vmdata + $len
	end
    else
	if ($vma->vm_flags & $VM_WRITE) != 0
	else
	    if ($vma->vm_flags & $VM_EXEC) != 0
		set $vmexe = $vmexe + $len
		
		if ($vma->vm_flags & $VM_EXECUTABLE) != 0
		else
		    set $vmlib = $vmlib + $len
		end
	    end
	end
    end
    set $vma = $vma->vm_next
  end

  printf "VmSize:     %8lu kB\n", $vmsize
  printf "VmLck:      %8lu kB\n", $vmlock
  printf "VmRSS:      %8lu kB\n", $vmrss
  printf "VmData:     %8lu kB\n", $vmdata - $vmstk
  printf "VmStk:      %8lu kB\n", $vmstk
  printf "VmExe:      %8lu kB\n", $vmexe - $vmlib
  printf "VmLib:      %8lu kB\n", $vmlib
end

document procmeminfo
Print Linux processes/threads memory information by assigning task_struct address.
| <usage>
|   procmeminfo address
|
|     address : address of task_struct
|
| <ex>
|   (gdb) procmeminfo 0x9017e000
|
| <output format>
|   Refer to "procmem_by_pid"
|
| <caution>
|   - Necessary Symbols: Linux
end

#---------------------------------------------------------------------------
# Print Linux processes/threads memory information by assigning process ID.
#---------------------------------------------------------------------------
define procmem_by_pid
#----- pidhash version
  set $pid = $arg0
  if $pid <= 0
    echo Illegal pid.\n
  else
    #-- depend on Linux code (linux/include/linux/sched.h)
    set $PIDHASH_SZ = (4096 >> 2)
    set $hashno = (((($pid) >> 8) ^ ($pid)) & ($PIDHASH_SZ - 1))
    set $ts = (pidhash[$hashno])
    if $ts == 0
      echo This process does not exist.\n
    else
      set $ts_tgt = 0
      while $ts != 0
        if ($ts)->pid == $pid
          set $ts_tgt = $ts
        end
        set $ts = ($ts)->pidhash_next
      end
      if $ts_tgt == 0
        echo This process does not exist.\n
      else
        procmeminfo $ts_tgt
      end
    end
  end
end

document procmem_by_pid
Print Linux processes/threads memory information by assigning process ID.
| <usage>
|   proc_by_pid pid
|
|     pid : process ID
|
| <ex>
|   (gdb) procmem_by_pid 88
|   VmSize:       187432 kB
|   VmLck:          8452 kB
|   VmRSS:          8668 kB
|   VmData:         3588 kB
|   VmStk:             4 kB
|   VmExe:             0 kB
|   VmLib:             0 kB
end

#---------------------------------------------------------------------------
# Print process information (on PiE context)
#
# OFFSET INFORMATION
# (struct task_struct)
#   state               0x000	long
#   sigpending          0x008	int
#   need_resched        0x014	long
#   nice                0x024	long
#   policy              0x028	unsigned long
#   mm                  0x02c	struct mm_struct *
#   pid                 0x06c	pid_t
#   pgrp                0x070	pid_t
#   pidhash_next        0x0a0	struct task_struct *
#   rt_priority         0x0b8	unsigned long
#   uid                 0x120	uid_t
#   gid                 0x130	gid_t
#   comm                0x232	char[16]
#   thread.sp0          0x258
#   thread.usp          0x268
# (struct pt_regs)
#   psw                 0x064
#   pc                  0x068
#---------------------------------------------------------------------------
define pieprocinfo
  set $pid = $arg0
  set $t = KNL_db_get_tsinfo($pid)
  if ($t == 0)
    echo This process does not exist.\n
  else
    printf "<<Process/Thread>>\n"
    printf "command    : %s\n", knl_db_tsinfo.comm
    printf "task_struct: 0x%08x\n", $t
    printf "pid        : %d\n", knl_db_tsinfo.pid
    printf "state      : "
    procstat (knl_db_tsinfo.state)
    printf "\n"
    printf "policy     :"
    set $t_policy = knl_db_tsinfo.policy
    if $t_policy == 0
      printf " OTHER"
    else
      if $t_policy == 1
        printf " FIFO"
      else
        printf " RR"
      end
    end
    printf "\n"
    printf "nice       : %d\n", knl_db_tsinfo.nice
    printf "pri        : %d\n", knl_db_tsinfo.rt_priority
    printf "PiE task   : "
    set $initstk = knl_db_tsinfo.initstk
      set $tskentry = ((unsigned long *)$initstk)[2]
      set $tskidx = ((unsigned long *)$initstk)[3]
      printf "ID=0x%08x idx=%d entry=", ($tskidx | 0x01000000), $tskidx
      output/a $tskentry
      printf "\n"
  end
#  set $t = $arg0
#  printf "<<Process/Thread>>\n"
#  printf "command    : "
#  pieprint_comm $t
#  printf "\n"
#  printf "task_struct: 0x%08x\n", $t
#  printf "pid        : %d\n", KNL_db_read_ioctl($t + 0x006c)
#  printf "state      : "
#  set $tmp_stat = KNL_db_read_ioctl($t + 0x0000)
#  procstat $tmp_stat
#  printf "\n"
#  printf "policy     :"
#  set $t_policy = KNL_db_read_ioctl($t + 0x0028)
#  if $t_policy == 0
#    printf " OTHER"
#  else
#    if $t_policy == 1
#      printf " FIFO"
#    else
#      printf " RR"
#    end
#  end
#  printf "\n"
#  printf "nice       : %d\n", KNL_db_read_ioctl($t + 0x0024)
#  printf "pri        : %d\n", KNL_db_read_ioctl($t + 0x00b8)
##  printf "keep pc    : "
##  set $tmp = KNL_db_read_ioctl($t + 0x0258)
##  output/a KNL_db_read_ioctl($tmp + 0x0068)
##  printf "\n"
#  printf "PiE task   : "
#  set $t_thread_usp = KNL_db_read_ioctl($t + 0x0268)
#    set $tskentry = ((unsigned long *)$t_thread_usp)[2]
#    set $tskidx = ((unsigned long *)$t_thread_usp)[3]
#    printf "ID=0x%08x idx=%d entry=", ($tskidx | 0x01000000), $tskidx
#    output/a $tskentry
#    printf "\n"
end

#---------------------------------------------------------------------------
# Print task_struct of Linux processes/threads
#
# [EXAMPLE]
#   proc 15
#
# [REMARK]
#   You can know pid of PiE task by checking The last member "pid" of TCB .
#---------------------------------------------------------------------------
define proc
  echo <<task_struct[pid=$arg0]>>\n
  set $pid = $arg0
  if $pid <= 0
    echo Illegal pid.\n
  else
    #-- depend on Linux code (linux/include/linux/sched.h)
    set $PIDHASH_SZ = (4096 >> 2)
    set $hashno = (((($pid) >> 8) ^ ($pid)) & ($PIDHASH_SZ - 1))
    set $ts = (pidhash[$hashno])
    if $ts == 0
      echo This process does not exist.\n
    else
      set $ts_tgt = 0
      while $ts != 0
        if ($ts)->pid == $pid
          set $ts_tgt = $ts
        end
        set $ts = ($ts)->pidhash_next
      end
      if $ts_tgt == 0
        echo This process does not exist.\n
      else
        set $ts = $ts_tgt
#        printf "addr=0x%08x\n", $ts
        output/x *($ts)
        echo \n
#        echo<<Registers: (*(struct pt_regs *)task_struct.thread.sp0)>>\n
#        output/x *(struct pt_regs *)(($ts)->thread.sp0)
#        echo \n
        procinfo $ts
      end
    end
  end
end

document proc
Print task_struct of Linux processes/threads by assigning pid.
| <usage>
|   proc pid
|
|     pid : process ID
|
| <ex>
|   (gdb) proc 15
|
| <caution>
|   - Necessary Symbols: Linux
|
| <remark>
|   - The last member of TCB is pid of PiE task.
|     You can get a pid for a PiE task with 'tsk' or 'tsklist' command.
end

#---------------------------------------------------------------------------
# Print Linux processes/threads information by assigning process ID.
#---------------------------------------------------------------------------
define proc_by_pid
#----- pidhash version
  set $pid = $arg0
  if $pid <= 0
    echo Illegal pid.\n
  else
    #-- depend on Linux code (linux/include/linux/sched.h)
    set $PIDHASH_SZ = (4096 >> 2)
    set $hashno = (((($pid) >> 8) ^ ($pid)) & ($PIDHASH_SZ - 1))
    set $ts = (pidhash[$hashno])
    if $ts == 0
      echo This process does not exist.\n
    else
      set $ts_tgt = 0
      while $ts != 0
        if ($ts)->pid == $pid
          set $ts_tgt = $ts
        end
        set $ts = ($ts)->pidhash_next
      end
      if $ts_tgt == 0
        echo This process does not exist.\n
      else
        procinfo $ts_tgt
      end
    end
  end
#----- init_task version
#  set $cur = &(((union task_union)init_task_union).task)
#  set $last = init_task_union.task.prev_task
#  set $end = 0
#  while ($cur != $last && $end == 0)
#    if ($cur->pid == $arg0)
#      procinfo $cur
#      set $end = 1
#    end
#    set $cur = $cur->next_task
#  end
end

document proc_by_pid
Print Linux processes/threads information by assigning process ID.
| <usage>
|   proc_by_pid pid
|
|     pid : process ID
|
| <ex>
|   (gdb) proc_by_pid 88
|   <<Process/Thread>>
|   command    : estb_v0
|   task_struct: 0x90e5a000
|   pid        : 88
|   state      : BLOCK(INT)
|   policy     : FIFO
|   nice       : 0
|   pri        : 87
|   keep pc    : 0x8008c0f <KNL_core_scheduler_real+168>
|   PiE task   : ID=0x01000002 idx=2 entry=0x08012132 <VDR_task>
|
| <output format>
|   command     : command name of process or user name of thread
|   task_struct : address of task_struct
|   pid         : process ID
|   state       : status of process (RUNNING/BLOCK(INT/UNINT)/ZOMBIE/STOP)
|   policy      : scheduling policy (FIFO/RR/OTHER)
|   nice        : nice value
|   pri         : real time priority
|   keep pc     : program counter before entering super viser mode
|   PiE task    : PiE task information (ID,idx,entry)
|
| <caution>
|   - Necessary Symbols: Linux
end

#---------------------------------------------------------------------------
# Print Linux processes/threads information by assigning process ID.
# (on PiE context)
#---------------------------------------------------------------------------
define pieproc
  set $pid = $arg0
  if $pid <= 0
    echo Illegal pid.\n
  else
    pieprocinfo $pid
#    set $ts = KNL_db_get_task_struct($pid)
#    if ($ts == 0)
#      echo This process does not exist.
#    else
#      pieprocinfo $ts
#    end
##    set $pidhash = KNL_db_get_pidhash()
##    #-- depend on Linux code (linux/include/linux/sched.h)
##    set $PIDHASH_SZ = (4096 >> 2)
##    set $hashno = (((($pid) >> 8) ^ ($pid)) & ($PIDHASH_SZ - 1))
##    set $ts = KNL_db_read_ioctl($pidhash + ($hashno * 4))
##    if $ts == 0
##      echo This process does not exist.
##    else
##      set $ts_tgt = 0
##      while $ts != 0
##        set $tmp = KNL_db_read_ioctl($ts + 0x006c)
##        if $tmp == $pid
##          set $ts_tgt = $ts
##        end
##        set $ts = KNL_db_read_ioctl($ts + 0x00a0)
##      end
##      if $ts_tgt == 0
##        echo This process does not exist.
##      else
##        pieprocinfo $ts_tgt
##      end
##    end
  end
end

document pieproc
Print Linux processes/threads information by assigning process ID.
| <usage>
|   pieproc pid
|
|     pid         : process ID
|
| <ex>
|   (gdb) pieproc 69
|   <<Process/Thread>>
|   command    : estb_v0
|   task_struct: 0x90df0000
|   pid        : 69
|   state      : RUNNING
|   policy     : FIFO
|   nice       : 0
|   pri        : 84
|   PiE task   : ID=0x01000003 idx=3 entry=0x82cb6a8 <TDR_task_0>
|
| <output format>
|   command     : command name of process or user name of thread
|   task_struct : address of task_struct
|   pid         : process ID
|   state       : status of process (RUNNING/BLOCK(INT/UNINT)/ZOMBIE/STOP)
|   policy      : scheduling policy (FIFO/RR/OTHER)
|   nice        : nice value
|   pri         : real time priority
|   PiE task    : PiE task information (ID,idx,entry)
|
| <caution>
|   - Necessary Symbols: PiE
|   - You can use only on PiE context with GDBSERVER.
end

#---------------------------------------------------------------------------
# Print Linux processes/threads information by assigning task ID.
#---------------------------------------------------------------------------
define proc_by_tskid
  set $id = $arg0
  set $idx = $id & 0x0000ffff
  set $type = ($id & 0xff000000)
  if $id != $idx && $type != 0x01000000
    echo This ID is not task's\n
  else
    set $cb = (knl_cbmh.tsk.cell)[$idx].cbp
    if ($cb == 0)
      printf "task %08x is NONEXISTENT.\n", $arg0
    else
      if ($id != $idx && $cb->rcb.id != $id)
        echo Nonexistent.\n
      else
        if ($cb->taskstat == 0x00000000)
          printf "task %08x is DORMANT.\n", $arg0
        else
#----- pidhash version
          #-- depend on Linux code (linux/include/linux/sched.h)
          set $PIDHASH_SZ = (4096 >> 2)
          set $hashno = 0
          set $end = 0
          while ($hashno < $PIDHASH_SZ && $end == 0)
            set $ts = (pidhash[$hashno])
            while $ts != 0
              if ((int)($ts) & 0x80000000) != 0x80000000
                printf " CRASHED!"
              else
                if ($ts->pid == $cb->pid)
                  tsk_by_tskid $id
                  procinfo $ts
                  set $end = 1
                end
              end
              set $ts = ($ts)->pidhash_next
            end
            set $hashno++
          end
#----- init_task version
#          set $cur = &(((union task_union)init_task_union).task)
#          set $last = init_task_union.task.prev_task
#          set $end = 0
#          while ($cur != $last && $end == 0)
#            if ($cur->pid == $cb->pid)
#              procinfo $cur
#              tsk_by_tskid $id
#              set $end = 1
#            end
#            set $cur = $cur->next_task
#          end
          if ($end == 0)
            echo "Nonexistent.\n"
          end
        end
      end
    end
  end
end

document proc_by_tskid
Print Linux processes/threads information by assigning task ID.
| <usage>
|   proc_by_tskid tskid
|
|     tskid : ID or index of task
|
| <ex>
|   (gdb) proc_by_tskid 2
|   <<Process/Thread>>
|   command    : estb_v0
|   task_struct: 0x90e5a000
|   pid        : 88
|   state      : BLOCK(INT)
|   policy     : FIFO
|   nice       : 0
|   pri        : 87
|   keep pc    : 0x8008c0f <KNL_core_scheduler_real+168>
|   PiE task   : ID=0x01000002 idx=2 entry=0x08012132 <VDR_task>
|   <<Task>>
|   entry      : 0x8012132 <VDR_task>
|   TCB        : 0x08ac0e6c
|   id         : 0x01000002
|   state      : WAIT(QUE)
|   pri        : 4
|   stack top  : 0x884d8dc <CFG_STACK_002>
|   stack size : 2048
|   pid        : 88
|
| <output format>
|   Refer to "proc_by_pid" and "tsk_by_tskid"
|
| <caution>
|   - Necessary Symbols: Linux and PiE
end

#---------------------------------------------------------------------------
# Show task_struct
#---------------------------------------------------------------------------
define print_vm_flags
  # currently active flags
  set $VM_READ		 = 0x00000001
  set $VM_WRITE		 = 0x00000002
  set $VM_EXEC		 = 0x00000004
  set $VM_SHARED	 = 0x00000008
  # limits for mprotect() etc
  set $VM_MAYREAD	 = 0x00000010
  set $VM_MAYWRITE	 = 0x00000020
  set $VM_MAYEXEC	 = 0x00000040
  set $VM_MAYSHARE	 = 0x00000080
  #
  set $VM_GROWSDOWN	 = 0x00000100
  set $VM_GROWSUP	 = 0x00000200
  set $VM_SHM		 = 0x00000400
  set $VM_DENYWRITE	 = 0x00000800
  set $VM_EXECUTABLE	 = 0x00001000
  set $VM_LOCKED	 = 0x00002000
  set $VM_IO           	 = 0x00004000
  # Used by sys_madvise() */
  set $VM_SEQ_READ	 = 0x00008000
  set $VM_RAND_READ	 = 0x00010000
  #
  set $VM_DONTCOPY	 = 0x00020000
  set $VM_DONTEXPAND	 = 0x00040000
  set $VM_RESERVED	 = 0x00080000
  #
  set $VM_STACK_FLAGS	 = 0x00000177
  set $vm_flags = $arg0
  if ($vm_flags & $VM_READ)
    echo R
  else
    echo -
  end
  if ($vm_flags & $VM_WRITE)
    echo W
  else
    echo -
  end
  if ($vm_flags & $VM_EXEC)
    echo X
  else
    echo -
  end
  if ($vm_flags & $VM_SHARED)
    echo S
  else
    echo -
  end

#  printf " "
#  if ($vm_flags & $VM_MAYREAD)
#    echo R
#  else
#    echo -
#  end
#  if ($vm_flags & $VM_MAYWRITE)
#    echo W
#  else
#    echo -
#  end
#  if ($vm_flags & $VM_MAYEXEC)
#    echo X
#  else
#    echo -
#  end
#  if ($vm_flags & $VM_MAYSHARE)
#    echo S
#  else
#    echo -
#  end

  printf " "
  if ($vm_flags & $VM_GROWSDOWN)
    echo D
  else
    echo -
  end
  if ($vm_flags & $VM_GROWSUP)
    echo U
  else
    echo -
  end

  printf " "
  if ($vm_flags & $VM_SHM)
    echo H
  else
    echo -
  end
  if ($vm_flags & $VM_DENYWRITE)
    echo D
  else
    echo -
  end

  printf " "
  if ($vm_flags & $VM_EXECUTABLE)
    echo X
  else
    echo -
  end
  if ($vm_flags & $VM_LOCKED)
    echo L
  else
    echo -
  end
  if ($vm_flags & $VM_IO)
    echo I
  else
    echo -
  end

  printf " "
  if ($vm_flags & $VM_SEQ_READ)
    echo S
  else
    echo -
  end
  if ($vm_flags & $VM_RAND_READ)
    echo R
  else
    echo -
  end

  printf " "
  if ($vm_flags & $VM_DONTCOPY)
    echo -
  else
    echo C
  end
  if ($vm_flags & $VM_DONTEXPAND)
    echo -
  else
    echo E
  end
  if ($vm_flags & $VM_RESERVED)
    echo R
  else
    echo -
  end
end
define print_vm_area_struct
  set $curmm = (struct vm_area_struct *)$arg0
  if ($curmm == 0)
    printf "     NULL\n"
  else
    printf "     vm_start   vm_end       vm_pgoff  vm_flags\n"
    while ($curmm != 0)
      printf "     0x%08x 0x%08x : 0x%05x   ", \
             $curmm->vm_start, $curmm->vm_end, \
             $curmm->vm_pgoff
      print_vm_flags $curmm->vm_flags
      printf "\n"
      set $curmm = $curmm->vm_next
    end
  end
end
define show_ts
  set $ts = (struct task_struct *)$arg0
  printf "------------------------------------------------------\n"
  printf "task_struct       0x%x\n", $ts
#  printf "comm              ["
#  print_comm $ts
#  printf "]\n"
  printf "comm              [%s]\n", &($ts->comm)
  printf "pid,pgrp,session  %d,%d,%d\n", $ts->pid, $ts->pgrp, $ts->session
  printf "mm                0x%08x\n", $ts->mm
  if ($ts->mm != 0)
    printf "mm->pgd           0x%08x\n", $ts->mm->pgd
    printf "mm->mmap:\n"
    print_vm_area_struct $ts->mm->mmap
#    printf "mm->mmap_avl:\n"
#    print_vm_area_struct $ts->mm->mmap_avl
#    printf "mm->mmap_cache:\n"
#    print_vm_area_struct $ts->mm->mmap_cache
  end
end
document show_ts
Show task_struct information of processes/threads.
| <usage>
|   show_ts address
|
|     address : address of task_struct
|
| <ex>
|   (gdb) show_ts 0x915ec000
|   ------------------------------------------------------
|   task_struct       0x915ec000
|   comm              [demo]
|   pid,pgrp,session  20,0,0
|   mm      :         0x91fdc2d0
|   mm->pgd :         0x91db6000
|   mm->mmap:
|        vm_start   vm_end       vm_pgoff  vm_flags
|        0x08000000 0x082e8000 : 0x00001   RWX- -- -D XL- -- CE-
|        0x082e8000 0x08434000 : 0x00000   RWX- -- -- -L- -- CE-
|   ...
|
| <output format>
|   task_struct : address of task_struct
|   comm        : command name
|   mm          : address of mm_struct
|   mm->pgd     : address of pgd
|   mm->mmap    : information of mmap
|                  vm_start : start address
|                  vm_end   : end address
|                  vm_pgoff : offset in PAGE_SIZE
|                  vm_flags : flags about mmap [RWXS DU HD XLI SR CER]
|                              R : page can be read
|                              W : page can be written
|                              X : page can be executed
|                              S : share changes
|                              -------------------------------------------
|                              D : grows down segment (stack-like segment)
|                              U : grows up segment
|                              -------------------------------------------
|                              H : shared memory area, don't swap out
|                              D : ETXTBSY on write attempts..
|                              -------------------------------------------
|                              X : mark it as an executable
|                              L : pages are locked
|                              I : memory mapped I/O or similar
|                              -------------------------------------------
|                              S : app will access data sequentially
|                              R : app will not benefit from clustered
|                              -------------------------------------------
|                              C : copy this vma on fork
|                              E : can expand with mremap()
|                              R : don't unmap it from swap_out
|
| <caution>
|   - Necessary Symbols: Linux
end

define show_ts_by_pid
#----- pidhash version
  set $pid = $arg0
  if $pid <= 0
    echo Illegal pid.\n
  else
    #-- depend on Linux code (linux/include/linux/sched.h)
    set $PIDHASH_SZ = (4096 >> 2)
    set $hashno = (((($pid) >> 8) ^ ($pid)) & ($PIDHASH_SZ - 1))
    set $ts = (pidhash[$hashno])
    if $ts == 0
      echo This process does not exist.\n
    else
      set $ts_tgt = 0
      while $ts != 0
        if ($ts)->pid == $pid
          set $ts_tgt = $ts
        end
        set $ts = ($ts)->pidhash_next
      end
      if $ts_tgt == 0
        echo This process does not exist.\n
      else
        show_ts $ts_tgt
      end
    end
  end
end

#---------------------------------------------------------------------------
# Print command name (task_struct->comm) by assigned task_struct address
#---------------------------------------------------------------------------
define print_comm
  set $i = 0
  while (((struct task_struct *)$arg0)->comm[$i] != 0)
    printf "%c", ($arg0)->comm[$i]
    set $i++
  end
  printf "\n"
end

document print_comm
(Internal macro by tak)
end

define pieprint_comm
  set $tmp_ts = (unsigned long)$arg0
  set $i = 0
  set $end = 0
  while ($i < 20 && $end == 0)
    set $tmp = KNL_db_read_ioctl((unsigned long)$arg0 + 0x0230 + $i)
    set $tmp_mask = 0x000000ff
    set $tmp_shift = 0
    set $j = 0
    while ($j < 4 && $end == 0)
#      printf "[%d %d]", $i, $j
      if ($i == 18 || $i == 19)
        set $end = 1
      else
        if ($i == 0 || $i == 1)
          set $tmp_shift += 8
          set $i++
          set $j++
        else
          set $tmp_data = ($tmp & ($tmp_mask << $tmp_shift)) >> $tmp_shift
          if ($tmp_data != '\0')
            printf "%c", $tmp_data
            set $tmp_shift += 8
            set $i++
            set $j++
          else
            set $end = 1
          end
        end
      end
    end
  end
end

#---------------------------------------------------------------------------
# Print command name (task_struct->comm) by assigned process ID
#---------------------------------------------------------------------------
define print_comm_by_pid
    set $pid = $arg0
    #-- depend on Linux code (linux/include/linux/sched.h)
    set $PIDHASH_SZ = (4096 >> 2)
    set $hashno = (((($pid) >> 8) ^ ($pid)) & ($PIDHASH_SZ - 1))
    set $ts = (pidhash[$hashno])
    if $ts == 0
      echo This process does not exist.\n
    else
      set $ts_tgt = 0
      while $ts != 0
        if ($ts)->pid == $pid
          set $ts_tgt = $ts
        end
        set $ts = ($ts)->pidhash_next
      end
      if $ts_tgt == 0
        echo This process does not exist.\n
      else
        print_comm $ts_tgt
#        printf "%s", &($ts_tgt->comm)
      end
    end
end

document print_comm_by_pid
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print list of all Linux processes/threads
#
# [SYNOPSIS]
#   proclist
#---------------------------------------------------------------------------
define proclist
  set $ts = &init_task
  set $ts = (unsigned int)(($ts)->tasks.next)-(unsigned int)(&((task_t *)0)->tasks)
  printf "   pid : state       policy   nice    prio cpu        command task_t\n"
  while $ts != &init_task
    set $ts = (task_t *)$ts
    printf "[%5d]:", ((task_t *)$ts)->pid
    printf " "
    procstat ($ts)->state
    if ($ts)->policy == 0
      printf " OTHER "
    else
      if ($ts)->policy == 1
        printf " FIFO  "
      else
        printf " RR    "
      end
    end
    printf " %3d(%3d) %3d   %d", ($ts)->prio, ($ts)->static_prio, ($ts)->rt_priority, ($ts)->thread_info->cpu
    printf " %15s", &($ts->comm)
    printf " 0x%08x\n", $ts
    set $ts = (unsigned int)(($ts)->tasks.next)-(unsigned int)(&((task_t *)0)->tasks)
  end
end

document proclist
Print list of all Linux processes/threads.
| <usage>
|   proclist
|
| <ex>
|   (gdb) proclist
|    pid : state       policy   nice    prio cpu        command task struct
| [    1]: BLOCK(INT)   OTHER  116(120)   0   0            init 0x9da20cc0
| [    2]: BLOCK(INT)   FIFO     0(120)  99   0     migration/0 0x9da20680
| [    3]: BLOCK(INT)   OTHER  134(139)   0   0     ksoftirqd/0 0x9da20360
|   ...
|
| <output format>
|   pid     : process ID
|   state   : status of process (RUNNING/BLOCK(INT/UNINT)/ZOMBIE/STOP)
|   policy  : scheduling policy (FIFO/RR/OTHER)
|   nice    : nice value
|   pri     : real time priority
|   rs      : need_resched flag
|   command : command name of process or user name of thread
|
| <caution>
|   - Necessary Symbols: Linux
|
| <remark>
|   - The last member of TCB is pid of PiE task.
|     You can get a pid for a PiE task with 'tsk' or 'tsklist' command.
end

#---------------------------------------------------------------------------
# switchto
#
# [SYNOPSIS]
#   switchto <task_t *>
#
# [EXAMPLE]
#   (gdb) proclist
#      pid : state       policy   nice    prio cpu        command task_t
#         1: BLOCK(INT)   OTHER  116(120)   0   0            init 0x9da20cc0
#         2: BLOCK(INT)   FIFO     0(120)  99   0     migration/0 0x9da20680
#         3: BLOCK(INT)   OTHER  134(139)   0   0     ksoftirqd/0 0x9da20360
#                           ....
#       100: BLOCK(INT)   OTHER  134(139)   0   0           a.out 0x9da20380
#   (gdb) switchto 0x9da20380  <== switch to a.out
#---------------------------------------------------------------------------
define switchtouser
  setarch
  if $build == 1
    set $ts = ((struct thread_info *)(($ssp - 1) & 0xffffe000))->task
  else
    set $ts = ((struct thread_info *)(($ssp - 1) & 0xfffff000))->task
  end
  if (((int)$ts & 0xf0000000) != 0x90000000)
    printf "This sp 0x%08x is not on Linux Kernel context.\n", $sp
  else
    set $pc_org_switchtouser = $pc
    set $sp_org_switchtouser = $sp
    set $ts_org_switchtouser = $ts
    set $ts_tgt = (task_t *)$arg0
    set $regs = (struct pt_regs *)(($ts_tgt)->thread.sp0)
    set $pc = ($regs)->pc
    set $sp = ($regs)->sp
    if (($ts_tgt)->mm != ($ts)->mm) 
      set $mm_org_switchtouser = ($ts)->mm
      ed 0xc0000098 ($ts_tgt)->mm->pgd
      ew 0xc0000094 ($ts_tgt)->mm->pgd[1023]
    else
      set $mm_org_switchtouser = (struct mm_struct *)0
    end
  end
end

define switchtouser_recover
    if ((void *)$mm_org_switchtouser != (void *)0)
      ed 0xc0000098 ($mm_org_switchtouser)->pgd
      ew 0xc0000094 ($mm_org_switchtouser)->pgd[1023]
    end
    set $pc=$pc_org_switchtouser
    set $sp=$sp_org_switchtouser
end

document switchtouser
Swtich to any process(or thread) on user area.
| <usage>
|   switchtouser  task_t
|
| <ex>
|   (gdb) proclist
|    pid : state       policy   nice    prio cpu        command task_t
| [    1]: BLOCK(INT)   OTHER  116(120)   0   0            init 0x9da20cc0
| [    2]: BLOCK(INT)   FIFO     0(120)  99   0     migration/0 0x9da20680
| [    3]: BLOCK(INT)   OTHER  134(139)   0   0     ksoftirqd/0 0x9da20360
|          ...
| [  100]: BLOCK(INT)   OTHER  134(139)   0   0           a.out 0x9da20380
|
|   (gdb) switchtouser 0x9da20380
|          switch to a.out on user area.
|
| <caution>
|   - Necessary Symbols: Linux and target process.
|
| <remark>
|   - If you want to recover, please use switchto_recover.
end

document switchtouser_recover
Recover to original frame from switchtouser frame.
| <usage>
|   switchtouser_recover
end

define switchtokernel
    set $pc_org_switchtokernel = $pc
    set $sp_org_switchtokernel = $sp
    set $ts_tgt = (task_t *)$arg0
    set $regs = (struct pt_regs *)(($ts_tgt)->thread.sp0)
    set $sp = ($ts_tgt)->thread.a3 + 0x20
    set $pc = *(unsigned long *)$sp
end

define switchtokernel_recover
    set $pc=$pc_org_switchtokernel
    set $sp=$sp_org_switchtokernel
end

document switchtokernel
Swtich to any process(or thread) in kernel area.
| <usage>
|   switchtokernel  task_t
|
| <ex>
|   (gdb) proclist
|    pid : state       policy   nice    prio cpu        command task_t
| [    1]: BLOCK(INT)   OTHER  116(120)   0   0            init 0x9da20cc0
| [    2]: BLOCK(INT)   FIFO     0(120)  99   0     migration/0 0x9da20680
| [    3]: BLOCK(INT)   OTHER  134(139)   0   0     ksoftirqd/0 0x9da20360
|          ...
| [  100]: BLOCK(INT)   OTHER  134(139)   0   0           a.out 0x9da20380
|
|   (gdb) switchtokernel 0x9da20380
|          switch to a.out on kernel area.
|
| <caution>
|   - Necessary Symbols: Linux and target process.
|
| <remark>
|   - If you want to recover, please use switchto_recover.
end

document switchtokernel_recover
Recover to original frame from switchtokernel frame.
| <usage>
|   switchtokernel_recover
end

#---------------------------------------------------------------------------
# Print list of modules.
#---------------------------------------------------------------------------
define modulelist
  set $list = ((struct list_head *)&modules)->next
  printf "           name  start address\n"
  printf "------------------------------\n"
  while $list != &modules
    set $mod = (struct module *)((unsigned long)($list)-4)
    printf "%15s  0x%08x\n", ($mod)->name, ($mod)->module_core
    set $list = $list->next
  end
end
document modulelist
print list of moduls
| <usage>
|   modulelist
|
| <ex>
|   (gdb) modulelist
|   name  start address
|   ------------------------------
|   combined_init  0x0142c000
|             nfs  0x01035000
|           lockd  0x0104e000
|          sunrpc  0x0106c000
|
| <caution>
|   - Necessary Symbols: Linux.
end

#---------------------------------------------------------------------------
# Print current process information
#---------------------------------------------------------------------------
define current
  setarch
  if $build == 1
    set $ts = ((struct thread_info *)(($ssp - 1) & 0xffffe000))->task
  else
    set $ts = ((struct thread_info *)(($ssp - 1) & 0xfffff000))->task
  end
  if (((int)$ts & 0xf0000000) != 0x90000000)
    printf "This sp 0x%08x is not on Linux Kernel context.\n", $sp
  else
    procinfo $ts
  end
end

document current
Print current process information.
| <usage>
|   current
|
| <ex>
|   (gdb) current
|   <<Process/Thread>>
|   command    : estb_v0
|   task_struct: 0x90e1a000
|   pid        : 93
|   state      : BLOCK(INT)
|   policy     : FIFO
|   nice       : 0
|   pri        : 84
|   keep pc    : 0x82ab3b0
|   PiE task   : ID=0x01000004 idx=4 entry=0x082de734
|
| <output format>
|   command     : command name of process or user name of thread
|   task_struct : address of task_struct
|   pid         : process ID
|   state       : status of process (RUNNING/BLOCK(INT/UNINT)/ZOMBIE/STOP)
|   policy      : scheduling policy (FIFO/RR/OTHER)
|   nice        : nice value
|   pri         : real time priority
|   keep pc     : program counter before entering super viser mode
|   PiE task    : PiE task information (ID,idx,entry)
|
| <caution>
|   - Necessary Symbols: Linux
end

#---------------------------------------------------------------------------
# Print current process information (on PiE context)
#---------------------------------------------------------------------------
define piecurrent
#  set $ts = KNL_db_get_task_struct(0)
#  pieprocinfo $ts
  pieprocinfo 0
end

document piecurrent
Print current process information.
| <usage>
|   piecurrent
|
| <ex>
|   (gdb) piecurrent
|   <<Process/Thread>>
|   command    : estb_v0
|   task_struct: 0x90e1a000
|   pid        : 93
|   state      : BLOCK(INT)
|   policy     : FIFO
|   nice       : 0
|   pri        : 84
|   PiE task   : ID=0x01000004 idx=4 entry=0x082de734
|
| <output format>
|   command     : command name of process or user name of thread
|   task_struct : address of task_struct
|   pid         : process ID
|   state       : status of process (RUNNING/BLOCK(INT/UNINT)/ZOMBIE/STOP)
|   policy      : scheduling policy (FIFO/RR/OTHER)
|   nice        : nice value
|   pri         : real time priority
|   PiE task    : PiE task information (ID,idx,entry)
|
| <caution>
|   - Necessary Symbols: PiE
|   - You can use only on PiE context with GDBSERVER.
end

#---------------------------------------------------------------------------
# Print backtrace for any processes
#
# [EXAMPLE]
#   btany 15
#
# [CAUTION]
#   If the message "Cannot access memory at address 0x????." or so on
#   is output,
#   RECOVER $pc and $sp YOURSELF with using PC and SP
#   which this command outputs at first !!!
#    
# [REMARK]
#   You can know pid of PiE task by checking The last member "pid" of TCB .
#---------------------------------------------------------------------------
define btany
  printf "PC: 0x%08x\n", $pc
  printf "SP: 0x%08x\n", $sp
  set $pid = $arg0
  if $pid <= 0
    echo Illegal pid.\n
  else
    #-- depend on Linux code (linux/include/linux/sched.h)
    set $PIDHASH_SZ = (4096 >> 2)
    set $hashno = (((($pid) >> 8) ^ ($pid)) & ($PIDHASH_SZ - 1))
    set $ts = (pidhash[$hashno])
    if $ts == 0
      echo This process does not exist.\n
    else
      set $ts_tgt = 0
      while $ts != 0
        if ($ts)->pid == $pid
          set $ts_tgt = $ts
        end
        set $ts = ($ts)->pidhash_next
      end
      if $ts_tgt == 0
        echo This process does not exist.\n
      else
        set $regs = (struct pt_regs *)(($ts_tgt)->thread.sp0)
        set $pc_org_btany = $pc
        set $sp_org_btany = $sp
        set $pc = ($regs)->pc
        set $sp = ($regs)->sp
        backtrace
        set $pc = $pc_org_btany
        set $sp = $sp_org_btany
      end
    end
  end
end

document btany
Print backtrace of all stack frames for any process.
| <usage>
|   btany pid
|
|    pid : process ID
|
| <ex>
|   (gdb) btany 15
|
| <caution>
|   - Necessary Symbols: Linux
|   - If the message "Cannot access memory at address 0x????." or so on
|     is output,
|     RECOVER $pc and $sp YOURSELF with using 'btany_recover' command.
|    
| <remark>
|   - The last member of TCB is pid of PiE task.
|     You can get a pid for a PiE task with 'tsk' or 'tsklist' command.
end

define btany_recover
  set $pc = $pc_org_btany
  set $sp = $sp_org_btany
end

document btany_recover
Recover pc and sp when btany comman outputs error messages.
| <usage>
|   btany_recover
|
| <ex>
|   (gdb) btany_recover
|
| <caution>
|   - When 'btany' command outputs error messages,
|     RECOVER $pc and $sp YOURSELF with using 'btany_recover' command.
end

#---------------------------------------------------------------------------
# Print stack info
#---------------------------------------------------------------------------
define datainfo
  set $s = $arg0
  set $max = ((((int)$arg1) * 4) / 4)
  set $o = 0
  printf "address    offset  data\n"
  while ($o < $max)
    printf "0x%08x [%4d]: ", $s, $o
    output/a *($s)
    printf "\n"
    set $o += 4
    set $s += 4
  end
end

document datainfo
Print data symbol information.
| <usage>
|   datainfo address num
|
|    address : top of address to check
|    num     : the number of data to check [bytes]
|
| <ex>
|   (gdb) datainfo 0x9017ffac 24
|   address    offset  data
|   0x9017ffac [   0]: 0x900154f8 <do_softirq+80>
|   0x9017ffb0 [   4]: 0x8835fdc
|   0x9017ffb4 [   8]: 0x400209f2
|   0x9017ffb8 [  12]: 0xf01
|   0x9017ffbc [  16]: 0x10f00
|   0x9017ffc0 [  20]: 0x9010ed50 <irq_stat>
end

define stkinfo
  set $num = $arg0
  datainfo $sp $num
end

document stkinfo
Print stack symbol information.
| <usage>
|   stkinfo num
|
|    num : the number of stack data to check [bytes]
|
| <ex>
|   (gdb) stkinfo 24
|   address    offset  data
|   0x9017ffac [   0]: 0x900154f8 <do_softirq+80>
|   0x9017ffb0 [   4]: 0x8835fdc
|   0x9017ffb4 [   8]: 0x400209f2
|   0x9017ffb8 [  12]: 0xf01
|   0x9017ffbc [  16]: 0x10f00
|   0x9017ffc0 [  20]: 0x9010ed50 <irq_stat>
end

#---------------------------------------------------------------------------
# Print list of resource limits and usage
#---------------------------------------------------------------------------
define print_rlim
  set $rlim = $arg0
  set $t = $arg1
  set $i = 0
  #CPU
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "   *"
  else
    printf " %3d", $x
  end
  set $i++
  #FSIZE
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "     *"
  else
    printf " %5d", $x
  end
  set $i++
  #DATA
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "    *"
  else
    printf " %4d", $x
  end
  set $i++
  #STACK
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "          *"
  else
    printf " %10d", $x
  end
  set $i++
  #CORE
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "    *"
  else
    printf " %4d", $x
  end
  set $i++
  #RSS
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "   *"
  else
    printf " %3d", $x
  end
  set $i++
  #NPROC
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "     *"
  else
    printf " %5d", $x
  end
  set $i++
  #NFILE
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "     *"
  else
    printf " %5d", $x
  end
  set $i++
  #MEMLCK
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "      *"
  else
    printf " %6d", $x
  end
  set $i++
  #AS
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "  *"
  else
    printf " %2d", $x
  end
  set $i++
  #LCKS
  if ($t == 0)
    set $x = $rlim[$i].rlim_cur
  else
    set $x = $rlim[$i].rlim_max
  end
  if ($x == -1)
    printf "    *"
  else
    printf " %4d", $x
  end
  set $i++
end

document print_rlim
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print list of resource limits and usage for all processes
#---------------------------------------------------------------------------
define rlimlist
  #-- depend on Linux code (linux/include/linux/sched.h)
  set $PIDHASH_SZ = (4096 >> 2)
  #-- depend on Linux code (linux/include/linux/asm-mn103e01/resource.h)
  set $RLIM_NLIMITS = 11
  set $hashno = 0
  set $idx = 1
  printf " pid :      CPU FSIZE DATA      STACK CORE RSS NPROC NFILE MEMLCK AS LCKS\n"
  while $hashno < $PIDHASH_SZ
    set $ts = (pidhash[$hashno])
    while $ts != 0
      printf "[%3d]:", ($ts)->pid
      if ((int)($ts) & 0x80000000) != 0x80000000
        printf " CRASHED!"
      else
        printf " cur:"
        print_rlim (($ts)->rlim) 0
#        set $i = 0
#        while ($i < $RLIM_NLIMITS)
#          printf " %4d", ($ts)->rlim[$i].rlim_cur
#          set $i++
#        end
        printf "\n"
        printf "      "
        printf " max:"
        print_rlim (($ts)->rlim) 1
#        set $i = 0
#        while ($i < $RLIM_NLIMITS)
#          printf " %4d", ($ts)->rlim[$i].rlim_max
#          set $i++
#        end
#        printf "\n"
      end
      echo \n
      set $idx++
      set $ts = ($ts)->pidhash_next
    end
    set $hashno++
  end
end

document rlimlist
Print list of resource limits and usage for all processes.
| <usage>
|   rlimlist
|
| <ex>
|   (gdb) rlimlist
|    pid :      CPU FSIZE DATA      STACK CORE RSS NPROC NFILE MEMLCK AS LCKS
|   [  1]: cur:   *     *    *    8388608    0   *  1184  1024      *  *    *
|          max:   *     *    *          *    *   *  1184  1024      *  *    *
|   [  2]: cur:   *     *    *    8388608    0   *  1184  1024      *  *    *
|          max:   *     *    *          *    *   *  1184  1024      *  *    *
|
| <caution>
|   - Necessary Symbols: Linux
end


############################################################################
# << General Purpose Function >>
#

#---------------------------------------------------------------------------
# Print indexes of RCBs linked to management queue
#---------------------------------------------------------------------------
define mngque
#  echo $arg0\t:
  qinglist $arg0
  echo \n
end

document mngque
Print task management queue.
| <usage>
|   mngque addr
|
|    addr : address of task management queue
|
| <ex>
|   (gdb) mngque &knl_ReadyQue
|
| <caution>
|   - Necessary Symbols: PiE
end


############################################################################
# << Task >>
#

#---------------------------------------------------------------------------
# Convert from taskstat on TCB to task status 
#
# [EXAMPLE]
#   tskstat 0x00000000
#---------------------------------------------------------------------------
define tskstat
  if $arg0 == 0x00000000
    printf "DORMANT      "
  end
  if $arg0 == 0x00000001
    printf "READY        "
  end
  if $arg0 == 0x00000004
    printf "SUSPEND      "
  end
  if ($arg0 & 0x00000002) != 0
    printf "WAIT("
    if ($arg0 & 0x00000010) != 0
      printf "MTX)    "
    end
    if ($arg0 & 0x00000020) != 0
      printf "SEM)    "
    end
    if ($arg0 & 0x00000040) != 0
      printf "FLG_AND"
      if ($arg0 & 0x00000100) != 0
        printf "|CLR)"
      else
        printf ")"
      end
    end
    if ($arg0 & 0x00000080) != 0
      printf "FLG_OR"
      if ($arg0 & 0x00000100) != 0
        printf "|CLR)"
      else
        printf ") "
      end
    end
    if ($arg0 & 0x00000200) != 0
      printf "OBJ)    "
    end
    if ($arg0 & 0x00000400) != 0
      printf "CND)    "
    end
    if ($arg0 & 0x00000800) != 0
      printf "SLP)    "
    end
    if ($arg0 & 0x00001000) != 0
      printf "TSLP)   "
    end
    if ($arg0 & 0x00002000) != 0
      printf "EXT)    "
    end
    if ($arg0 & 0x00100000) != 0
      printf "QUE)    "
    end
    if ($arg0 & 0x00200000) != 0
      printf "RDV_SND)"
    end
    if ($arg0 & 0x00400000) != 0
      printf "RDV_RCV)"
    end
    if ($arg0 & 0x00800000) != 0
      printf "RDV_SNR)"
    end
    if ($arg0 & 0x01000000) != 0
      printf "RDV_RPL)"
    end
    if ($arg0 & 0x02000000) != 0
      printf "RDV_FWD)"
    end
    if ($arg0 & 0x04000000) != 0
      printf "SEL)    "
    end
    if ($arg0 & 0x00000004) != 0
      printf "|SUSPEND"
    end
  end
end

document tskstat
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print TCB (task) for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "tsk"
#---------------------------------------------------------------------------
define tsks
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 knl_TCBArray -1 task
  else
    print_cb $arg0 knl_TCBArray MAXTASK task
  end
end

document tsks
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print TCB (task)
#
# [SYNOPSIS]
#   tsk <ID or index of task>
#
# [EXAMPLE]
#   tsk 0x01000002   --- In the case of checking with task ID
#   tsk 2            --- In the case of checking with task index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define tsk
  if (*(int *)&knl_VINFO_KERNEL == 0x03000000)
    print_cb $arg0 &(knl_cbmh.tsk) -2 task
    tsk_by_tskid $arg0
  else
    tsks $arg0
  end
end

document tsk
Print TCB for tsk_id.
| <usage>
|   tsk tsk_id
|
|     tsk_id : task ID or task index
|
| <ex>
|   (gdb) tsk 0x01000002    --- case of task ID
|   (gdb) tsk 2             --- case of task index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all tasks
#
# [SYNOPSIS]
#   tsklist
#---------------------------------------------------------------------------
define tsklist
  set $cbmh = &(knl_cbmh.tsk)

  set $max = ((CBMH *)$cbmh)->max
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = ((CBMH *)$cbmh)->cell
  set $idx = 1
  printf " idx : id       pid pri stat          entry\n"
  while $idx <= $max + 1
    set $cb = ((CBMC *)$cbmc)[$idx].cbp
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " %08x", ((RCB *)$cb)->id
        #--
        if ((TCB*)$cb)->taskstat == 0
          printf "   -"
          printf " %3d", ((TCB *)$cb)->inittaskpri
        else
          printf " %3d", ((TCB *)$cb)->pid
          printf " %3d", ((TCB *)$cb)->rcb.pri
        end
        printf " "
        tskstat ((TCB*)$cb)->taskstat
        printf " "
        output/a ((TCB *)$cb)->taskentry
        #--
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document tsklist
Print list of task information.
| <usage>
|   tsklist
|
| <ex>
|   (gdb) tsklist
|    idx : id       pid pri stat          entry
|   [  1]: 01000001  14  20 READY         0x8001191 <server_task>
|   [  2]: 01000002  15  40 WAIT(QUE)     0x8001558 <client_task>
|   ...
|
| <output format>
|   idx  : index for TCB
|   id   : task ID
|   pid  : process ID
|   stat : status of task
|   entry: address of task entry <function name of task entry>
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print task information with address
#---------------------------------------------------------------------------
define tskinfo
  set $tcb = (TCB *)$arg0
  printf "<<Task>>\n"
  printf "entry      : "
  output/a $tcb->taskentry
  printf "\n"
  printf "TCB        : 0x%08x\n", $tcb
  printf "id         : 0x%08x\n", ($tcb)->rcb.id
  printf "state      : "
  tskstat ($tcb)->taskstat
  printf "\n"
  printf "pri        : %d\n", ($tcb)->rcb.pri
#  printf "link head  : "
#  output/a $tcb->rcb.link
  printf "stack top  : "
  output/a ($tcb)->inittaskstack
  printf "\n"
  printf "stack size : %d\n", ($tcb)->stacksize
  if ($cb->taskstat == 0x00000000)
    printf "pid        : ---\n"
  else
    printf "pid        : %d\n", ($tcb)->pid
  end
end

document tskinfo
Print task information by assigned TCB address.
| <usage>
|   tskinfo address
|
|     address : address of TCB
|
| <ex>
|   (gdb) tskinfo 0x08040000
|
| <output format>
|   Refer to "tsk_by_tskid"
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print TCB by assigning task ID.
#---------------------------------------------------------------------------
define tsk_by_tskid
  set $id = $arg0
  set $idx = $id & 0x0000ffff
  set $type = ($id & 0xff000000)
  if $id != $idx && $type != 0x01000000
    echo This ID is not task's\n
  else
    set $cb = (knl_cbmh.tsk.cell)[$idx].cbp
    if ($cb == 0)
      printf "task %08x is NONEXISTENT.\n", $arg0
    else
      if ($id != $idx && $cb->rcb.id != $id)
        echo Nonexistent.\n
      else
#        if ($cb->taskstat == 0x00000000)
#          printf "task %08x is DORMANT.\n", $arg0
#        else
           tskinfo $cb
#        end
      end
    end
  end
end

document tsk_by_tskid
Print TCB by assigning task ID.
| <usage>
|   tsk_by_tskid tskid
|
|     tskid : ID or index of task
|
| <ex>
|   (gdb) tsk_by_tskid 2
|   <<Task>>
|   entry      : 0x8012132 <VDR_task>
|   TCB        : 0x08ac0e6c
|   id         : 01000002
|   state      : WAIT(QUE)
|   pri        : 4
|   stack top  : 0x884d8dc <CFG_STACK_002>
|   stack size : 2048
|   pid        : 88
|
| <output format>
|   entry     : address of task entry <function name of task entry>
|   TCB       : address of TCB
|   id        : task ID
|   state     : status of task
|   pri       : task priority
|   stack top : address of top of stack <stack symbol name>
|   stack size: size of stack
|   pid       : process ID
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print TCB by assigning process ID.
#---------------------------------------------------------------------------
define tsk_by_pid
  set $pid = $arg0
  set $cbmh = &(knl_cbmh.tsk)

  set $max = ((CBMH *)$cbmh)->max
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = ((CBMH *)$cbmh)->cell
  set $idx = 1
  set $end = 0
  while ($idx <= $max + 1 && $end == 0)
    set $cb = (TCB *)(((CBMC *)$cbmc)[$idx].cbp)
    if $cb != 0
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        if (($cb)->taskstat == 0)
          # continue
        else
          if (($cb)->pid == $pid)
            proc_by_pid $pid
            tskinfo $cb
            set $end = 1
          end
        end
      end
    end
    set $idx = $idx + 1
  end
  if ($end == 0)
    echo "Nonexistent.\n"
  end
end

document tsk_by_pid
Print TCB by assigning process ID.
| <usage>
|   tsk_by_pid pid
|
|     pid : process ID
|
| <ex>
|   (gdb) tsk_by_pid 88
|   <<Process/Thread>>
|   command    : estb_v0
|   task_struct: 0x90e5a000
|   pid        : 88
|   state      : BLOCK(INT)
|   policy     : FIFO
|   nice       : 0
|   pri        : 87
|   keep pc    : 0x8008c0f <KNL_core_scheduler_real+168>
|   PiE task   : ID=0x01000002 idx=2 entry=0x8012132 <VDR_task>
|   <<Task>>
|   entry      : 0x8012132 <VDR_task>
|   TCB        : 0x08ac0e6c
|   id         : 0x01000002
|   state      : WAIT(QUE)
|   pri        : 4
|   stack top  : 0x884d8dc <CFG_STACK_002>
|   stack size : 2048
|   pid        : 88
|
| <output format>
|   Refer to "proc_by_pid" and "tsk_by_tskid"
|
| <caution>
|   - Necessary Symbols: Linux and PiE
end

#---------------------------------------------------------------------------
# Print indexes of tasks linked to task management queue
#---------------------------------------------------------------------------
define tskquelist
  printf "[READY]   "
  qinglist_t &knl_ReadyQue 0x01
  printf "\n"
  if *(int *)&knl_VINFO_KERNEL != 0x01500000
    printf "[DORMANT] "
    qinglist_t &knl_DormantQue 0x01
    printf "\n"
    printf "[SUSPEND] "
    qinglist_t &knl_SuspendQue 0x01
    printf "\n"
    printf "[slp_tsk] "
    qinglist_t &knl_SleepQue 0x01
    printf "\n"
  end
  printf "[wai_tsk] "
  qinglist_t &knl_WaitQue 0x01
  printf "\n"
  printf "[sel_que] "
  qinglist_t &knl_MaskWaitQueue 0x01
  printf "\n"
  if *(int *)&knl_VINFO_KERNEL != 0x01500000
    printf "[rcv_rdv] "
    qinglist_t &knl_RcvRdvQue 0x01
    printf "\n"
    printf "[snr_rdv] "
    qinglist_t &knl_SnrRdvQue 0x01
    printf "\n"
  end
end

document tskquelist
Print list of task management queues.
| <usage>
|   tskquelist
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of the top of stack data for all tasks
#
# [EXAMPLE]
#   stklist
#---------------------------------------------------------------------------
define stklist
  set $cbmh = &(knl_cbmh.tsk)

  set $max = ((CBMH *)$cbmh)->max
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = ((CBMH *)$cbmh)->cell
  set $idx = 1
  while $idx <= $max + 1
    set $cb = ((CBMC *)$cbmc)[$idx].cbp
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " entry="
        output/a ((TCB *)$cb)->taskentry
        printf " inittaskstack="
        output/a ((TCB *)$cb)->inittaskstack
        echo \n
        set $i = 0
        while $i < 128
          x/2x (((TCB *)$cb)->inittaskstack + $i)
          set $i += 8
        end
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document stklist
Print list of the top of stack data for all tasks.
|  
| <usage>
|   stklist
|
| <ex>
|   (gdb) stklist
|   [  1]: entry=0x800060e <task1> inittaskstack=0x8048350 <CFG_STACK_001>
|   0x8048350 <CFG_STACK_001>:      0x00000000      0x00000000
|   0x8048358 <CFG_STACK_001+8>:    0x00000000      0x00000000
|   ...
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print task stack consumption rate
#
# [EXAMPLE]
#   tsk 0x01000002   --- In the case of checking with task ID
#   tsk 2            --- In the case of checking with task index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define stkuse
  set $static = 0
  if $static == 0
    set $cbmh = &(knl_cbmh.tsk)
    if $cbmh == &(knl_cbmh.tsk)
      set $max = ($cbmh)->max + 1
    else
      set $max = ($cbmh)->max
    end
    set $cbmc = ($cbmh)->cell
  else
    set $cbarray = knl_TCBArray
    set $max = MAXTASK
  end
  set $id = $arg0
  set $idx = $id & 0x0000ffff
  set $type = ($id & 0xff000000)
  if $id != $idx && $type != 0x01000000
    echo This ID is not task's\n
  else
    if $id != $idx
      printf "<<CB[id=%08x]>>\n", $id
    else
      printf "<<CB[idx=%d]>>\n", $idx
    end
    if $idx > $max && 0 <= $max
      printf "Nonexistent.\n"
      printf "Index (%d) ", $idx
      printf "must be less than the number of tasks (%d + 1) .\n", $max
    else
      if $static == 0
        set $cb = ($cbmc)[$idx].cbp
      else
        set $cb = &(($cbarray)[$idx])
      end
      if $cb == 0
        echo Nonexistent.\n
        echo This task has never created.\n
      else
        #-- check addr
        if ((int)($cb) & 0x38000000) == 0x00000000
          printf "Pointer of CB has been crashed.\n"
        else
          if $id != $idx && $id != ($cb)->rcb.id
            echo Nonexistent.\n
            echo This dynamical creative task has already deleted.\n
          else
            printf " btm usedpeak/ stksize p.c.   entry\n"
            printf " "
            print_stkuse $cb
            echo \n
          end
        end
      end
    end
  end
end

document stkuse
Print task stack consumption rate for tsk_id.
|  
| <usage>
|   stkuse tsk_id
|
|     tsk_id : task ID or task index
|
| <ex>
|   (gdb) stkuse 2
|   <<CB[idx=2]>>
|    btm usedpeak/ stksize p.c.   entry
|      o     1928/    2048  94% * 0x804cc33 <task2>
|
| <output format>
|   idx      : index for TCB
|   id       : ID of task
|   btm      : whether bottom data is crashed or not (o:ok, x:crashed)
|   usedpeak : peak size of stack used
|   stksize  : size of stack
|   p.c.     : percentage of "usedpeak / stksize"
|              ('*' says warning of near stack overflow)
|   entry    : address of task entry <function name of task entry>
|
| <caution>
|   - It will take long time before processing is completed!!!
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of task stack consumption rate
#
# [SYNOPSIS]
#   stkuselist
#---------------------------------------------------------------------------
define stkuselist
  set $cbmh = &(knl_cbmh.tsk)

  set $max = ((CBMH *)$cbmh)->max
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = ((CBMH *)$cbmh)->cell
  set $idx = 1
  printf " idx : id      "
  printf " btm  used_peak/stack_size p.c.   entry\n"
#  while $idx <= $max + 1
  while $idx <= $max
    set $cb = ((CBMC *)$cbmc)[$idx].cbp
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " %08x", ((RCB *)$cb)->id
        printf " "
        print_stkuse $cb
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document stkuselist
Print list of task stack consumption rate.
|  
| <usage>
|   stkuselist
|
| <ex>
|   (gdb) stkuselist
|    idx : id       btm usedpeak/ stksize p.c.   entry
|   [  1]: 01000001   o      916/    8192  11%   0x802a91c <task1>
|   [  2]: 01000002   o     1928/    2048  94% * 0x804cc33 <task2>
|   ...
|
| <output format>
|   idx      : index for TCB
|   id       : ID of task
|   btm      : whether bottom data is crashed or not (o:ok, x:crashed)
|   usedpeak : peak size of stack used
|   stksize  : size of stack
|   p.c.     : percentage of "usedpeak / stksize"
|              ('*' says warning of near stack overflow)
|   entry    : address of task entry <function name of task entry>
|
| <caution>
|   - It will take long time before processing is completed!!!
|   - Necessary Symbols: PiE
end

############################################################################
# << Semaphore >>
#

#---------------------------------------------------------------------------
# Print SEMCB (semaphore) for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "sem"
#---------------------------------------------------------------------------
define sems
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 &(knl_SEMCBArray) -1 semaphore
  else
    print_cb $arg0 &(knl_SEMCBArray) MAXSEM semaphore
  end
end

document sems
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print SEMCB (semaphore)
#
# [SYNOPSIS]
#   sem <ID or index of semaphore>
#
# [EXAMPLE]
#   sem 0x01000002   --- In the case of checking with semaphore ID
#   sem 2            --- In the case of checking with semaphore index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define sem
  if *(int *)&knl_VINFO_KERNEL == 0x03000000
    print_cb $arg0 &(knl_cbmh.sem) -2 semaphore
  else
    sems $arg0
  end
end

document sem
Print SEMCB for sem_id.
| <usage>
|   sem sem_id
|
|     sem_id : semaphore ID or semaphore index
|
| <ex>
|   (gdb) sem 0x01000002    --- case of semaphore ID
|   (gdb) sem 2             --- case of semaphore index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all samaphores
#---------------------------------------------------------------------------
define semlist
  #--Special setting for each resource
  set $cbmh = (&(knl_cbmh.sem))
  #--
  set $max = (((CBMH *)$cbmh)->max)
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = (((CBMH *)$cbmh)->cell)
  set $idx = 1
  printf " idx : id       attr cnt gottsk waittsk\n"
  while $idx <= $max
    set $cb = (((CBMC *)$cbmc)[$idx].cbp)
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " %08x", ((RCB *)$cb)->id
        #--Special setting for each resource
        set $attr = ((SEMCB *)$cb)->semattr 
        if ($attr & 0x02) != 0
          printf " PRIO"
        else
          printf " FIFO"
        end
        printf " %3d", ((SEMCB *)$cb)->count
        if ((RCB *)$cb)->pri != 0
          printf " %6d", ((RCB *)$cb)->pri
        else
          printf "     no"
        end
        #--Print waiting-queue
        printf " "
        qinglist $cb
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document semlist
Print list of semaphore information.
| <usage>
|   semlist
|
| <ex>
|   (gdb) semlist
|    idx : id       attr cnt gottsk waittsk
|   [  1]: 02000001 FIFO   5     no no
|   ...
|
| <output format>
|   idx    : index for SEMCB
|   id     : ID of semaphore
|   attr   : attribute of semaphroe (FIFO/PRIO)
|   cnt    : semaphore count
|   gottsk : TCB index of task which got this semaphore the latest
|   waittsk: TCB indexes of tasks which are waiting this resource
end

############################################################################
# << Mutex >>
#

#---------------------------------------------------------------------------
# Print MTXCB (mutex) for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "mtx"
#---------------------------------------------------------------------------
define mtxs
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 knl_MTXCBArray -1 mutex
  else
    print_cb $arg0 knl_MTXCBArray MAXMTX mutex
  end
end

document mtxs
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print MTXCB (mutex)
#
# [SYNOPSIS]
#   mtx <ID or index of mutex>
#
# [EXAMPLE]
#   mtx 0x01000002   --- In the case of checking with mutex ID
#   mtx 2            --- In the case of checking with mutex index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define mtx
  if *(int *)&knl_VINFO_KERNEL == 0x03000000
    print_cb $arg0 &(knl_cbmh.mtx) -2 mutex
  else
    mtxs $arg0
  end
end

document mtx
Print MTXCB for mtx_id.
| <usage>
|   mtx mtx_id
|
|     mtx_id : mutex ID or mutex index
|
| <ex>
|   (gdb) mtx 0x01000002    --- case of mutex ID
|   (gdb) mtx 2             --- case of mutex index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all mutexes
#
# [SYNOPSIS]
#   mtxlist
#---------------------------------------------------------------------------
define mtxlist
  #--Special setting for each resource
  set $cbmh = (&(knl_cbmh.mtx))
  #--
  set $max = (((CBMH *)$cbmh)->max)
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = (((CBMH *)$cbmh)->cell)
  set $idx = 1
  printf " idx : id       attr lvl  savelvl gottsk waittsk\n"
  while $idx <= $max
    set $cb = (((CBMC *)$cbmc)[$idx].cbp)
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " %08x", ((RCB *)$cb)->id
        #--Special setting for each resource
        set $attr = ((MTXCB *)$cb)->mtxattr 
        if ($attr & 0x01) != 0
          printf " SPIN"
          printf " %3d", (((MTXCB *)$cb)->level >> 8)
          if (((MTXCB *)$cb)->savelevel != 0)
            printf " %08x", ((MTXCB *)$cb)->savelevel
            if (((MTXCB *)$cb)->rcb.pri == 0)
              printf "      -"
            else
              if (((MTXCB *)$cb)->rcb.pri != 0xffff)
                printf " %6d", ((MTXCB *)$cb)->rcb.pri
              else
                printf "   INTR"
              end
            end
          else
            printf "        -"
            printf "     no"
          end
          printf " -"
        else
          if ($attr & 0x04) != 0
            printf " INHR"
          else
            if ($attr & 0x02) != 0
              printf " PRIO"
            else
              printf " FIFO"
            end
          end
          printf "   -"
          printf "        -"
          if ((CSRCB *)$cb)->link != 0
            printf " %6d", \
                   (((TCB *)((CSRCB *)$cb)->link)->rcb.id & 0x0000ffff)
          else
            printf "     no"
          end
          #--Print waiting-queue
          printf " "
          qinglist $cb
        end
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document mtxlist
Print list of mutex information.
| <usage>
|   mtxlist
|
| <ex>
|   (gdb) mtxlist
|    idx : id       attr lvl savelvl  gottsk waittsk
|   [  1]: 03000001 SPIN   6 00000000      - -
|   [  2]: 03000002 INHR   - -             2 4 3
|   ...
|
| <output format>
|   idx    : index for MTXCB
|   id     : ID of mutex
|   attr   : attribute of mutex (SPIN/FIFO/PRIO/INHR)
|   lvl    : interrupt mask level for spin mutex
|   savelvl: saved interrupt mask level for spin mutex
|   gottsk : TCB index of task which got this mutex
|   waittsk: TCB indexes of tasks which are waiting this resource
end

############################################################################
# << Condition Variable >>
#

#---------------------------------------------------------------------------
# Print CNDCB (condition variable)
# for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "cnd"
#---------------------------------------------------------------------------
define cnds
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 knl_CNDCBArray -1 condition_variable
  else
    print_cb $arg0 knl_CNDCBArray MAXCND condition_variable
  end
end

document cnds
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print CNDCB (condition variable)
#
# [SYNOPSIS]
#   cnd <ID or index of condition variable>
#
# [EXAMPLE]
#   cnd 0x01000002   --- In the case of checking with condition variable ID
#   cnd 2            --- In the case of checking
#                        with condition variable index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define cnd
  if *(int *)&knl_VINFO_KERNEL == 0x03000000
    print_cb $arg0 &(knl_cbmh.cnd) -2 condition_variable
  else
    tsks $arg0
  end
end

document cnd
Print CNDCB for cnd_id.
| <usage>
|   cnd cnd_id
|
|     cnd_id : condition variable ID or condition variable index
|
| <ex>
|   (gdb) cnd 0x01000002    --- case of condition variable ID
|   (gdb) cnd 2             --- case of condition variable index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all condition variables
#
# [SYNOPSIS]
#   cndlist
#---------------------------------------------------------------------------
define cndlist
  #--Special setting for each resource
  set $cbmh = (&(knl_cbmh.cnd))
  #--
  set $max = (((CBMH *)$cbmh)->max)
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = (((CBMH *)$cbmh)->cell)
  set $idx = 1
  printf " idx : id       tgtmtx waittsk\n"
  while $idx <= $max
    set $cb = (((CBMC *)$cbmc)[$idx].cbp)
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " %08x", ((RCB *)$cb)->id
        #--Special setting for each resource
        if ((RCB *)$cb)->pri != 0
          printf " %6d", ((RCB *)$cb)->pri
        else
          printf "     no"
        end
        #--Print waiting-queue
        printf " "
        qinglist $cb
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document cndlist
Print list of condition variable information.
| <usage>
|   cndlist
|
| <ex>
|   (gdb) cndlist
|    idx : id       tgtmtx waittsk
|   [  1]: 04000001     no no
|   ...
|
| <output format>
|   idx    : index for CNDCB
|   id     : ID of condition variable
|   tgtmtx : index of MTXCB which was got by tasks
|            when they wait for contition the latest
|   waittsk: TCB indexes of tasks which are waiting this resource
end

############################################################################
# << Object Lock >>
#

#---------------------------------------------------------------------------
# Print OBJCB (object lock) for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "obj"
#---------------------------------------------------------------------------
define objs
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 knl_OBJCBArray -1 object_lock
  else
    print_cb $arg0 knl_OBJCBArray MAXOBJ object_lock
  end
end

document objs
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print OBJCB (object lock)
#
# [SYNOPSIS]
#   obj <ID or index of object lock>
#
# [EXAMPLE]
#   obj 0x01000002   --- In the case of checking with object lock ID
#   obj 2            --- In the case of checking with object lock index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define obj
  if *(int *)&knl_VINFO_KERNEL == 0x03000000
    print_cb $arg0 &(knl_cbmh.obj) -2 object_lock
  else
    objs $arg0
  end
end

document obj
Print OBJCB for obj_id.
| <usage>
|   obj obj_id
|
|     obj_id : object lock ID or object lock index
|
| <ex>
|   (gdb) obj 0x01000002    --- case of object lock ID
|   (gdb) obj 2             --- case of object lock index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all object lockes
#
# [SYNOPSIS]
#   objlist
#---------------------------------------------------------------------------
define objlist
  #--Special setting for each resource
  set $cbmh = (&(knl_cbmh.obj))
  #--
  set $max = (((CBMH *)$cbmh)->max)
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = (((CBMH *)$cbmh)->cell)
  set $idx = 1
  printf " idx : id       free/max slot...  waittsk\n"
  while $idx <= $max
    set $cb = (((CBMC *)$cbmc)[$idx].cbp)
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " %08x", ((RCB *)$cb)->id
        #--Special setting for each resource
        printf " %4d/%3d", \
               ((OBJCB *)$cb)->slot_rest, ((OBJCB *)$cb)->slot_max
        printf " "
        set $i = 0
        while $i < ((OBJCB *)$cb)->slot_max
          if (((OBJCB *)$cb)->slotaddr[$i]).used_task == 0
            printf "(no)"
          else
            printf "(%d,%08x)", \
                   ((((OBJCB *)$cb)->slotaddr[$i]).used_task & 0x0000ffff), \
                   (((OBJCB *)$cb)->slotaddr[$i]).obj_type
          end
          set $i++
        end
        #--Print waiting-queue
        printf " "
        qinglist $cb
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document objlist
Print list of object lock information.
| <usage>
|   objlist
|
| <ex>
|   (gdb) objlist
|    idx : id       free/max slot...  waittsk
|   [  1]: 05000001    3/  3 (no)(no)(no) no
|   ...
|
| <output format>
|   idx    : index for OBJCB
|   id     : ID of object lock
|   rest   : number of free slots
|   max    : number of all slots
|   waittsk: TCB indexes of tasks which are waiting this resource
end

############################################################################
# << Event Flag >>
#

#---------------------------------------------------------------------------
# Print FLGCB (event flag) for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "flg"
#---------------------------------------------------------------------------
define flgs
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 knl_FLGCBArray -1 event_flag
  else
    print_cb $arg0 knl_FLGCBArray MAXTASK event_flag
  end
end

document flgs
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print FLGCB (event flag)
#
# [SYNOPSIS]
#   flg <ID or index of event flag>
#
# [EXAMPLE]
#   flg 0x01000002   --- In the case of checking with event flag ID
#   flg 2            --- In the case of checking with event flag index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define flg
  if *(int *)&knl_VINFO_KERNEL == 0x03000000
    print_cb $arg0 &(knl_cbmh.flg) -2 event_flag
  else
    flgs $arg0
  end
end

document flg
Print FLGCB for flg_id.
| <usage>
|   flg flg_id
|
|     flg_id : event flag ID or event flag index
|
| <ex>
|   (gdb) flg 0x01000002    --- case of event flag ID
|   (gdb) flg 2             --- case of event flag index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all event flags
#
# [SYNOPSIS]
#   flglist
#---------------------------------------------------------------------------
define flglist
  #--Special setting for each resource
  set $cbmh = (&(knl_cbmh.flg))
  #--
  set $max = (((CBMH *)$cbmh)->max)
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = (((CBMH *)$cbmh)->cell)
  set $idx = 1
  printf " idx : id       ptn      waittsk\n"
  while $idx <= $max
    set $cb = (((CBMC *)$cbmc)[$idx].cbp)
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " %08x", ((RCB *)$cb)->id
        #--Special setting for each resource
        printf " %08x", ((FLGCB *)$cb)->flgptn
        #--Print waiting-queue
        printf " "
        qinglist $cb
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document flglist
Print list of event flag information.
| <usage>
|   flglist
|
| <ex>
|   (gdb) flglist
|    idx : id       ptn      waittsk
|   [  1]: 06000001 00000000 no
|   ...
|
| <output format>
|   idx    : index for FLGCB
|   id     : ID of event flag
|   rest   : flag pattern which has been set
|   waittsk: TCB indexes of tasks which are waiting this resource
end

############################################################################
# << Queue >>
#

#---------------------------------------------------------------------------
# Print QUECB (queue) for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "que"
#---------------------------------------------------------------------------
define ques
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 (QINFO*)(knl_qinfo_tbl-1) -1 queue
  else
    if *(int *)&knl_VINFO_KERNEL == 0x02000000
      print_cb $arg0 (QINFO*)(knl_qinfo_tbl-1) MAXQUE queue
    else
      print_cb $arg0 knl_QUECBArray MAXQUE queue
    end
  end
end

document ques
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print QUECB (queue)
#
# [SYNOPSIS]
#   que <ID or index of queue>
#
# [EXAMPLE]
#   que 0x01000002   --- In the case of checking with queue ID
#   que 2            --- In the case of checking with queue index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define que
  if *(int *)&knl_VINFO_KERNEL == 0x03000000
    print_cb $arg0 &(knl_cbmh.que) -2 queue
  else
    ques $arg0
  end
end

document que
Print QUECB for que_id.
| <usage>
|   que que_id
|
|     que_id : queue ID or queue index
|
| <ex>
|   (gdb) que 0x01000002    --- case of queue ID
|   (gdb) que 2             --- case of queue index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all queues
#
# [SYNOPSIS]
#   quelist
#---------------------------------------------------------------------------
define quelist
  #--Special setting for each resource
  set $cbmh = (&(knl_cbmh.que))
  printf " idx : id       fre cpy snt lcktsk msgsz peak/max waittsk\n"
  #--
  set $max = (((CBMH *)$cbmh)->max)
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = (((CBMH *)$cbmh)->cell)
  set $idx = 1
  while $idx <= $max
    set $cb = (((CBMC *)$cbmc)[$idx].cbp)
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " %08x", ((RCB *)$cb)->id
        #--Special setting for each resource
        printf " "
        qingnum &(((QUECB*)$cb)->fre_msg)
        printf " "
        qingnum &(((QUECB*)$cb)->cpy_msg)
        printf " "
        qingnum &(((QUECB*)$cb)->snt_msg)
        if ((QUECB *)$cb)->lock_task == 0
          printf "     no"
        else
          printf " %6d", (((QUECB *)$cb)->lock_task & 0x0000ffff)
        end
        printf " %5d", ((QUECB *)$cb)->msg_size
        if ((QUECB*)$cb)->rcb.pri != 0xffff
          printf " %4d", ((((QUECB*)$cb)->rcb.pri & 0xff00) >> 8)
        else
          printf "    -"
        end
        printf "/%3d", ((QUECB*)$cb)->msg_count
        #--Print waiting-queue
        printf " "
        qinglist $cb
        #--
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document quelist
Print list of queue information.
| <usage>
|   quelist
|
| <ex>
|   (gdb) quelist
|    idx : id       fre cpy snt lcktsk msgsz peak/max waittsk
|   [  1]: 07000001  20   0   0      0   112    4/ 20 2
|   ...
|
| <output format>
|   idx    : index for QUECB
|   id     : ID of queue
|   fre    : number of free messages
|   cpy    : number of messages in copying
|            between kernel buffer and user buffer
|   snt    : number of messages which have already sent
|   lcktsk : index of task which locked this queue
|   msgsz  : size of a message
|   peak   : peak number of messages used simultaneously
|   max    : number of all messages
|   waittsk: TCB indexes of tasks which are waiting this resource
end

############################################################################
# << Alarm >>
#

#---------------------------------------------------------------------------
# Print list of all alarm messages
#
# [SYNOPSIS]
#   almlist
#---------------------------------------------------------------------------
define almlist
  set $cbmh = (&(knl_cbmh.que))
  set $max = (((CBMH *)$cbmh)->max)
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = (((CBMH *)$cbmh)->cell)
  #--- Unsent Alarm Message
  printf "<<Unsent>>\n"
  printf "    que_id   msg_id   sender almtime message[0-7]\n"
  set $head = &knl_AlarmMsgQue
  set $msgcb = (QUEMSGCB *)(($head)->next)
  if $msgcb != $head
    set $idx = (($msgcb)->que_id & 0x0000ffff)
    set $cb = (QUECB *)(((CBMC *)$cbmc)[$idx].cbp)
    if ($cb)->msg_size < 8
      set $size = ($cb)->msg_size
    else
      set $size = 8
    end
    while $msgcb != $head
      #-- check addr
      if ((int)($msgcb) & 0x38000000) == 0x00000000
        printf "CRASHED!"
        set $msgcb = $head
      else
        printf "    "
        quemsg $msgcb $size
        set $msgcb = (QUEMSGCB *)(((RCB *)$msgcb)->que.next)
      end
      echo \n
    end
  else
    echo No alarm messages\n
  end
  #--- Already Sent Alarm Message
  printf "<<AlreadySent(snt)/Copying(cpy)>>\n"
  printf "    que_id   msg_id   sender almtime message[0-7]\n"
  #--
  set $msgnum = 0
  set $idx = 1
  while $idx <= $max
    set $cb = (QUECB *)(((CBMC *)$cbmc)[$idx].cbp)
    if $cb != 0
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " Queue %d is CRASHED!", $idx
      else
        if ($cb)->msg_size < 8
          set $size = ($cb)->msg_size
        else
          set $size = 8
        end
        #-- snt_msg
        set $head = &(((QUECB *)$cb)->snt_msg)
        set $msgcb = (QUEMSGCB *)(($head)->next)
        while $msgcb != $head
          if ($msgcb)->que_id != 0xffffffff
            printf "snt "
            quemsg $msgcb $size
            echo \n
            set $msgnum++
          end
          set $msgcb = (QUEMSGCB *)(((RCB *)$msgcb)->que.next)
        end
        #-- cpy_msg
        set $head = &(((QUECB *)$cb)->cpy_msg)
        set $msgcb = (QUEMSGCB *)(($head)->next)
        while $msgcb != $head
          if ($msgcb)->que_id != 0xffffffff
            printf "cpy "
            quemsg $msgcb $size
            echo \n
          end
          set $msgcb = (QUEMSGCB *)(((RCB *)$msgcb)->que.next)
        end
      end
    end
    set $idx = $idx + 1
  end
  if $msgnum == 0
    echo No alarm messages\n
#  else
#    printf "static_max=%d, max=%d\n", $smax, $max
  end
end

document almlist
Print list of alarm information.
| <usage>
|   almlist
|
| <ex>
|   (gdb) almlist
|   <<Unsent>>
|       que_id   msg_id   sender almtime message[0-7]
|       07000001 00010002      1     471 00 00 00 00 00 00 00 00
|   <<AlreadySent/Copying>>
|       que_id   msg_id   sender almtime message[0-7]
|   snt 07000001 00010001      1       0 00 00 00 00 00 00 00 00
|
| <output format>
|   que_id  : ID of queue to send alarm
|   id      : ID of queue message to use alaram
|   sender  : index of task which set alarm (INTR=from interrupt)
|   almtime : how long time is remained until alarm message will be sent [tick]
|   messages: 8 bytes message data from top of alarm message
|
| <caution>
|   - Necessary Symbols: PiE
end


############################################################################
# << Rendezvous >>
#

#---------------------------------------------------------------------------
# Print RDVCB (rendezvous) for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "rdv"
#---------------------------------------------------------------------------
#define rdvs
#  echo Not supported\n
#end
#
#document rdvs
#(Internal macro by tak)
#end

#---------------------------------------------------------------------------
# Print RDVCB (rendezvous)
#
# [SYNOPSIS]
#   rdv <ID or index of rendezvous or task>
#
# [EXAMPLE]
#   rdv 0x01000002   --- In the case of checking with rendezvous ID
#   rdv 0x08000002   --- In the case of checking with task ID
#   rdv 2            --- In the case of checking with rendezvous index
#   rdv 2            --- In the case of checking with task index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define rdv
  set $cbmh = &(knl_cbmh.tsk)
  set $max = ($cbmh)->max
  set $cbmc = ($cbmh)->cell
  set $id = $arg0
  set $idx = $id & 0x0000ffff
  set $type = ($id & 0xff000000)
  if $id != $idx && $type != 0x01000000 && $type != 0x08000000
    echo This ID is not rendezvous's or task's\n
  else
    if $id != $idx
      if $type == 0x01000000
        printf "<<CB[tskid=%08x]>>\n", $id
      else
        printf "<<CB[rdvid=%08x]>>\n", $id
      end
    else
      printf "<<CB[idx=%d]>>\n", $idx
    end
    if $idx > $max
      printf "Nonexistent.\n"
      printf "Index (%d) ", $idx
      printf "must be less than the number of tasks (%d + 1) .\n", $max
    else
      if $static == 0
        set $cb = ($cbmc)[$idx].cbp
      else
        set $cb = &(($cbarray)[$idx])
      end
      if $cb == 0
        echo Nonexistent.\n
        echo This task has never created.\n
      else
        if $id != $idx && $type == 0x01000000 && $id != ($cb)->rcb.id
          echo Nonexistent.\n
          echo This dynamical creative task has already deleted.\n
        else
          set $rdvcb = ($cb)->rdvcb
          if $rdvcb == 0
            echo Nonexistent.\n
            echo This task does not have rendezvous.\n
          else
            if $id != $idx && $type == 0x08000000 && $id != ($rdvcb)->rcb.id
              echo Nonexistent.\n
              echo This task does not have rendezvous.\n
            else
              printf "addr=0x%08x\n", $rdvcb
              output/x *($rdvcb)
              echo \n
            end
          end
        end
      end
    end
  end
end

document rdv
Print RDVCB for rdv_id or tsk_id.
| <usage>
|   rdv rdv_id
|
|     rdv_id : rendezvous ID or task ID
|              or rendezvous index or task index
|
| <ex>
|   (gdb) rdv 0x01000002    --- case of rendezvous ID
|   (gdb) rdv 2             --- case of rendezvous index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all rendezvouses
#
# [SYNOPSIS]
#   rdvlist
#---------------------------------------------------------------------------
define rdvlist
  set $cbmh = &(knl_cbmh.tsk)
  printf " idx : id       sender stat        msgsz waittsk\n"

  set $max = ((CBMH *)$cbmh)->max
  set $num = 0
  set $cbmc = ((CBMH *)$cbmh)->cell
  set $idx = 1
  while $idx <= $max
    set $cb = ((CBMC *)$cbmc)[$idx].cbp
    if $cb != 0
      set $rdvcb = ((TCB *)$cb)->rdvcb
      if $rdvcb != 0
        set $num++
        printf "[%3d]:", $idx
        if ((int)($cb) & 0x38000000) == 0x00000000
          printf " CRASHED!"
        else
          printf " %08x", ((RCB *)$rdvcb)->id
          #--
          printf " %6d", (((RDVCB *)$rdvcb)->sender_task & 0x0000ffff)
          printf " "
          set $flags = ((RDVCB *)$rdvcb)->flags 
          if $flags == 0x0000
            printf "NO         "
          else
            if ($flags & 0x0003) == 0x0003
              printf "RECVED"
            else
              if ($flags & 0x0003) == 0x0001
                printf "ACCEPT"
              else
                printf "illegal status"
              end
            end
            if ($flags & 0x0100) == 0x0100
              printf "(snr)"
            else
              printf "(snd)"
            end
          end
          printf " %5d", ((RDVCB *)$rdvcb)->msg_size
          #--Print waiting-queue
          printf " "
          qinglist $rdvcb
          #--
        end
        echo \n
      end
    end
    set $idx = $idx + 1
  end
  if $num != 0
    printf "static_max=%d\n", $num
  else
    printf "no rendezvous in this system\n"
  end
end

document rdvlist
Print list of rendezvous information.
| <usage>
|   rdvlist
|
| <ex>
|   (gdb) rdvlist
|    idx : id       sender stat        msgsz waittsk
|   [  2]: 08000002      0 NO             24 no
|   ...
|
| <output format>
|   idx    : index for TCB
|   id     : ID of rendezvous
|   sender : TCB index of task which sent message to this rendezvous
|   stat   : status of rendezvous (NO/RECVED(snr/snd)/ACCEPT(snr/snd))
|   msgsz  : size of a message
|   waittsk: TCB indexes of tasks which are waiting this resource
end

############################################################################
# << Cyclic Handler >>
#

#---------------------------------------------------------------------------
# Print CYCCB (cyclic handler) for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "cyc"
#---------------------------------------------------------------------------
define cycs
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 knl_TMCBArray -1 cyclic_handler
  else
    if *(int *)&knl_VINFO_KERNEL == 0x02000000
      print_cb $arg0 knl_TMCBArray MAXTMHANDLER cyclic_handler
    else
      print_cb $arg0 knl_CYCCBArray MAXCYC cyclic_handler
    end
  end
end

document cycs
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print CYCCB (cyclic handler)
#
# [SYNOPSIS]
#   cyc <ID or index of cyclic handler>
#
# [EXAMPLE]
#   cyc 0x01000002   --- In the case of checking with cyclic handler ID
#   cyc 2            --- In the case of checking with cyclic handler index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------
define cyc
  if *(int *)&knl_VINFO_KERNEL == 0x03000000
    print_cb $arg0 &(knl_cbmh.cyc) -2 cyclic_handler
  else
    cycs $arg0
  end
end

document cyc
Print CYCCB for cyc_id.
| <usage>
|   cyc cyc_id
|
|     cyc_id : cyclic handler ID or cyclic handler index
|
| <ex>
|   (gdb) cyc 0x01000002    --- case of cyclic handler ID
|   (gdb) cyc 2             --- case of cyclic handler index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all cyclic handlers
#
# [SYNOPSIS]
#   cyclist
#---------------------------------------------------------------------------
define cyclist
  #--Special setting for each resource
  set $cbmh = (&(knl_cbmh.cyc))
  printf " idx : id       stat curtime/initime entry\n"
  #--
  set $max = (((CBMH *)$cbmh)->max)
  set $smax = ((CBMH *)$cbmh)->static_max
  set $cbmc = (((CBMH *)$cbmh)->cell)
  set $idx = 1
  while $idx <= $max
    set $cb = (((CBMC *)$cbmc)[$idx].cbp)
    if $cb != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        printf " %08x", ((RCB *)$cb)->id
        #--Special setting for each resource
        printf " "
        if ((CYCCB *)$cb)->stat == 1
          printf "ON  "
        else
          printf "OFF "
        end
        printf " %7d/%7d", ((CYCCB *)$cb)->time, ((CYCCB *)$cb)->inittime
        printf " "
        output/a ((CYCCB *)$cb)->entry
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document cyclist
Print list of cyclic handler information.
| <usage>
|   cyclist
|
| <ex>
|   (gdb) cyclist
|    idx : id       stat curtime/initime entry
|   [  1]: 0b000001 OFF        0/      5 0x8000a33 <tmhandler>
|   ...
|
| <output format>
|   idx    : index for CYCCB
|   id     : ID of cyclic handler
|   stat   : status of cyclic handler (OFF/ON)
|   curtime: current time
|   initime: initial time
|   entry  : address of cyclic handler entry
|            <function name of cyclic handler entry>
end

#---------------------------------------------------------------------------
# Print indexes of cyclic handlers linked
# to cyclic handler management queue
#---------------------------------------------------------------------------
define cycquelist
  printf "[OFF] "
  mngque &knl_DeactCycQue
  printf "[ON]  "
  mngque &knl_ActCycQue
  printf "[EXE] "
  mngque &knl_ExeCycQue
end

document cycquelist
Print list of cyclic handler management queues.
| <usage>
|   cycquelist
|
| <caution>
|   - Necessary Symbols: PiE
|   - supported only for V3.0 kernel.
end


############################################################################
# << Variable Length Memory Pool >>
#

#---------------------------------------------------------------------------
# Print MPLCB (variable length memory pool)
# for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "mpl"
#---------------------------------------------------------------------------
define mpls
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 knl_MPLCBArray -1 variable_length_memory_pool
  else
    print_cb $arg0 knl_MPLCBArray MAXMPL variable_length_memory_pool
  end
end

document mpls
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print MPLCB (variable length memory pool)
#
# [SYNOPSIS]
#   mpl <ID or index of variable length memory pool>
#
# [EXAMPLE]
#   mpl 0x01000002   --- In the case of checking
#                        with variable length memory pool ID
#   mpl 2            --- In the case of checking
#                        with variable length memory pool index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------

define mpl
  mpls $arg0
end

document mpl
Print MPLCB for mpl_id.
| <usage>
|   mpl mpl_id
|
|     mpl_id : variable length memory pool ID
|              or variable length memory pool index
|
| <ex>
|   (gdb) mpl 0x01000002    --- case of variable length memory pool ID
|   (gdb) mpl 2             --- case of variable length memory pool index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all variable length memory pools
#
# [SYNOPSIS]
#   mpllist
#---------------------------------------------------------------------------
define mpllist
  #--Special setting for each resource
  set $cbarray = (knl_MPLCBArray)
  set $max = (MAXMPL)
  printf " idx : id           size    maxsz freblknum\n"
  #--
  set $smax = $max
  set $idx = 1
  while $idx <= $max
    #--Special setting for each resource
    set $cb = &(($cbarray)[$idx])
    #--
    if ($cb)->mplid != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        #--Special setting for each resource
        printf " %08x", ($cb)->mplid
        printf " %8d", ($cb)->mplsz
        set $maxsz = 0
        set $freblknum = 0
        set $crash = 0
        set $next = ((MPLCB *)$cb)->startque
        if $next != -1
          while $next != -1
            set $freblknum++
            if $maxsz < ($next)->blksz
              set $maxsz = ($next)->blksz
            end
            if ((int)($next) & 0x38000000) == 0x00000000
              set $crash = 1
              set $next = -1
            else
              set $next = (MBLCB *)(($next)->nxtlink)
            end
          end
        end
        if $crash == 0
          printf " %8d %9d", $maxsz, $freblknum
        else
          printf " memory crashed"
        end
        #--
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document mpllist
Print list of variable length memory pool information.
| <usage>
|   mpllist
|
| <ex>
|   (gdb) mpllist
|    idx : id           size    maxsz freblknum
|   [  1]: 09000001     2048     2032         1
|   ...
|
| <output format>
|   idx      : index for MPLCB
|   id       : ID of variable length memory pool
|   size     : size of memory pool
|   maxsz    : size of the largest free memory block
|   freblknum: number of free memory blocks (barometer of fragmentation)
end

############################################################################
# << Fixed Length Memory Pool >>
#

#---------------------------------------------------------------------------
# Print MPFCB (fixed length memory pool)
# for V1.5, V2.0 and static resources in V3.0
#
# [SYNOPSIS]
#   same as "mpf"
#---------------------------------------------------------------------------
define mpfs
  if *(int *)&knl_VINFO_KERNEL == 0x01500000
    print_cb $arg0 knl_MPFCBArray -1 fixed_length_memory_pool
  else
    print_cb $arg0 knl_MPFCBArray MAXMPF fixed_length_memory_pool
  end
end

document mpfs
(Internal macro by tak)
end

#---------------------------------------------------------------------------
# Print MPFCB (fixed length memory pool)
#
# [SYNOPSIS]
#   mpf <ID or index of fixed length memory pool>
#
# [EXAMPLE]
#   mpf 0x01000002   --- In the case of checking
#                        with fixed length memory pool ID
#   mpf 2            --- In the case of checking
#                        with fixed length memory pool index
#                        (index = lower 16 bits of ID)
#---------------------------------------------------------------------------

define mpf
  mpfs $arg0
end

document mpf
Print MPFCB for mpf_id.
| <usage>
|   mpl mpf_id
|
|     mpf_id : fixed length memory pool ID
|              or fixed length memory pool index
|
| <ex>
|   (gdb) mpf 0x01000002    --- case of fixed length memory pool ID
|   (gdb) mpf 2             --- case of fixed length memory pool index
|
| <caution>
|   - Necessary Symbols: PiE
end

#---------------------------------------------------------------------------
# Print list of all fixed length memory pools
#
# [SYNOPSIS]
#   mpflist
#---------------------------------------------------------------------------
define mpflist
  #--Special setting for each resource
  set $cbarray = (knl_MPFCBArray)
  set $max = (MAXMPF)
  printf " idx : id          blfsz   free/blfnum\n"
  #--
  set $smax = $max
  set $idx = 1
  while $idx <= $max
    #--Special setting for each resource
    set $cb = &(($cbarray)[$idx])
    #--
    if ($cb)->mpfid != 0
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        #--Special setting for each resource
        printf " %08x", ($cb)->mpfid
        printf " %8d", ($cb)->blfsz
        printf " %6d/%6d", ($cb)->blfnum, \
               ($cb)->mpfsz / (((((($cb)->blfsz)+4-1)/4)*4)+12)
        #--
      end
      echo \n
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document mpflist
Print list of fixed length memory pool information.
| <usage>
|   mpflist
|
| <ex>
|   (gdb) mpflist
|    idx : id          blfsz   free/blfnum
|   [  1]: 0a000001      260      6/     6
|   ...
|
| <output format>
|   idx   : index for MPFCB
|   id    : ID of fixed length memory pool
|   blfsz : size of a memory block
|   free  : number of free memory blocks
|   blfnum: number of all memory blocks
end

############################################################################
# << Interrupt Vector >>
#

#---------------------------------------------------------------------------
# Print list of all interrupt vector configurated in cfg files.
#
# [SYNOPSIS]
#   veclist
#---------------------------------------------------------------------------
define veclist
  #--Special setting for each resource
  set $cbarray = ((VECTABLE)->cict)
  set $INTGROUP_NUM = 64
  # The above value depends on INTGROUP_NUM in areg.h
  # in the case of PIE_KNL_CHIP_mn103e013 .
  set $max = $INTGROUP_NUM
  printf " grp : attr     lvl trgmd entry\n"
  #--
  set $smax = $max
  set $idx = 0
  while $idx < $max
    #--Special setting for each resource
    set $cb = &(($cbarray)[$idx])
    #--
    if ($cb)->intentry == 0x00000000
      set $smax = $idx
      set $idx = $max
    else
      printf "[%3d]:", ($cb)->intno
      #-- Attribute (depends on INTATTR_* pie.h)
      if ($cb)->intattr == 0x00
        printf " INDIRECT"
      else
        if ($cb)->intattr == 0x01
          printf " DIRECT  "
        else
          if ($cb)->intattr == 0x10
            printf " HEGLUE  "
          else
            if ($cb)->intattr == 0x20
              printf " SID3     "
            else
              printf " ?????????"
            end
          end
        end
      end
      #-- Level
      printf " %3d", ($cb)->intlevel
      #-- Trigger Mode (only for INDIRECT or DIRECT)
      if ($cb)->intattr == 0x00 || ($cb)->intattr == 0x01
        set $trgmode = 0
        set $trgcbarray = ((TRIGTABLE)->trgmd)
        set $i = 0
        while $i < $max
          set $trgcb = &(($trgcbarray)[$i])
          if ($trgcb)->trigmode == 0
            set $i = $max
          else
            if ($trgcb)->irqno == ($cb)->intno
              set $trgmode = ($trgcb)->trigmode
              set $i = $max
            end
            set $i = $i + 1
          end
        end
        printf " "
        if $trgmode == 0
          printf "LOW  "
        else 
          if $trgmode == 1
            printf "HIGH "
          else
            if $trgmode == 2
              printf "NEG  "
            else
              if $trgmode == 3
                printf "POS  "
              else
                printf "?????"
              end
            end
          end
        end
      end
      #-- Entry
      printf " "
      output/a ($c)->intentry[0]
      echo \n
    end
    set $idx = $idx + 1
  end
  if $idx <= $max
    set $smax = $idx - 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document veclist
Print list of interrupt vector information configurated in cfg files.
| <usage>
|   veclist
|
| <ex>
|   (gdb) veclist
|    grp : lvl trgmd entry
|   [ 34]:   4 LOW   
|   ...
|
| <output format>
|   grp  : group number of interrupt vector
|   lvl  : interrupt mask level for interrupt vector
|   trgmd: interrupt trigger mode for interrupt vector (LOW/HIGH/NEG/POS)
|   entry: address of interrupt handler entry <entry name>
|     
| <caution>
|   - Outputs of this command are data configurated in configuration files.
|     Use "intlist",
|     if you want to see information on internal variables of PiE Kernel.
end

#---------------------------------------------------------------------------
# Print list of all interrupt vector registered to PiE Kernel
#
# [SYNOPSIS]
#   intlist
#---------------------------------------------------------------------------
define intlist
  set $INTGROUP_NUM = 64
  # The above value depends on INTGROUP_NUM in areg.h
  # in the case of PIE_KNL_CHIP_mn103e013
  set $SID3_IRQ_GROUP = 47
  # The above value depends on SID3_IRQ_GROUP in reg.h
  set $SID3_INTGROUP_NUM = 12
  # The above value depends on SID3_INTGROUP_NUM in reg.h
  #------------------------------ Interrupt Vectors
  printf "<<Interrupt Vectors>>\n"
  #--Special setting for each resource
  set $cbarray = (knl_ICTArray)
  set $max = $INTGROUP_NUM
  printf " grp : entry\n"
  #--
  set $smax = 0
  set $idx = 1
  while $idx <= $max
    #--Special setting for each resource
    set $cb = &(($cbarray)[$idx])
    #--
    if ($cb)->intentry[0] != &(KNL_core_unimple_inthandler)
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        #--Special setting for each resource
        printf " "
        output/a ($cb)->intentry[0]
        #--
      end
      echo \n
      set $smax++
      #-- eSTB Special !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      if *(int *)&knl_VINFO_KERNEL == 0x03000000
        if $idx == $SID3_IRQ_GROUP && \
           ($cb)->intentry[0] != &(PIE_sid3_handler)
          printf " (PIE_sid3_handler should be specified to interrupt %d)\n" \
                 $SID3_IRQ_GROUP
        end
      end
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
  #------------------------------ Interrupt Vectors of SID3
  printf "<<Interrupt Vectors of SID3>>\n"
  #--Special setting for each resource
  set $cbarray = (knl_SID3_ICTArray)
  set $max = $SID3_INTGROUP_NUM
  printf " grp : entry\n"
  #--
  set $smax = 0
  set $idx = 1
  while $idx <= $max
    #--Special setting for each resource
    set $cb = &(($cbarray)[$idx])
    #--
    if ($cb)->intentry[0] != 0x00000000
      printf "[%3d]:", $idx
      if ((int)($cb) & 0x38000000) == 0x00000000
        printf " CRASHED!"
      else
        #--Special setting for each resource
        printf " "
        output/a ($c)->intentry[0]
        #--
      end
      echo \n
      set $smax++
    end
    set $idx = $idx + 1
  end
  printf "static_max=%d, max=%d\n", $smax, $max
end

document intlist
Print list of interrupt vector information registered to PiE Kernel.
| * I recommend that you use "vec" and "veclist" commands.
| 
| <usage>
|   intlist
|
| <ex>
|   (gdb) intlist
|   <<Interrupt Vectors>>
|    grp : entry
|   [  1]: 
|   ...
|   <<Interrupt Vectors of SID3>>
|    grp : entry
|   [  1]: 
|   ...
|
| <output format>
|   idx  : index for interrupt control block (ICT)
|   entry: address of interrupt handler entry <entry name>
|
| <caution>
|   - Outputs of this command are data on internal variables of PiE Kernel.
|     Use "veclist",
|     if you want to see information configurated in configuration files,
end

############################################################################
# << Address Operation >>
#

#---------------------------------------------------------------------------
# Translate virtual address to physical address (Internal Macro)
#---------------------------------------------------------------------------
define addr_trans
  set $mm = (struct mm_struct *)$arg0
  set $va = (unsigned long)$arg1
  set $pgd = (pgd_t *)( ($mm)->pgd + (($va >> 22) & 0x3ff) )
  set $pmd = (pmd_t *)($pgd)
  set $pmd_page = (void *)( (($pmd)->pmd & 0xFFFFF000) + 0x90000000 )
  set $pte = (pte_t *)((pte_t *)($pmd_page) + (($va >> 12) & 0x3ff))
  set $pte_low = (unsigned long)(($pte)->pte_low)

  if $pte_low == 0
    echo This page is not mapped.\n
  else
      set $page = (struct page *)(mem_map + ($pte_low >> 12))
      set $pa = (unsigned long)(($page - mem_map)*4096)
      set $pa += ($va & 0x0FFF) + 0x90000000
      printf "pa=%08x\n", $pa
  end
end

#---------------------------------------------------------------------------
# Translate virtual address on current process to physical address
#---------------------------------------------------------------------------
define v2p
  set $ts = (struct task_struct *)(($ssp - 1) & ~8191)
  set $mm = ($ts)->mm

  if $mm == 0
    echo Current process does not have a virtual address space.\n
  else
    addr_trans $mm $arg0
  end
end

document v2p
Translate virtual address on current process to physical address.
| 
| <usage>
|   v2p vaddr
|
|     vaddr : virtual address
|
| <ex>
|   (gdb) v2p 0x08000000
|
| <caution>
|   - Necessary Symbols: Linux
end

#---------------------------------------------------------------------------
# Translate virtual address on any process to physical address
#---------------------------------------------------------------------------
define v2p_pid
  set $pid = $arg1
  #-- depend on Linux code (linux/include/linux/sched.h)
  set $PIDHASH_SZ = (4096 >> 2)
  set $hashno = (((($pid) >> 8) ^ ($pid)) & ($PIDHASH_SZ - 1))
  set $ts = (pidhash[$hashno])
  if $ts == 0
    echo This process does not exist.\n
  else
    set $ts_tgt = 0
    while $ts != 0
      if ($ts)->pid == $pid
        set $ts_tgt = $ts
      end
      set $ts = ($ts)->pidhash_next
    end
    if $ts_tgt == 0
      echo This process does not exist.\n
    else
      set $mm = ($ts_tgt)->mm
      if $mm == 0
        echo This process does not have a virtual address space.\n
      else
#        print_comm $ts_tgt
        printf "%s", &($ts_tgt->comm)
        echo \n
        addr_trans $mm $arg0
      end
    end
  end
end

document v2p_pid
Translate virtual address on any process to physical address.
| 
| <usage>
|   v2p_pid vaddr pid
|
|     vaddr : virtual address
|     pid   : process ID
|
| <ex>
|   (gdb) v2p 0x08000000 13
|
| <caution>
|   - Necessary Symbols: Linux
end


define ed
setarch
set *((char *)$buswidth)=4
set *(int *)$arg0=$arg1
set *((char *)$buswidth)=0
end

document ed
Edit double word (32bits) data
| <usage>
|   ed address data
|
|     address : address to edit
|     data    : data to write
|
| <ex>
|   (gdb) ed 0x08004000 1
end

define ew
setarch
set *((char *)$buswidth)=2
set *(short *)$arg0=$arg1
set *((char *)$buswidth)=0
end

document ew
Edit word (16bits) data
| <usage>
|   ew address data
|
|     address : address to edit
|     data    : data to write
|
| <ex>
|   (gdb) ew 0x08004000 1
end

define eb
setarch
set *((char *)$buswidth)=1
set *(char *)$arg0=$arg1
set *((char *)$buswidth)=0
end

document eb
Edit byte (8bits) data
| <usage>
|   eb address data
|
|     address : address to edit
|     data    : data to write
|
| <ex>
|   (gdb) eb 0x08004000 1
end

define dd
setarch
set *((char *)$buswidth)=4
x/w $arg0
set *((char *)$buswidth)=0
end

document dd
Dump double word (32bits) data
| <usage>
|   dd address
|
|     address : address to dump
|
| <ex>
|   (gdb) dd 0x08004000
end

define dw
setarch
set *((char *)$buswidth)=2
x/h $arg0
set *((char *)$buswidth)=0
end

document dw
Dump word (16bits) data
| <usage>
|   dw address
|
|     address : address to dump
|
| <ex>
|   (gdb) dw 0x08004000
end

define db
setarch
set *((char *)$buswidth)=1
x/b $arg0
set *((char *)$buswidth)=0
end

document db
Dump byte (8bits) data
| <usage>
|   db address
|
|     address : address to dump
|
| <ex>
|   (gdb) db 0x08004000
end


############################################################################
# Change record
#
#  2001.08.09 T.Matsumoto(CSC)  Created newly.
#  2001.09.10 T.Matsumoto(CSC)  Added printing list of kernel resources
#                               without task.
#  2001.09.14 T.Matsumoto(CSC)  Added printing control block.
#  2001.09.17 T.Matsumoto(CSC)  Added mpl,mpf. Added maximum number of
#                               messages used simultaneously to quelist.
#  2001.09.21 T.Matsumoto(CSC)  Added usage.
#  2001.09.25 T.Matsumoto(CSC)  Added cyclist. Supported some for V1.5
#                               Kernel.
#  2001.09.27 T.Matsumoto(CSC)  Added proclist. Fixed bug of cndlist.
#                               Modified display of xxxlist.
#  2001.10.04 T.Matsumoto(CSC)  Added almlist and stklist.
#  2001.10.05 T.Matsumoto(CSC)  Added stkuse and stkuselist.
#  2001.10.09 T.Matsumoto(CSC)  Fixed bug of stklist.
#                               Deleted rmt, krmt, pield, linuxld.
#  2001.10.11 T.Matsumoto(CSC)  Modified stkuse, stkuselist.
#                               (added checking bottom of stack)
#  2001.10.17 T.Matsumoto(CSC)  Fixed bug of stklist.
#                               (incorrect printing "CRASHED!")
#  2001.10.18 T.Matsumoto(CSC)  Translated Japanese into English.
#  2001.10.25 T.Matsumoto(CSC)  Fixed bug about tsklist. (missprint status)
#                               Modified stkuse, stkuselist.
#                               as DORMANT task stack is not checked.
#                               Fixed bug about checking invalid address.
#  2001.11.08 T.Matsumoto(CSC)  Fixed bug about tskquelist. (missprint)
#                               Added veclist and intlist.
#  2001.12.12 T.Matsumoto(CSC)  Fixed bug about proclist(illegal access),
#                               tsklist(missprint)
#                               Added "pri" printing to tsklist.
#                               Added "command" printing to proclist.
#  2001.12.28 T.Matsumoto(CSC)  Modified current and proc.
#                               Added stkinfo.
#  2002.01.22 T.Matsumoto(CSC)  Added datainfo, sysinfo, rlimlist,
#                               proc_by_tskid, tsk_by_pid.
#  2002.02.27 K.Okuno(CSC)      Added v2a, v2a_pid.
#             T.Matsumoto(CSC)  Modified current so that it can work
#                               on user mode.
#                               Added dump family(dump, dump[bhw], filedump).
#                               Added piecurrent, pieproc
#  2002.03.27 T.Matsumoto(CSC)  Added show_ts. Fixed some bugs
#  2002.04.09 K.Okuno(CSC)      Added procmeminfo, procmem_by_pid.
#                               Fixed a bug of sysinfo.
#             T.Matsumoto(CSC)  Modified current, procinfo.
#  2004.05.31 K.Okuno(CAC)      Added shm2_dump
#  2006.03.06 K.Okuno(PFC)      Modified for pprosrc.
############################################################################


#EOF

### add by hirai


define tgtr
#set scheduler-locking step
set sysroot /home/nfsroot/lfbc70_nfsroot
set solib-search-path /home/nfsroot/lfbc70_nfsroot/lib:../../../rootfs/HardwareLibrary/dcchd/lib:../../../rootfs/HardwareLibrary/dcchd/lib/directfb-1.4-2:../../../rootfs/HardwareLibrary/dcchd/lib/directfb-1.4-2/wm:../../../rootfs/HardwareLibrary/mrua/lib:../../../rootfs/HardwareLibrary/userlib:

source ../drawtool ../sysmgr ../decreal ../lib ../langlib ../penlib ../conflib ../memView ../mailsend
source ../../../sdk4.2.1/dcchd_SMP86xx-72-74_rc_4_4_2_1_bug39995_20130822_black.mips/directfb-1.4/directfb/src
source ../../../sdk4.2.1/dcchd_SMP86xx-72-74_rc_4_4_2_1_bug39995_20130822_black.mips/directfb-1.4/directfb/src/core
source ../../../sdk4.2.1/dcchd_SMP86xx-72-74_rc_4_4_2_1_bug39995_20130822_black.mips/directfb-1.4/directfb/src/display
source ../../../sdk4.2.1/dcchd_SMP86xx-72-74_rc_4_4_2_1_bug39995_20130822_black.mips/directfb-1.4/directfb/src/gfx
source ../../../sdk4.2.1/dcchd_SMP86xx-72-74_rc_4_4_2_1_bug39995_20130822_black.mips/directfb-1.4/directfb/src/media
source ../../../sdk4.2.1/dcchd_SMP86xx-72-74_rc_4_4_2_1_bug39995_20130822_black.mips/directfb-1.4/directfb/src/misc
source ../../../sdk4.2.1/dcchd_SMP86xx-72-74_rc_4_4_2_1_bug39995_20130822_black.mips/directfb-1.4/directfb/src/windows
source ../../../sdk4.2.1/mrua_SMP8674F_4_2_1_dev.mips/MRUA_src/rmhdmi/src/
source ../../../sdk4.2.1/mrua_SMP8674F_4_2_1_dev.mips/MRUA_src/rmlibplay/src

target remote 192.168.0.8:1234
display/i $pc

end


define adddcc
	add-shared-symbol-file /home/nfsroot/lfbc70_nfsroot/lib/libc-2.8.so
end

define load-media
##	add-shared-symbol-file /usr/src/glibc/glibc/obj/libc.so
##	add-shared-symbol-file /usr/src/glibc/glibc/obj/linuxthreads/libpthread.so
##	add-shared-symbol-file /usr/src/glibc/glibc/obj/linuxthreads/libpthread.so
##	add-shared-symbol-file /usr/src/glibc/glibc/obj/nss/libnss_files.so
##	add-shared-symbol-file /usr/src/glibc/glibc/obj/dlfcn/libdl.so
##	add-shared-symbol-file /usr/src/glibc/glibc/obj/math/libm.so
##	add-shared-symbol-file /usr/src/glibc_prel/glibc/obj/libc.so
##	add-shared-symbol-file /usr/src/glibc_prel/glibc/obj/linuxthreads/libpthread.so
##	add-shared-symbol-file /usr/src/glibc_prel/glibc/obj/linuxthreads/libpthread.so
##	add-shared-symbol-file /usr/src/glibc_prel/glibc/obj/nss/libnss_files.so
##	add-shared-symbol-file /usr/src/glibc_prel/glibc/obj/dlfcn/libdl.so
##	add-shared-symbol-file /usr/src/glibc_prel/glibc/obj/math/libm.so
##	add-shared-symbol-file /usr/src/XFree86/XFree86/xc/lib/X11/libX11.so.6.2
##	add-shared-symbol-file /usr/src/XFree86/XFree86/xc/lib/Xext/libXext.so.6.4
##	add-shared-symbol-file /usr/src/XFree86/XFree86/xc/lib/Xft/libXft.so.1.1
#	add-shared-symbol-file /usr/src/XFree86/XFree86/xc/lib/Xrender/libXrender.so.1.1
#	add-shared-symbol-file /usr/src/XFree86/XFree86/xc/lib/Xstream/libXstream.so.1.0
#	add-shared-symbol-file /usr/src/XFree86/XFree86/xc/lib/freetype2/libfreetype.so.8.0
#	add-shared-symbol-file /usr/src/XFree86/XFree86/xc/lib/pftlib/libpftlib.so.1.0
#	add-shared-symbol-file /usr/bdrec-src/appli/audiolib/libamdl.so
#	add-shared-symbol-file /usr/bdrec-src/appli/eeplib/src/libapli_eeplib.so
#	add-shared-symbol-file /usr/bdrec-src/appli/media/mng/lib/libapli_media_api.so
#	add-shared-symbol-file /usr/bdrec-src/appli/media/medialib/libapli_media_lib.so
#	add-shared-symbol-file /usr/bdrec-src/mw/avio/avio_audio/work/libavio_audio.so
#	add-shared-symbol-file /usr/bdrec-src/mw/avio/avio_avin/work/libavio_avin.so
#	add-shared-symbol-file /usr/bdrec-src/mw/avio/avio_video/libavio_video.so
#	add-shared-symbol-file /usr/bdrec-src/mw/toolkit/ctk/src/libctk.so
#	add-shared-symbol-file /usr/bdrec-src/hal/dbg_output/libdbg_output.so
#	add-shared-symbol-file /usr/bdrec-src/mw/stream/hal/wrapper/libdemux.so
#	add-shared-symbol-file /usr/bdrec-src/appli/dlp/libdlp.so
#	add-shared-symbol-file /usr/bdrec-src/mw/toolkit/dtk/preload/libdtk.so
#	add-shared-symbol-file /usr/bdrec-src/mw/toolkit/dtk/stream/libdtkstream.so
#	add-shared-symbol-file /usr/bdrec-src/mw/dwm/dwmlib/libdwm.so
#	add-shared-symbol-file /usr/bdrec-src/hal/eeprom/eeplib/libeep.so
#	add-shared-symbol-file /usr/bdrec-src/mw/em/lib/libem.so
#	add-shared-symbol-file /usr/bdrec-src/appli/frontend/lib/libfep.so
#	add-shared-symbol-file /usr/bdrec-src/mw/swup/fmupre/libfmupre.so
#	add-shared-symbol-file /usr/bdrec-src/hal/fpc/libfpc.so
#	add-shared-symbol-file /usr/bdrec-src/mw/stream/hal/wrapper/libidedet.so
#	add-shared-symbol-file /usr/bdrec-src/mw/moc/lib/libmoc.so
#	add-shared-symbol-file /usr/bdrec-src/appli/navl/libnavl.so
#	add-shared-symbol-file /usr/bdrec-src/mw/stream/hal/wrapper/libpktcnt.so
#	add-shared-symbol-file /usr/bdrec-src/mw/sdm/rma/librma.so
#	add-shared-symbol-file /usr/bdrec-src/appli/rsvlib/librsvbd.so
#	add-shared-symbol-file /usr/bdrec-src/mw/sdm/sdmlib/libsdm.so
#	add-shared-symbol-file /usr/bdrec-src/appli/slm/libslm.so
#	add-shared-symbol-file /usr/bdrec-src/mw/stream/hal/wrapper/libswitch.so
#	add-shared-symbol-file /usr/bdrec-src/mw/thumbnail/lib/libtnl.so
#	add-shared-symbol-file /usr/bdrec-src/mw/stream/hal/wrapper/libtsport.so
#	add-shared-symbol-file /usr/bdrec-src/mw/vdm/src/libvdm.so
#	add-shared-symbol-file /usr/dtv-src/aj8/libaj8.so
#	add-shared-symbol-file /usr/src/dmashm/libdmashm.so
##	add-shared-symbol-file /usr/src/gtk/gtk/gtk/gtk+-1.2.10/gdk/.libs/libgdk-1.2.so.0.9.1
##	add-shared-symbol-file /usr/src/gtk/gtk/glib/glib-1.2.10/.libs/libglib-1.2.so.0.0.10
##	add-shared-symbol-file /usr/src/gtk/gtk/glib/glib-1.2.10/gmodule/.libs/libgmodule-1.2.so.0.0.10
##	add-shared-symbol-file /usr/src/gtk/gtk/glib/glib-1.2.10/gthread/.libs/libgthread-1.2.so.0.0.10
##	add-shared-symbol-file /usr/src/gtk/gtk/gtk/gtk+-1.2.10/gtk/.libs/libgtk-1.2.so.0.9.1
#	add-shared-symbol-file /usr/src/libpng/libpng/libpng.so.3.1.2.1
#	add-shared-symbol-file /usr/dtv-src/misc/libtuneinf/libtuneinf.so
#	add-shared-symbol-file /usr/src/zlib/libz.so.1.1.3
##	add-shared-symbol-file /usr/dtvrec/lib/libctk.so
##	add-shared-symbol-file /usr/src/dtvrec/mw/toolkit/ctk/src/libctk.so
##	add-shared-symbol-file /usr/src/dtvrec/mw/toolkit/dtk/stream/libdtkstream.so
##	add-shared-symbol-file /usr/src/dtvrec/appli/lib/langlib/obj/libmulang.so
##	add-shared-symbol-file /usr/src/dtvrec/appli/lib/ply3dlib/obj/libapl_ply3d.so
##	add-shared-symbol-file /usr/src/dtvrec/appli/lib/plystatlib/obj/libapl_plystat.so
##	add-shared-symbol-file /usr/src/dtvrec/appli/lib/envlib/obj/apl_envlib_api.os
##	add-shared-symbol-file /usr/src/dtvrec/mw/rui/lib/rui_ex_api/rui_ex_api.os
end

define load-rui
	add-shared-symbol-file /usr/src/dtvrec/mw/rui/lib/rui_ex_api/rui_ex_api.os
end
