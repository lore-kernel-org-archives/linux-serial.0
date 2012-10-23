From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [tty:tty-next 15/23] drivers/staging/dgrp/dgrp_net_ops.c:216:27:
 error: 'struct tty_struct' has no member named 'real_raw'
Date: Tue, 23 Oct 2012 10:25:45 +0800
Message-ID: <20121023022545.GG6830@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36162 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756472Ab2JWCZs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Oct 2012 22:25:48 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Yuanhan Liu <yuanhan.liu@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hi Jiri,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   ecbbfd44a08fa80e0d664814efd4c187721b85f6
commit: 53c5ee2cfb4dadc4f5c24fe671e2fbfc034c875e [15/23] TTY: move ldisc data from tty_struct: simple members
config: x86_64-allmodconfig # make ARCH=x86_64 allmodconfig

All error/warnings:

drivers/staging/dgrp/dgrp_net_ops.c: In function 'dgrp_input':
drivers/staging/dgrp/dgrp_net_ops.c:216:27: error: 'struct tty_struct' has no member named 'real_raw'
drivers/staging/dgrp/dgrp_net_ops.c:261:30: error: 'struct tty_struct' has no member named 'real_raw'
drivers/staging/dgrp/dgrp_net_ops.c:276:28: error: 'struct tty_struct' has no member named 'real_raw'

vim +216 drivers/staging/dgrp/dgrp_net_ops.c

0b52b749 Bill Pemberton 2012-09-20  215  	/* Decide how much data we can send into the tty layer */
0b52b749 Bill Pemberton 2012-09-20 @216  	if (dgrp_rawreadok && tty->real_raw)
0b52b749 Bill Pemberton 2012-09-20  217  		flip_len = MYFLIPLEN;
0b52b749 Bill Pemberton 2012-09-20  218  	else
0b52b749 Bill Pemberton 2012-09-20  219  		flip_len = TTY_FLIPBUF_SIZE;

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
