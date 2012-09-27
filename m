From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [tty:tty-next 36/40] kernel/debug/kdb/kdb_main.c:2839:4:
 warning: passing argument 2 of 'kdb_register_repeat' from incompatible
 pointer type
Date: Thu, 27 Sep 2012 10:01:44 +0800
Message-ID: <20120927020144.GA10674@localhost>
References: <20120927012916.GA9207@localhost>
 <20120927013930.GA27336@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15820 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575Ab2I0CBx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 22:01:53 -0400
Content-Disposition: inline
In-Reply-To: <20120927013930.GA27336@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Yuanhan Liu <yuanhan.liu@intel.com>, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>

On Wed, Sep 26, 2012 at 06:39:33PM -0700, Anton Vorontsov wrote:
> On Thu, Sep 27, 2012 at 09:29:16AM +0800, Fengguang Wu wrote:
> > FYI, there are new compile warnings show up in
> > 
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> > head:   0c57dfcc6c1d037243c2f8fbf62eab3633326ec0
> > commit: 729043e82cdd403a131127254528afea8031ebab [36/40] kdb: Turn KGDB_KDB=n stubs into static inlines
> > config: cris-allyesconfig
> > 
> > All warnings (together with lots of *old* errors):
> 
> As we switched from empty macros to proper type-checking functions, the
> new warnings most probably are all OK, but just to be sure...

OK.

> Which are the new warnings? Do you have old build logs to compare?

Here are the new warnings that show up in the tty-next HEAD. I'm not
sure it's worth looking into though (they are probably mostly side
effects created by the undefined macros errors). The x86 builds are
clean.

kernel/debug/kdb/kdb_bp.c:484:1: warning: control reaches end of non-void function [-Wreturn-type]
kernel/debug/kdb/kdb_bt.c:126:6: warning: assignment makes pointer from integer without a cast [enabled by default]
kernel/debug/kdb/kdb_bt.c:179:4: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'int' [-Wformat]
kernel/debug/kdb/kdb_debugger.c:23:2: warning: initialization makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_debugger.c:23:2: warning: (near initialization for 'kdb_poll_funcs[0]') [enabled by default]
kernel/debug/kdb/kdb_io.c:62:10: warning: comparison between pointer and integer [enabled by default]
kernel/debug/kdb/kdb_main.c:991:10: warning: assignment makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1091:20: warning: assignment makes pointer from integer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:958:25: warning: comparison between pointer and integer [enabled by default]
kernel/debug/kdb/kdb_main.c:1972:2: warning: comparison of distinct pointer types lacks a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1785:5: warning: "DBG_MAX_REG_NUM" is not defined [-Wundef]
kernel/debug/kdb/kdb_main.c:2276:8: warning: format '%p' expects argument of type 'void *', but argument 2 has type 'int' [-Wformat]
kernel/debug/kdb/kdb_main.c:2905:5: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'kdbmsg_t' [-Wformat]
kernel/debug/kdb/kdb_main.c:2431:8: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct kdbmsg_t *' [-Wformat]
kernel/debug/kdb/kdb_main.c:1972:2: warning: initialization from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:1515:46: warning: initialization makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:2839:4: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:658:2: warning: passing argument 2 of 'kdb_strdup' makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1031:3: warning: passing argument 3 of 'kdb_symbol_print' makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:685:9: warning: passing argument 2 of 'kmalloc' makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:650:2: warning: passing argument 2 of 'kzalloc' makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:966:4: warning: passing argument 2 of 'strcmp' from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:981:10: warning: passing argument 1 of 'strlen' from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:961:10: warning: passing argument 2 of 'strncmp' from incompatible pointer type [enabled by default]
kernel/debug/kdb/kdb_main.c:961:10: warning: passing argument 3 of 'strncmp' makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1723:42: warning: pointer/integer type mismatch in conditional expression [enabled by default]
kernel/debug/kdb/kdb_main.c:267:3: warning: return makes integer from pointer without a cast [enabled by default]
kernel/debug/kdb/kdb_main.c:1079:2: warning: statement with no effect [-Wunused-value]
kernel/debug/kdb/kdb_main.c:2224:9: warning: unused variable 'mask_M' [-Wunused-variable]
kernel/debug/kdb/kdb_support.c:96:7: warning: assignment makes pointer from integer without a cast [enabled by default]
kernel/debug/kdb/kdb_support.c:803:6: warning: conflicting types for 'debug_kfree' [enabled by default]

> And KDB is (and was) obviously broken for cris, should we disable it via
> Kconfig?

That would be great for me! Otherwise the build system will probably
see old/new problems popping up from time to time in this code.

Thanks,
Fengguang
