From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [tty:tty-next 17/23] drivers/staging/dgrp/dgrp_net_ops.c:229:8:
 error: 'struct tty_struct' has no member named 'read_cnt'
Date: Sat, 27 Oct 2012 08:01:01 -0700
Message-ID: <20121027150101.GB3249@kroah.com>
References: <20121023023054.GI6830@localhost>
 <20121023105330.13d31938@pyramind.ukuu.org.uk>
 <508BD18C.4070602@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38668 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab2J0PAQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Oct 2012 11:00:16 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2524060pad.19
        for <linux-serial@vger.kernel.org>; Sat, 27 Oct 2012 08:00:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <508BD18C.4070602@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Fengguang Wu <fengguang.wu@intel.com>, Yuanhan Liu <yuanhan.liu@linux.intel.com>, linux-serial@vger.kernel.org, Bill Pemberton <wfp5p@virginia.edu>

On Sat, Oct 27, 2012 at 02:20:28PM +0200, Jiri Slaby wrote:
> On 10/23/2012 11:53 AM, Alan Cox wrote:
> > On Tue, 23 Oct 2012 10:30:54 +0800
> > Fengguang Wu <fengguang.wu@intel.com> wrote:
> > 
> >> Hi Jiri,
> >>
> >> FYI, kernel build failed on
> >>
> >> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> >> head:   ecbbfd44a08fa80e0d664814efd4c187721b85f6
> >> commit: ba2e68ac6157004ee4922fb39ebd9459bbae883e [17/23] TTY: move ldisc data from tty_struct: read_* and echo_* and canon_* stuff
> >> config: x86_64-allmodconfig # make ARCH=x86_64 allmodconfig
> >>
> >> All error/warnings:
> >>
> >> drivers/staging/dgrp/dgrp_net_ops.c: In function 'dgrp_input':
> >> drivers/staging/dgrp/dgrp_net_ops.c:216:27: error: 'struct tty_struct' has no member named 'real_raw'
> >> drivers/staging/dgrp/dgrp_net_ops.c:229:8: error: 'struct tty_struct' has no member named 'read_cnt'
> >> drivers/staging/dgrp/dgrp_net_ops.c:229:8: error: 'struct tty_struct' has no member named 'read_cnt'
> >> drivers/staging/dgrp/dgrp_net_ops.c:261:30: error: 'struct tty_struct' has no member named 'real_raw'
> >> drivers/staging/dgrp/dgrp_net_ops.c:276:28: error: 'struct tty_struct' has no member named 'real_raw'
> >>
> >> vim +229 drivers/staging/dgrp/dgrp_net_ops.c
> >>
> >> 0b52b749 Bill Pemberton 2012-09-20  228  	/* take into consideration length of ldisc */
> >> 0b52b749 Bill Pemberton 2012-09-20 @229  	len = min(len, (N_TTY_BUF_SIZE - 1) - tty->read_cnt);
> > 
> > This is broken and unsafe. It's always been broken and unsafe. Probably
> > the report wants directing to whoever signed up to fix it all in staging.
> 
> And that function looks strange alltogether. It's like it's trying to
> optimize in case of raw TTY by sending the data directly to ldisc. In a
> completely racy way. I think that it should remain marked as BROKEN
> until this is converted to tty_prepare_flip_string.

That code has been ripped out of the driver now, and it builds fine in
my tree, so the BROKEN marking linux-next can be removed.

thanks,

greg k-h
