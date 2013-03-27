From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 01/18] tty: Don't change receive_room for ioctl(TIOCSETD)
Date: Wed, 27 Mar 2013 07:43:51 -0400
Message-ID: <1364384648-6636-2-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1364384648-6636-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:54239 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab3C0Log (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Mar 2013 07:44:36 -0400
In-Reply-To: <1364384648-6636-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Min Zhang <mzhang@mvista.com>, Ilya Zykov <linux@izyk.ru>, Peter Hurley <peter@hurleysoftware.com>

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

