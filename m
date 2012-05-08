From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] cris: fix missing tty arg in wait_event_interruptible_tty call
Date: Tue,  8 May 2012 11:17:55 -0400
Message-ID: <1336490275-17592-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34571 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297Ab2EHPSU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 May 2012 11:18:20 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-cris-kernel@axis.com, Paul Gortmaker <paul.gortmaker@windriver.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Commit d29f3ef39be4eec0362b985305fc526d9be318cf

    "tty_lock: Localise the lock"

added a tty arg to wait_event_interruptible_tty() but it missed
this arch specific instance for cris, causing a compile failure.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index b431a51..7264d4d 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3976,7 +3976,7 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 	 */
 	if (tty_hung_up_p(filp) ||
 	    (info->flags & ASYNC_CLOSING)) {
-		wait_event_interruptible_tty(info->close_wait,
+		wait_event_interruptible_tty(tty, info->close_wait,
 			!(info->flags & ASYNC_CLOSING));
 #ifdef SERIAL_DO_RESTART
 		if (info->flags & ASYNC_HUP_NOTIFY)
@@ -4115,7 +4115,7 @@ rs_open(struct tty_struct *tty, struct file * filp)
 	 */
 	if (tty_hung_up_p(filp) ||
 	    (info->flags & ASYNC_CLOSING)) {
-		wait_event_interruptible_tty(info->close_wait,
+		wait_event_interruptible_tty(tty, info->close_wait,
 			!(info->flags & ASYNC_CLOSING));
 #ifdef SERIAL_DO_RESTART
 		return ((info->flags & ASYNC_HUP_NOTIFY) ?
-- 
1.7.9.1

