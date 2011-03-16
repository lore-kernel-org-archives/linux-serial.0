From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 40/76] hci_ath: Fix the mess in this driver
Date: Wed, 16 Mar 2011 14:12:10 -0700
Message-ID: <1300309966-5745-40-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33047 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754801Ab1CPVON (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:13 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Alan Cox <alan@linux.intel.com>

Was this exploitable - who knows, but it was certainly totally broken

Signed-of-by: Alan Cox <alan@linux.intel.com>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/bluetooth/hci_ath.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 6a160c1..bd34406 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -51,32 +51,32 @@ struct ath_struct {
 
 static int ath_wakeup_ar3k(struct tty_struct *tty)
 {
-	struct termios settings;
-	int status = tty->driver->ops->tiocmget(tty, NULL);
+	struct ktermios ktermios;
+	int status = tty->driver->ops->tiocmget(tty);
 
 	if (status & TIOCM_CTS)
 		return status;
 
 	/* Disable Automatic RTSCTS */
-	n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
-	settings.c_cflag &= ~CRTSCTS;
-	n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
+	memcpy(&ktermios, tty->termios, sizeof(ktermios));
+	ktermios.c_cflag &= ~CRTSCTS;
+	tty_set_termios(tty, &ktermios);
 
 	/* Clear RTS first */
-	status = tty->driver->ops->tiocmget(tty, NULL);
-	tty->driver->ops->tiocmset(tty, NULL, 0x00, TIOCM_RTS);
+	status = tty->driver->ops->tiocmget(tty);
+	tty->driver->ops->tiocmset(tty, 0x00, TIOCM_RTS);
 	mdelay(20);
 
 	/* Set RTS, wake up board */
-	status = tty->driver->ops->tiocmget(tty, NULL);
-	tty->driver->ops->tiocmset(tty, NULL, TIOCM_RTS, 0x00);
+	status = tty->driver->ops->tiocmget(tty);
+	tty->driver->ops->tiocmset(tty, TIOCM_RTS, 0x00);
 	mdelay(20);
 
-	status = tty->driver->ops->tiocmget(tty, NULL);
+	status = tty->driver->ops->tiocmget(tty);
 
-	n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
-	settings.c_cflag |= CRTSCTS;
-	n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
+	/* Disable Automatic RTSCTS */
+	ktermios.c_cflag |= CRTSCTS;
+	status = tty_set_termios(tty, &ktermios);
 
 	return status;
 }
-- 
1.7.4.1

