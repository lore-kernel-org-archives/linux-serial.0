From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/13] TTY: ldisc, allow waiting for ldisc arbitrarily long
Date: Mon, 21 Nov 2011 17:11:41 -0800
Message-ID: <1321924303-26475-11-git-send-email-gregkh@suse.de>
References: <20111122005917.GD25420@kroah.com>
 <1321924303-26475-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544Ab1KVBMq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 20:12:46 -0500
In-Reply-To: <1321924303-26475-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Dave Young <hidave.darkstar@gmail.com>, Dave Jones <davej@redhat.com>, Ben Hutchings <ben@decadent.org.uk>, Dmitriy Matrosov <sgf.dma@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

To fix a nasty bug in ldisc hup vs. reinit we need to wait infinitely
long for ldisc to be gone. So here we add a parameter to
tty_ldisc_wait_idle to allow that.

This is only a preparation for the real fix which is done in the
following patches.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Dave Young <hidave.darkstar@gmail.com>
Cc: Dave Jones <davej@redhat.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Dmitriy Matrosov <sgf.dma@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_ldisc.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 512c49f..534d176 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -547,15 +547,16 @@ static void tty_ldisc_flush_works(struct tty_struct *tty)
 /**
  *	tty_ldisc_wait_idle	-	wait for the ldisc to become idle
  *	@tty: tty to wait for
+ *	@timeout: for how long to wait at most
  *
  *	Wait for the line discipline to become idle. The discipline must
  *	have been halted for this to guarantee it remains idle.
  */
-static int tty_ldisc_wait_idle(struct tty_struct *tty)
+static int tty_ldisc_wait_idle(struct tty_struct *tty, long timeout)
 {
-	int ret;
+	long ret;
 	ret = wait_event_timeout(tty_ldisc_idle,
-			atomic_read(&tty->ldisc->users) == 1, 5 * HZ);
+			atomic_read(&tty->ldisc->users) == 1, timeout);
 	if (ret < 0)
 		return ret;
 	return ret > 0 ? 0 : -EBUSY;
@@ -665,7 +666,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	tty_ldisc_flush_works(tty);
 
-	retval = tty_ldisc_wait_idle(tty);
+	retval = tty_ldisc_wait_idle(tty, 5 * HZ);
 
 	tty_lock();
 	mutex_lock(&tty->ldisc_mutex);
@@ -762,7 +763,7 @@ static int tty_ldisc_reinit(struct tty_struct *tty, int ldisc)
 	if (IS_ERR(ld))
 		return -1;
 
-	WARN_ON_ONCE(tty_ldisc_wait_idle(tty));
+	WARN_ON_ONCE(tty_ldisc_wait_idle(tty, 5 * HZ));
 
 	tty_ldisc_close(tty, tty->ldisc);
 	tty_ldisc_put(tty->ldisc);
-- 
1.7.7.3

