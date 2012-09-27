From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [tty:tty-next 36/40] kernel/debug/kdb/kdb_main.c:2839:4:
 warning: passing argument 2 of 'kdb_register_repeat' from incompatible
 pointer type
Date: Wed, 26 Sep 2012 19:11:19 -0700
Message-ID: <20120927021119.GA29097@lizard>
References: <20120927012916.GA9207@localhost>
 <20120927013930.GA27336@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51749 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab2I0CON (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 22:14:13 -0400
Received: by padhz1 with SMTP id hz1so916398pad.19
        for <linux-serial@vger.kernel.org>; Wed, 26 Sep 2012 19:14:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120927013930.GA27336@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Yuanhan Liu <yuanhan.liu@intel.com>, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>

On Wed, Sep 26, 2012 at 06:39:32PM -0700, Anton Vorontsov wrote:
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
> 
> Which are the new warnings? Do you have old build logs to compare?

I guess these are the new ones:

> > kernel/debug/kdb/kdb_main.c:2839:4: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]
> > kernel/debug/kdb/kdb_main.c:2696:5: note: expected 'kdb_func_t' but argument is of type 'struct kdbmsg_t *'
> > kernel/debug/kdb/kdb_main.c:2841:4: warning: passing argument 2 of 'kdb_register_repeat' from incompatible pointer type [enabled by default]

They're all OK. Before my patch, kgdb_register_repeat() was an empty
macro. But since we now do proper functions, the new warnings pop up.

Also, there's something interesting:

> > kernel/debug/kdb/kdb_main.c:2696:5: error: redefinition of 'kdb_register_repeat'
> > include/linux/kdb.h:156:19: note: previous definition of 'kdb_register_repeat' was here

This means that we're trying to build KDB, but kdb.h don't see
CONFIG_KGDB_KDB.

More over, 'make ARCH=cris allyesconfig' producing .config with KGDB=n
and KGDB_KDB=n. And criss doesn't select HAVE_ARCH_KGDB.

I suspect there are some toolchain issues, or arch/cris/ does something
weird with the build system.

Also, "arch/cris/arch-v32/kernel/kgdb.c" -- it seems like it is its own
implementation of KGDB. :-) But it's CONFIG_ETRAX_KGDB...

So, I don't even think KGDB/KDB should be fixed anyhow, since cris doesn't
select HAVE_ARCH_KGDB, thus 'depends on !CRIS' doesn't make sense.

Thanks,
Anton.
