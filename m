From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [tty:tty-next 15/23] drivers/staging/dgrp/dgrp_net_ops.c:216:27:
 error: 'struct tty_struct' has no member named 'real_raw'
Date: Tue, 23 Oct 2012 11:54:59 +0800
Message-ID: <20121023035459.GA21181@localhost>
References: <20121023022545.GG6830@localhost>
 <20121023030543.GB22018@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:58113 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755308Ab2JWDzM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Oct 2012 23:55:12 -0400
Content-Disposition: inline
In-Reply-To: <20121023030543.GB22018@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Yuanhan Liu <yuanhan.liu@linux.intel.com>, linux-serial@vger.kernel.org

On Mon, Oct 22, 2012 at 08:05:43PM -0700, Greg KH wrote:
> On Tue, Oct 23, 2012 at 10:25:45AM +0800, Fengguang Wu wrote:
> > Hi Jiri,
> > 
> > FYI, kernel build failed on
> > 
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> > head:   ecbbfd44a08fa80e0d664814efd4c187721b85f6
> > commit: 53c5ee2cfb4dadc4f5c24fe671e2fbfc034c875e [15/23] TTY: move ldisc data from tty_struct: simple members
> > config: x86_64-allmodconfig # make ARCH=x86_64 allmodconfig
> > 
> > All error/warnings:
> > 
> > drivers/staging/dgrp/dgrp_net_ops.c: In function 'dgrp_input':
> > drivers/staging/dgrp/dgrp_net_ops.c:216:27: error: 'struct tty_struct' has no member named 'real_raw'
> > drivers/staging/dgrp/dgrp_net_ops.c:261:30: error: 'struct tty_struct' has no member named 'real_raw'
> > drivers/staging/dgrp/dgrp_net_ops.c:276:28: error: 'struct tty_struct' has no member named 'real_raw'
> > 
> > vim +216 drivers/staging/dgrp/dgrp_net_ops.c
> > 
> > 0b52b749 Bill Pemberton 2012-09-20  215  	/* Decide how much data we can send into the tty layer */
> > 0b52b749 Bill Pemberton 2012-09-20 @216  	if (dgrp_rawreadok && tty->real_raw)
> > 0b52b749 Bill Pemberton 2012-09-20  217  		flip_len = MYFLIPLEN;
> > 0b52b749 Bill Pemberton 2012-09-20  218  	else
> > 0b52b749 Bill Pemberton 2012-09-20  219  		flip_len = TTY_FLIPBUF_SIZE;
> 
> 
> Thanks for this, and the other report, I already pointed them out to
> Jiri and hopefully will get a patch from him when he returns from the
> openSUSE conference.

OK, thanks for the info. BTW, expect another related error:

arch/um/drivers/chan_kern.c:89:42: error: 'struct tty_struct' has no member named 'raw'

Thanks,
Fengguang
