From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 01/24] tty: Don't change receive_room for ioctl(TIOCSETD)
Date: Mon, 15 Apr 2013 11:19:05 -0400
Message-ID: <1366039168-8510-2-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:44705 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab3DOPTx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Apr 2013 11:19:53 -0400
In-Reply-To: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

tty_set_ldisc() is guaranteed exclusive use of the line discipline
by tty_ldisc_lock_pair_timeout(); shutting off input by resetting
receive_room is unnecessary.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index ba49c0e..5a6c43d 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -537,9 +537,6 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 		return 0;
 	}
 
-	/* FIXME: why 'shutoff' input if the ldisc is locked? */
-	tty->receive_room = 0;
-
 	old_ldisc = tty->ldisc;
 	tty_lock(tty);
 
-- 
1.8.1.2

