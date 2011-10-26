From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/79] TTY: ami_serial, remove BTM from wait_until_sent
Date: Wed, 26 Oct 2011 14:12:11 +0200
Message-ID: <1319631204-23262-6-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60926 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab1JZMNa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:30 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Andreas Bombe <aeb@debian.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

The same as in "TTY: serial, remove BTM from wait_until_sent" we don't
need to take BTM in wait_until_sent of ami_serial. Exactly the same
as serial, ami_serial accesses some "info" members (xmit_fifo_size,
timeout), but their assignment on other places in the code is not
protected by BTM anyway.

So the BTM protects nothing here. This removal helps us to get rid of
tty_locked() and __big_tty_mutex_owner in the following patch. This
was suggested by Arnd.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Andreas Bombe <aeb@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/amiserial.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 2205795..6d43f55 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1529,7 +1529,6 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 	struct async_struct * info = tty->driver_data;
 	unsigned long orig_jiffies, char_time;
-	int tty_was_locked = tty_locked();
 	int lsr;
 
 	if (serial_paranoia_check(info, tty->name, "rs_wait_until_sent"))
@@ -1541,12 +1540,6 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	orig_jiffies = jiffies;
 
 	/*
-	 * tty_wait_until_sent is called from lots of places,
-	 * with or without the BTM.
-	 */
-	if (!tty_was_locked)
-		tty_lock();
-	/*
 	 * Set the check interval to be 1/5 of the estimated time to
 	 * send a single character, and make it at least 1.  The check
 	 * interval should also be less than the timeout.
@@ -1586,8 +1579,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 			break;
 	}
 	__set_current_state(TASK_RUNNING);
-	if (!tty_was_locked)
-		tty_unlock();
+
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 	printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
 #endif
-- 
1.7.7

