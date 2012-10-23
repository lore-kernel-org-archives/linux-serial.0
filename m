From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [tty:tty-next 17/23] drivers/staging/dgrp/dgrp_net_ops.c:229:8:
 error: 'struct tty_struct' has no member named 'read_cnt'
Date: Tue, 23 Oct 2012 10:30:54 +0800
Message-ID: <20121023023054.GI6830@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32743 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800Ab2JWCa4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Oct 2012 22:30:56 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Yuanhan Liu <yuanhan.liu@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hi Jiri,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   ecbbfd44a08fa80e0d664814efd4c187721b85f6
commit: ba2e68ac6157004ee4922fb39ebd9459bbae883e [17/23] TTY: move ldisc data from tty_struct: read_* and echo_* and canon_* stuff
config: x86_64-allmodconfig # make ARCH=x86_64 allmodconfig

All error/warnings:

drivers/staging/dgrp/dgrp_net_ops.c: In function 'dgrp_input':
drivers/staging/dgrp/dgrp_net_ops.c:216:27: error: 'struct tty_struct' has no member named 'real_raw'
drivers/staging/dgrp/dgrp_net_ops.c:229:8: error: 'struct tty_struct' has no member named 'read_cnt'
drivers/staging/dgrp/dgrp_net_ops.c:229:8: error: 'struct tty_struct' has no member named 'read_cnt'
drivers/staging/dgrp/dgrp_net_ops.c:261:30: error: 'struct tty_struct' has no member named 'real_raw'
drivers/staging/dgrp/dgrp_net_ops.c:276:28: error: 'struct tty_struct' has no member named 'real_raw'

vim +229 drivers/staging/dgrp/dgrp_net_ops.c

0b52b749 Bill Pemberton 2012-09-20  228  	/* take into consideration length of ldisc */
0b52b749 Bill Pemberton 2012-09-20 @229  	len = min(len, (N_TTY_BUF_SIZE - 1) - tty->read_cnt);

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
