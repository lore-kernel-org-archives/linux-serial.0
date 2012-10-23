From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [tty:tty-next 17/23] drivers/staging/dgrp/dgrp_net_ops.c:229:8:
 error: 'struct tty_struct' has no member named 'read_cnt'
Date: Tue, 23 Oct 2012 18:00:40 +0800
Message-ID: <20121023100040.GA9888@localhost>
References: <20121023023054.GI6830@localhost>
 <20121023105330.13d31938@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63454 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756703Ab2JWKAt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 06:00:49 -0400
Content-Disposition: inline
In-Reply-To: <20121023105330.13d31938@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Pemberton <wfp5p@virginia.edu>, Jiri Slaby <jslaby@suse.cz>, Yuanhan Liu <yuanhan.liu@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Tue, Oct 23, 2012 at 10:53:30AM +0100, Alan Cox wrote:
> On Tue, 23 Oct 2012 10:30:54 +0800
> Fengguang Wu <fengguang.wu@intel.com> wrote:
> 
> > Hi Jiri,
> > 
> > FYI, kernel build failed on
> > 
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> > head:   ecbbfd44a08fa80e0d664814efd4c187721b85f6
> > commit: ba2e68ac6157004ee4922fb39ebd9459bbae883e [17/23] TTY: move ldisc data from tty_struct: read_* and echo_* and canon_* stuff
> > config: x86_64-allmodconfig # make ARCH=x86_64 allmodconfig
> > 
> > All error/warnings:
> > 
> > drivers/staging/dgrp/dgrp_net_ops.c: In function 'dgrp_input':
> > drivers/staging/dgrp/dgrp_net_ops.c:216:27: error: 'struct tty_struct' has no member named 'real_raw'
> > drivers/staging/dgrp/dgrp_net_ops.c:229:8: error: 'struct tty_struct' has no member named 'read_cnt'
> > drivers/staging/dgrp/dgrp_net_ops.c:229:8: error: 'struct tty_struct' has no member named 'read_cnt'
> > drivers/staging/dgrp/dgrp_net_ops.c:261:30: error: 'struct tty_struct' has no member named 'real_raw'
> > drivers/staging/dgrp/dgrp_net_ops.c:276:28: error: 'struct tty_struct' has no member named 'real_raw'
> > 
> > vim +229 drivers/staging/dgrp/dgrp_net_ops.c
> > 
> > 0b52b749 Bill Pemberton 2012-09-20  228  	/* take into consideration length of ldisc */
> > 0b52b749 Bill Pemberton 2012-09-20 @229  	len = min(len, (N_TTY_BUF_SIZE - 1) - tty->read_cnt);
> 
> This is broken and unsafe. It's always been broken and unsafe. Probably
> the report wants directing to whoever signed up to fix it all in staging.

Add CC to Bill. Alan, thanks for the suggestion!

As for the build system, it perhaps can hardly be more smart than
notifying the contacts for the commit that *directly* triggered the
build errors (bisected first bad commit is not necessary the root
cause). It relies on the CCed developers to figure out the real
problem and if necessary, add more CC list.

Thanks,
Fengguang
