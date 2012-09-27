From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [tty:tty-next 36/40] kernel/debug/kdb/kdb_main.c:2839:4: warning:
 passing argument 2 of 'kdb_register_repeat' from incompatible pointer type
Date: Thu, 27 Sep 2012 09:29:16 +0800
Message-ID: <20120927012916.GA9207@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48909 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529Ab2I0B3X (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 21:29:23 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Yuanhan Liu <yuanhan.liu@intel.com>, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>

Hi Anton,

FYI, there are new compile warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   0c57dfcc6c1d037243c2f8fbf62eab3633326ec0
commit: 729043e82cdd403a131127254528afea8031ebab [36/40] kdb: Turn KGDB_KDB=n stubs into static inlines
config: cris-allyesconfig

All warnings (together with lots of *old* errors):

kernel/debug/kdb/kdb_bp.c: In function 'kdb_parsebp':
kernel/debug/kdb/kdb_bp.c:56:18: error: 'BP_ACCESS_WATCHPOINT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:56:18: note: each undeclared identifier is reported only once for each function it appears in
kernel/debug/kdb/kdb_bp.c:58:18: error: 'BP_WRITE_WATCHPOINT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:60:18: error: 'BP_HARDWARE_BREAKPOINT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:62:11: error: 'KDB_ARGCOUNT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:78:12: error: 'KDB_BADLENGTH' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function '_kdb_bp_remove':
kernel/debug/kdb/kdb_bp.c:100:9: error: 'arch_kgdb_ops' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function 'kdb_handle_bp':
kernel/debug/kdb/kdb_bp.c:110:6: error: 'kdb_flags' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function '_kdb_bp_install':
kernel/debug/kdb/kdb_bp.c:132:6: error: 'kdb_flags' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:148:9: error: 'arch_kgdb_ops' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function 'kdb_bp_install':
kernel/debug/kdb/kdb_bp.c:183:7: error: 'kdb_flags' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function 'kdb_bp_remove':
kernel/debug/kdb/kdb_bp.c:214:7: error: 'kdb_flags' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function 'kdb_printbp':
kernel/debug/kdb/kdb_bp.c:244:38: error: 'KDB_SP_DEFAULT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function 'kdb_bp':
kernel/debug/kdb/kdb_bp.c:309:10: error: 'KDB_BADINT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:320:10: error: 'KDB_TOOMANYBPT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:323:22: error: 'BP_HARDWARE_BREAKPOINT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:328:22: error: 'BP_BREAKPOINT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:343:11: error: 'KDB_DUPBPT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function 'kdb_bc':
kernel/debug/kdb/kdb_bp.c:402:10: error: 'KDB_ARGCOUNT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:483:19: error: 'KDB_BPTNOTFOUND' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function 'kdb_ss':
kernel/debug/kdb/kdb_bp.c:521:10: error: 'KDB_ARGCOUNT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function 'kdb_initbptab':
kernel/debug/kdb/kdb_bp.c:552:6: error: 'arch_kgdb_ops' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c:552:28: error: 'KGDB_HW_BREAKPOINT' undeclared (first use in this function)
kernel/debug/kdb/kdb_bp.c: In function 'kdb_bc':
kernel/debug/kdb/kdb_bp.c:484:1: warning: control reaches end of non-void function [-Wreturn-type]
--
kernel/debug/kdb/kdb_main.c:981:19: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:981:10: warning: passing argument 1 of 'strlen' from incompatible pointer type [enabled by default]
include/linux/string.h:81:24: note: expected 'const char *' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:981:10: warning: passing argument 2 of 'strncmp' from incompatible pointer type [enabled by default]
include/linux/string.h:45:12: note: expected 'const char *' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:991:16: error: request for member 'cmd_func' in something not a structure or union
kernel/debug/kdb/kdb_main.c:991:27: error: called object '*(struct kdbmsg_t *)&<erroneous-expression>' is not a function
kernel/debug/kdb/kdb_main.c:991:10: warning: assignment makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:995:13: error: request for member 'cmd_repeat' in something not a structure or union
kernel/debug/kdb/kdb_main.c:1027:4: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1031:33: error: 'KDB_SP_DEFAULT' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:1031:3: warning: passing argument 3 of 'kdb_symbol_print' makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_private.h:115:13: note: expected 'unsigned int' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c: In function 'kdb_dumpregs':
kernel/debug/kdb/kdb_main.c:1079:2: error: 'kdb_trap_printk' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:1079:17: error: lvalue required as increment operand
kernel/debug/kdb/kdb_main.c:1079:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:1081:17: error: lvalue required as decrement operand
kernel/debug/kdb/kdb_main.c:1081:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c: In function 'kdb_set_current_task':
kernel/debug/kdb/kdb_main.c:1090:2: error: implicit declaration of function 'kdb_task_has_cpu' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c:1091:3: error: implicit declaration of function 'KDB_TSKREGS' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c:1091:3: error: implicit declaration of function 'kdb_process_cpu' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c:1091:20: warning: assignment makes pointer from integer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c: At top level:
kernel/debug/kdb/kdb_main.c:1117:22: error: unknown type name 'kdb_reason_t'
kernel/debug/kdb/kdb_main.c:1118:8: error: unknown type name 'kdb_dbtrap_t'
kernel/debug/kdb/kdb_main.c:1335:19: error: unknown type name 'kdb_reason_t'
kernel/debug/kdb/kdb_main.c:1335:40: error: unknown type name 'kdb_reason_t'
kernel/debug/kdb/kdb_main.c:1336:8: error: unknown type name 'kdb_dbtrap_t'
kernel/debug/kdb/kdb_main.c: In function 'kdb_md':
kernel/debug/kdb/kdb_main.c:1515:46: error: 'KDB_WORD_SIZE' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:1515:46: warning: initialization makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1534:4: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1562:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1566:4: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1582:4: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1612:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1617:19: warning: comparison between pointer and integer [enabled by default]
kernel/debug/kdb/kdb_main.c:1618:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1634:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1645:16: warning: assignment makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1658:16: error: 'CMD_INTERRUPT' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c: In function 'kdb_mm':
kernel/debug/kdb/kdb_main.c:1704:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1707:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1715:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1721:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1723:45: error: 'KDB_WORD_SIZE' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:1723:42: warning: pointer/integer type mismatch in conditional expression [enabled by default]
kernel/debug/kdb/kdb_main.c:1723:8: warning: assignment makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c: In function 'kdb_go':
kernel/debug/kdb/kdb_main.c:1748:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1757:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1761:15: error: 'CATASTROPHIC' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c: In function 'kdb_rd':
kernel/debug/kdb/kdb_main.c:1785:5: warning: "DBG_MAX_REG_NUM" is not defined [-Wundef]
kernel/debug/kdb/kdb_main.c: In function 'kdb_rm':
kernel/debug/kdb/kdb_main.c:1854:5: warning: "DBG_MAX_REG_NUM" is not defined [-Wundef]
kernel/debug/kdb/kdb_main.c: In function 'kdb_sr':
kernel/debug/kdb/kdb_main.c:1922:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1923:2: error: 'kdb_trap_printk' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:1923:17: error: lvalue required as increment operand
kernel/debug/kdb/kdb_main.c:1923:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:1925:17: error: lvalue required as decrement operand
kernel/debug/kdb/kdb_main.c:1925:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c: In function 'kdb_ef':
kernel/debug/kdb/kdb_main.c:1948:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c: In function 'kdb_lsmod':
kernel/debug/kdb/kdb_main.c:1969:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1972:2: error: 'kdb_modules' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:1972:2: error: 'kdbmsg_t' has no member named 'next'
kernel/debug/kdb/kdb_main.c:1972:2: warning: initialization from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:1972:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]
kernel/debug/kdb/kdb_main.c: In function 'kdb_dmesg':
kernel/debug/kdb/kdb_main.c:2043:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c: In function 'kdb_disable_nmi':
kernel/debug/kdb/kdb_main.c:2120:2: error: 'arch_kgdb_ops' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2120:15: error: request for member 'enable_nmi' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2120:26: error: called object '<erroneous-expression>' is not a function
kernel/debug/kdb/kdb_main.c:2120:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c: In function 'kdb_param_enable_nmi':
kernel/debug/kdb/kdb_main.c:2128:2: error: 'arch_kgdb_ops' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2128:15: error: request for member 'enable_nmi' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2128:26: error: called object '<erroneous-expression>' is not a function
kernel/debug/kdb/kdb_main.c:2128:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c: In function 'kdb_cpu_status':
kernel/debug/kdb/kdb_main.c:2155:4: error: implicit declaration of function 'kdb_task_state_char' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c:2155:4: error: implicit declaration of function 'KDB_TSK' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c: In function 'kdb_cpu':
kernel/debug/kdb/kdb_main.c:2197:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2207:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c: In function 'kdb_ps_suppressed':
kernel/debug/kdb/kdb_main.c:2223:2: error: implicit declaration of function 'kdb_task_state_string' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c:2229:3: error: implicit declaration of function 'kdb_task_state' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c:2232:2: error: implicit declaration of function 'kdb_do_each_thread' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c:2232:27: error: expected ';' before '{' token
kernel/debug/kdb/kdb_main.c:2224:9: warning: unused variable 'mask_M' [-Wunused-variable]
kernel/debug/kdb/kdb_main.c: In function 'kdb_ps1':
kernel/debug/kdb/kdb_main.c:2274:21: warning: comparison between pointer and integer [enabled by default]
kernel/debug/kdb/kdb_main.c:2276:8: warning: format '%p' expects argument of type 'void *', but argument 2 has type 'int' [-Wformat]
kernel/debug/kdb/kdb_main.c: In function 'kdb_ps':
kernel/debug/kdb/kdb_main.c:2294:16: error: 'CMD_INTERRUPT' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2302:27: error: expected ';' before '{' token
kernel/debug/kdb/kdb_main.c: In function 'kdb_pid':
kernel/debug/kdb/kdb_main.c:2324:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2328:6: warning: assignment makes pointer from integer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2332:5: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c: In function 'kdb_ll':
kernel/debug/kdb/kdb_main.c:2365:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2383:32: error: 'GFP_KDB' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2383:2: warning: passing argument 2 of 'kdb_strdup' makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_private.h:114:14: note: expected 'gfp_t' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:2394:16: error: 'CMD_INTERRUPT' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c: In function 'kdb_help':
kernel/debug/kdb/kdb_main.c:2422:2: error: unknown type name 'kdbtab_t'
kernel/debug/kdb/kdb_main.c:2429:9: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2430:43: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2431:10: error: request for member 'cmd_usage' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2431:25: error: request for member 'cmd_help' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2431:8: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct kdbmsg_t *' [-Wformat]
kernel/debug/kdb/kdb_main.c:2431:8: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'struct kdbmsg_t *' [-Wformat]
kernel/debug/kdb/kdb_main.c:2431:8: warning: format '%s' expects argument of type 'char *', but argument 4 has type 'struct kdbmsg_t *' [-Wformat]
kernel/debug/kdb/kdb_main.c:2432:16: error: 'CMD_INTERRUPT' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c: In function 'kdb_kill':
kernel/debug/kdb/kdb_main.c:2449:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2453:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2462:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2480:2: error: implicit declaration of function 'kdb_send_sig_info' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c: In function 'kdb_summary':
kernel/debug/kdb/kdb_main.c:2549:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c: In function 'kdb_per_cpu':
kernel/debug/kdb/kdb_main.c:2604:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2616:18: error: 'KDB_WORD_SIZE' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2616:16: warning: assignment makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2617:24: warning: comparison between pointer and integer [enabled by default]
kernel/debug/kdb/kdb_main.c:2618:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2626:4: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2643:16: error: 'CMD_INTERRUPT' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2657:17: warning: comparison between pointer and integer [enabled by default]
kernel/debug/kdb/kdb_main.c: At top level:
kernel/debug/kdb/kdb_main.c:2696:5: error: redefinition of 'kdb_register_repeat'
include/linux/kdb.h:156:19: note: previous definition of 'kdb_register_repeat' was here
kernel/debug/kdb/kdb_main.c: In function 'kdb_register_repeat':
kernel/debug/kdb/kdb_main.c:2704:2: error: unknown type name 'kdbtab_t'
kernel/debug/kdb/kdb_main.c:2710:9: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2710:33: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2710:3: warning: passing argument 1 of 'strcmp' from incompatible pointer type [enabled by default]
include/linux/string.h:42:12: note: expected 'const char *' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:2721:9: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2726:3: error: unknown type name 'kdbtab_t'
kernel/debug/kdb/kdb_main.c:2727:41: error: 'GFP_KDB' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2727:5: warning: passing argument 2 of 'kmalloc' makes integer from pointer without a cast [enabled by default]
include/linux/slub_def.h:267:30: note: expected 'gfp_t' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:2745:4: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2745:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:2746:4: error: request for member 'cmd_func' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2746:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:2747:4: error: request for member 'cmd_usage' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2747:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:2748:4: error: request for member 'cmd_help' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2748:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:2749:4: error: request for member 'cmd_flags' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2749:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:2750:4: error: request for member 'cmd_minlen' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2750:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:2751:4: error: request for member 'cmd_repeat' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2751:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c: At top level:
kernel/debug/kdb/kdb_main.c:2770:5: error: redefinition of 'kdb_register'
include/linux/kdb.h:154:19: note: previous definition of 'kdb_register' was here
kernel/debug/kdb/kdb_main.c:2790:5: error: redefinition of 'kdb_unregister'
include/linux/kdb.h:159:19: note: previous definition of 'kdb_unregister' was here
kernel/debug/kdb/kdb_main.c: In function 'kdb_unregister':
kernel/debug/kdb/kdb_main.c:2793:2: error: unknown type name 'kdbtab_t'
kernel/debug/kdb/kdb_main.c:2799:9: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2799:33: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2799:3: warning: passing argument 1 of 'strcmp' from incompatible pointer type [enabled by default]
include/linux/string.h:42:12: note: expected 'const char *' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:2800:6: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2800:4: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c: In function 'kdb_inittab':
kernel/debug/kdb/kdb_main.c:2814:2: error: unknown type name 'kdbtab_t'
kernel/debug/kdb/kdb_main.c:2817:5: error: request for member 'cmd_name' in something not a structure or union
kernel/debug/kdb/kdb_main.c:2817:3: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:2838:28: error: 'kdb_bt' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2839:4: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:2696:5: note: expected 'kdb_func_t' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:2841:4: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:2696:5: note: expected 'kdb_func_t' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:2843:4: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:2696:5: note: expected 'kdb_func_t' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:2845:4: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:2696:5: note: expected 'kdb_func_t' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:2848:8: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:2696:5: note: expected 'kdb_func_t' but argument is of type 'struct kdbmsg_t *'
kernel/debug/kdb/kdb_main.c:2881:6: error: 'arch_kgdb_ops' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2881:19: error: request for member 'enable_nmi' in something not a structure or union
kernel/debug/kdb/kdb_main.c: In function 'kdb_cmd_init':
kernel/debug/kdb/kdb_main.c:2901:14: error: 'kdb_cmds' undeclared (first use in this function)
kernel/debug/kdb/kdb_main.c:2901:14: error: used struct type value where scalar is required
kernel/debug/kdb/kdb_main.c:2902:3: error: incompatible type for argument 1 of 'kdb_parse'
kernel/debug/kdb/kdb_main.c:851:5: note: expected 'const char *' but argument is of type 'kdbmsg_t'
kernel/debug/kdb/kdb_main.c:2902:8: warning: assignment makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2905:5: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'kdbmsg_t' [-Wformat]
kernel/debug/kdb/kdb_main.c: At top level:
kernel/debug/kdb/kdb_main.c:2914:13: error: redefinition of 'kdb_init'
include/linux/kdb.h:153:20: note: previous definition of 'kdb_init' was here
kernel/debug/kdb/kdb_main.c: In function 'kdb_init':
kernel/debug/kdb/kdb_main.c:2925:4: error: implicit declaration of function 'kdb_initbptab' [-Werror=implicit-function-declaration]
kernel/debug/kdb/kdb_main.c: At top level:
kernel/debug/kdb/kdb_main.c:589:13: warning: 'kdb_cmderror' defined but not used [-Wunused-function]
kernel/debug/kdb/kdb_main.c:1038:12: warning: 'handle_ctrl_cmd' defined but not used [-Wunused-function]
cc1: some warnings being treated as errors

vim +2839 kernel/debug/kdb/kdb_main.c
  2823		  "Display Raw Memory", 0, KDB_REPEAT_NO_ARGS);
  2824		kdb_register_repeat("mdp", kdb_md, "<paddr> <bytes>",
  2825		  "Display Physical Memory", 0, KDB_REPEAT_NO_ARGS);
  2826		kdb_register_repeat("mds", kdb_md, "<vaddr>",
  2827		  "Display Memory Symbolically", 0, KDB_REPEAT_NO_ARGS);
  2828		kdb_register_repeat("mm", kdb_mm, "<vaddr> <contents>",
  2829		  "Modify Memory Contents", 0, KDB_REPEAT_NO_ARGS);
  2830		kdb_register_repeat("go", kdb_go, "[<vaddr>]",
  2831		  "Continue Execution", 1, KDB_REPEAT_NONE);
  2832		kdb_register_repeat("rd", kdb_rd, "",
  2833		  "Display Registers", 0, KDB_REPEAT_NONE);
  2834		kdb_register_repeat("rm", kdb_rm, "<reg> <contents>",
  2835		  "Modify Registers", 0, KDB_REPEAT_NONE);
  2836		kdb_register_repeat("ef", kdb_ef, "<vaddr>",
  2837		  "Display exception frame", 0, KDB_REPEAT_NONE);
  2838		kdb_register_repeat("bt", kdb_bt, "[<vaddr>]",
> 2839		  "Stack traceback", 1, KDB_REPEAT_NONE);
  2840		kdb_register_repeat("btp", kdb_bt, "<pid>",
  2841		  "Display stack for process <pid>", 0, KDB_REPEAT_NONE);
  2842		kdb_register_repeat("bta", kdb_bt, "[DRSTCZEUIMA]",
  2843		  "Display stack all processes", 0, KDB_REPEAT_NONE);
  2844		kdb_register_repeat("btc", kdb_bt, "",
  2845		  "Backtrace current process on each cpu", 0, KDB_REPEAT_NONE);
  2846		kdb_register_repeat("btt", kdb_bt, "<vaddr>",
  2847		  "Backtrace process given its struct task address", 0,

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu, Yuanhan Liu                              Intel Corporation
