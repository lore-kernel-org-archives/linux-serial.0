From: wfp5p@viridian.itc.virginia.edu (Bill Pemberton)
Subject: Re: [tty:tty-next 9/39] drivers/staging/dgrp/dgrp_tty.c:3177
Date: Tue, 09 Oct 2012 12:46:48 -0400
Message-ID: <20121009164648.84EB2801A1@viridian.itc.virginia.edu>
References: <20121007123549.GA24374@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:34569 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab2JIQyw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Oct 2012 12:54:52 -0400
In-Reply-To: <20121007123549.GA24374@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Fengguang Wu writes:
> 
> Hi Bill,
> 
> FYI, there are new smatch warnings show up in
>
> + drivers/staging/dgrp/dgrp_net_ops.c:277 dgrp_input() error: we previously assumed 'ld' could be null (see line 238)

This one looks fine, if ld is NULL then len is set to 0.  ld is then
only dereferenced if len != 0

> --
> + drivers/staging/dgrp/dgrp_specproc.c:273 register_proc_table() error: we previously assumed 'table->child' could be null (see line 263)

It seems weird where smatch is seeing the NULL test vs. the call to
register_proc_table(), but it is correct that register_proc_table will
do bad things if the first arg is a NULL.  I'll submit a patch for it.

> --
> + drivers/staging/dgrp/dgrp_tty.c:3177 dgrp_tty_init() error: potential null dereference 'nd->nd_serial_ttdriver'.  (alloc_tty_driver returns null)
> + drivers/staging/dgrp/dgrp_tty.c:3236 dgrp_tty_init() error: potential null dereference 'nd->nd_callout_ttdriver'.  (alloc_tty_driver returns null)
> + drivers/staging/dgrp/dgrp_tty.c:3273 dgrp_tty_init() error: potential null dereference 'nd->nd_xprint_ttdriver'.  (alloc_tty_driver returns null)
> 

Yes, the return value of alloc_tty_driver needs to be checked.  I'll
fix these.

-- 
Bill
