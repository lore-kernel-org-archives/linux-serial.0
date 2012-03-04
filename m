From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: [PATCH 6/9] tty : don't use receive_room in tty_set_ldisc
Date: Sun,  4 Mar 2012 18:59:17 +0100
Message-ID: <1330883960-8563-7-git-send-email-castet.matthieu@free.fr>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44684 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab2CDSAC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 13:00:02 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm2so1507636wib.19
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 10:00:01 -0800 (PST)
In-Reply-To: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
---
 drivers/tty/n_tty.c      |    1 +
 drivers/tty/tty_buffer.c |    5 +++++
 drivers/tty/tty_ldisc.c  |    7 -------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ed5a976..5ef5a22 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -190,6 +190,7 @@ static void reset_buffer_flags(struct tty_struct *tty)
 
 	tty->canon_head = tty->canon_data = tty->erasing = 0;
 	memset(&tty->read_flags, 0, sizeof tty->read_flags);
+	tty->receive_room = 0;
 	n_tty_set_room(tty);
 }
 
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 6c9b7cd..0e0f0fa 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -432,6 +432,11 @@ static void flush_to_ldisc(struct work_struct *work)
 			   line discipline as we want to empty the queue */
 			if (test_bit(TTY_FLUSHPENDING, &tty->flags))
 				break;
+			/*
+			 *	No more input please, we are switching.
+			 */
+			if (test_bit(TTY_LDISC_CHANGING, &tty->flags))
+				break;
 			if (!tty->receive_room)
 				break;
 			if (count > tty->receive_room)
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 24b95db..ab0a180 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -613,13 +613,6 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	set_bit(TTY_LDISC_CHANGING, &tty->flags);
 
-	/*
-	 *	No more input please, we are switching. The new ldisc
-	 *	will update this value in the ldisc open function
-	 */
-
-	tty->receive_room = 0;
-
 	o_ldisc = tty->ldisc;
 
 	tty_unlock();
-- 
1.7.9.1

