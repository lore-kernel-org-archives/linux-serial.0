From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [tty:tty-next 9/39] drivers/staging/dgrp/dgrp_tty.c:3177
 dgrp_tty_init() error: potential null dereference 'nd->nd_serial_ttdriver'.
Date: Sun, 7 Oct 2012 20:35:49 +0800
Message-ID: <20121007123549.GA24374@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30547 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab2JGMfy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 7 Oct 2012 08:35:54 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hi Bill,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   0c57dfcc6c1d037243c2f8fbf62eab3633326ec0
commit: 7b6d45c211a401a9bdeebfa96f8a4c811bd3eeaf [9/39] staging: dgrp: add dgrp to the build

It seems that the dgrp_dpa_ops.c ones are false warnings, while the
'potential null deference' ones are worth looking at.

+ drivers/staging/dgrp/dgrp_dpa_ops.c:377 dgrp_dpa_ioctl() warn: 'vpd' puts 516 bytes on stack
--
+ drivers/staging/dgrp/dgrp_net_ops.c:277 dgrp_input() error: we previously assumed 'ld' could be null (see line 238)
+ drivers/staging/dgrp/dgrp_net_ops.c:3159 dgrp_receive() error: strncpy() 'nd->nd_ps_desc' too small (101 vs 988)
+ drivers/staging/dgrp/dgrp_net_ops.c:3160 dgrp_receive() error: buffer overflow 'nd->nd_ps_desc' 101 <= 988
--
+ drivers/staging/dgrp/dgrp_specproc.c:273 register_proc_table() error: we previously assumed 'table->child' could be null (see line 263)
--
+ drivers/staging/dgrp/dgrp_tty.c:2341 dgrp_set_custom_speed() info: ignoring unreachable code.
+ drivers/staging/dgrp/dgrp_tty.c:3177 dgrp_tty_init() error: potential null dereference 'nd->nd_serial_ttdriver'.  (alloc_tty_driver returns null)
+ drivers/staging/dgrp/dgrp_tty.c:3236 dgrp_tty_init() error: potential null dereference 'nd->nd_callout_ttdriver'.  (alloc_tty_driver returns null)
+ drivers/staging/dgrp/dgrp_tty.c:3273 dgrp_tty_init() error: potential null dereference 'nd->nd_xprint_ttdriver'.  (alloc_tty_driver returns null)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
