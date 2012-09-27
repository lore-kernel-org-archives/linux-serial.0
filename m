From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [tty:tty-next 36/40] kernel/debug/kdb/kdb_main.c:2839:4:
 warning: passing argument 2 of 'kdb_register_repeat' from incompatible
 pointer type
Date: Thu, 27 Sep 2012 10:36:47 +0800
Message-ID: <20120927023647.GA12399@localhost>
References: <20120927012916.GA9207@localhost>
 <20120927013930.GA27336@lizard>
 <20120927021119.GA29097@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55341 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461Ab2I0Cgx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 22:36:53 -0400
Content-Disposition: inline
In-Reply-To: <20120927021119.GA29097@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Yuanhan Liu <yuanhan.liu@intel.com>, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>

On Wed, Sep 26, 2012 at 07:11:19PM -0700, Anton Vorontsov wrote:
> On Wed, Sep 26, 2012 at 06:39:32PM -0700, Anton Vorontsov wrote:
> > On Thu, Sep 27, 2012 at 09:29:16AM +0800, Fengguang Wu wrote:
> > > FYI, there are new compile warnings show up in
> > > 
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> > > head:   0c57dfcc6c1d037243c2f8fbf62eab3633326ec0
> > > commit: 729043e82cdd403a131127254528afea8031ebab [36/40] kdb: Turn KGDB_KDB=n stubs into static inlines
> > > config: cris-allyesconfig
> > > 
> > > All warnings (together with lots of *old* errors):
> > 
> > As we switched from empty macros to proper type-checking functions, the
> > new warnings most probably are all OK, but just to be sure...
> > 
> > Which are the new warnings? Do you have old build logs to compare?
> 
> I guess these are the new ones:
> 
> > > kernel/debug/kdb/kdb_main.c:2839:4: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]
> > > kernel/debug/kdb/kdb_main.c:2696:5: note: expected 'kdb_func_t' but argument is of type 'struct kdbmsg_t *'
> > > kernel/debug/kdb/kdb_main.c:2841:4: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]
> 
> They're all OK. Before my patch, kgdb_register_repeat() was an empty
> macro. But since we now do proper functions, the new warnings pop up.

Yes.

> Also, there's something interesting:
> 
> > > kernel/debug/kdb/kdb_main.c:2696:5: error: redefinition of 'kdb_register_repeat'
> > > include/linux/kdb.h:156:19: note: previous definition of 'kdb_register_repeat' was here
> 
> This means that we're trying to build KDB, but kdb.h don't see
> CONFIG_KGDB_KDB.
> 
> More over, 'make ARCH=cris allyesconfig' producing .config with KGDB=n
> and KGDB_KDB=n. And criss doesn't select HAVE_ARCH_KGDB.
 
It's true.

> I suspect there are some toolchain issues, or arch/cris/ does something
> weird with the build system.

Ah silly me! I'm doing "make M=kernel/debug/kdb" which leads to all
the error/warnings. This can be fixed trivially. :)

> Also, "arch/cris/arch-v32/kernel/kgdb.c" -- it seems like it is its own
> implementation of KGDB. :-) But it's CONFIG_ETRAX_KGDB...

Doing the regular 'make' triggers these errors:

arch/cris/arch-v10/kernel/kgdb.c:1273:6: warning: missing terminating " character [enabled by default]
arch/cris/arch-v10/kernel/kgdb.c:1273:1: error: missing terminating " character
arch/cris/arch-v10/kernel/kgdb.c:1274:3: error: expected string literal before '.' token
arch/cris/arch-v10/kernel/kgdb.c:1359:1: warning: missing terminating " character [enabled by default]
arch/cris/arch-v10/kernel/kgdb.c:1359:1: error: missing terminating " character
arch/cris/arch-v10/kernel/kgdb.c:1370:6: warning: missing terminating " character [enabled by default]
arch/cris/arch-v10/kernel/kgdb.c:1370:1: error: missing terminating " character
arch/cris/arch-v10/kernel/kgdb.c:1457:1: warning: missing terminating " character [enabled by default]
arch/cris/arch-v10/kernel/kgdb.c:1457:1: error: missing terminating " character
arch/cris/arch-v10/kernel/kgdb.c:508:1: warning: 'copy_registers' defined but not used [-Wunused-function]
arch/cris/arch-v10/kernel/kgdb.c:255:13: warning: 'copy_registers_from_stack' declared 'static' but never defined [-Wunused-function]
arch/cris/arch-v10/kernel/kgdb.c:259:13: warning: 'copy_registers_to_stack' declared 'static' but never defined [-Wunused-function]
arch/cris/arch-v10/kernel/kgdb.c:267:12: warning: 'write_stack_register' declared 'static' but never defined [-Wunused-function]
arch/cris/arch-v10/kernel/kgdb.c:924:1: warning: 'handle_exception' defined but not used [-Wunused-function]
arch/cris/arch-v10/kernel/kgdb.c:425:12: warning: 'current_thread_c' defined but not used [-Wunused-variable]
arch/cris/arch-v10/kernel/kgdb.c:426:12: warning: 'current_thread_g' defined but not used [-Wunused-variable]
arch/cris/arch-v10/kernel/kgdb.c:430:18: warning: 'reg_g' defined but not used [-Wunused-variable]
arch/cris/arch-v10/kernel/kgdb.c:442:22: warning: 'is_dyn_brkp' defined but not used [-Wunused-variable]
arch/cris/arch-v10/kernel/kgdb.c:679:12: warning: 'do_printk' defined but not used [-Wunused-variable]
make[2]: *** [arch/cris/arch-v10/kernel/kgdb.o] Error 1

> So, I don't even think KGDB/KDB should be fixed anyhow, since cris doesn't
> select HAVE_ARCH_KGDB, thus 'depends on !CRIS' doesn't make sense.

OK. Sorry for the noises!

Thanks,
Fengguang
