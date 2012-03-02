From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [RFC PATCH 0/7] serial: cleanups that strive to do nothing
Date: Thu,  1 Mar 2012 21:33:16 -0500
Message-ID: <1330655603-5268-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63476 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab2CBCdj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Mar 2012 21:33:39 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

Yes, that may sound stupid, but when dealing with 20+ year old
hardware, you really do not want to change any runtime behaviour.

To that end, these cleanups are things I spotted when doing the
freescale errata addition and figured I could deal with in a way
that was "inert" to the serial and 8250 users at large.

I've stared at the changes to convince myself that they really
don't change the compiled code (and even cheated by diffing the
assembly), and I've tested with serial console on a headless turd
that is ~10 years old and not seen any sort of regressions.  But
please report if you see any problems in this patch set.  I intend
on testing on a few !x86 arch in the next few days myself.

Thanks,
P.
---

Paul Gortmaker (7):
  serial: delete last unused traces of pausing I/O in 8250
  serial: make 8250's serial_in shareable to other drivers.
  serial: delete useless void casts in 8250.c
  serial: reduce number of indirections in 8250 code
  serial: remove back and forth conversions in serial_out_sync
  serial: introduce generic port in/out helpers
  serial: use serial_port_in/out vs serial_in/out in 8250

 drivers/tty/serial/8250/8250.c |  724 ++++++++++++++++++++--------------------
 drivers/tty/serial/8250/8250.h |   10 +
 include/linux/serial_core.h    |   10 +
 3 files changed, 381 insertions(+), 363 deletions(-)

-- 
1.7.9.1

