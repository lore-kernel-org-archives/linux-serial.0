From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/13] TTY: ldisc, move wait idle to caller
Date: Mon, 21 Nov 2011 17:11:42 -0800
Message-ID: <1321924303-26475-12-git-send-email-gregkh@suse.de>
References: <20111122005917.GD25420@kroah.com>
 <1321924303-26475-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41974 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544Ab1KVBMt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 20:12:49 -0500
In-Reply-To: <1321924303-26475-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Dave Young <hidave.darkstar@gmail.com>, Dave Jones <davej@redhat.com>, Ben Hutchings <ben@decadent.org.uk>, Dmitriy Matrosov <sgf.dma@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

It is the only place where reinit is called from. And we really need
to wait for the old ldisc to go once. Actually this is the place where
the waiting originally was (before removed and re-added later).

This will make the fix in the following patch easier to implement.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Dave Young <hidave.darkstar@gmail.com>
Cc: Dave Jones <davej@redhat.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Dmitriy Matrosov <sgf.dma@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_ldisc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 534d176..a69a755 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -763,8 +763,6 @@ static int tty_ldisc_reinit(struct tty_struct *tty, int ldisc)
 	if (IS_ERR(ld))
 		return -1;
 
-	WARN_ON_ONCE(tty_ldisc_wait_idle(tty, 5 * HZ));
-
 	tty_ldisc_close(tty, tty->ldisc);
 	tty_ldisc_put(tty->ldisc);
 	tty->ldisc = NULL;
@@ -848,6 +846,8 @@ void tty_ldisc_hangup(struct tty_struct *tty)
 	   it means auditing a lot of other paths so this is
 	   a FIXME */
 	if (tty->ldisc) {	/* Not yet closed */
+		WARN_ON_ONCE(tty_ldisc_wait_idle(tty, 5 * HZ));
+
 		if (reset == 0) {
 
 			if (!tty_ldisc_reinit(tty, tty->termios->c_line))
-- 
1.7.7.3

