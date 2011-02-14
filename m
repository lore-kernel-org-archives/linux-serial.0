From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 6/6] hci_ath: Fix the mess in this driver
Date: Mon, 14 Feb 2011 16:28:18 +0000
Message-ID: <20110214162803.10571.55396.stgit@bob.linux.org.uk>
References: <20110214162438.10571.8203.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110214162438.10571.8203.stgit@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Was this exploitable - who knows, but it was certainly totally broken

Signed-of-by: Alan Cox <alan@linux.intel.com>
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
