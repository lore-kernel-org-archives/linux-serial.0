From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 05/12] usb, kobil: Sort out some bogus tty handling
Date: Wed, 27 Jun 2012 12:21:54 +0100
Message-ID: <20120627112152.5678.49318.stgit@localhost.localdomain>
References: <20120627112102.5678.4141.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46081 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab2F0LFx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Jun 2012 07:05:53 -0400
In-Reply-To: <20120627112102.5678.4141.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Stuff noticed while doing the termios conversion.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/usb/serial/kobil_sct.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index fafeabb..0852472 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -192,8 +192,8 @@ static void kobil_init_termios(struct tty_struct *tty)
 {
 	/* Default to echo off and other sane device settings */
 	tty->termios->c_lflag = 0;
-	tty->termios->c_lflag &= ~(ISIG | ICANON | ECHO | IEXTEN | XCASE);
-	tty->termios->c_iflag = IGNBRK | IGNPAR | IXOFF;
+	tty->termios->c_iflag &= ~(ISIG | ICANON | ECHO | IEXTEN | XCASE);
+	tty->termios->c_iflag |= IGNBRK | IGNPAR | IXOFF;
 	/* do NOT translate CR to CR-NL (0x0A -> 0x0A 0x0D) */
 	tty->termios->c_oflag &= ~ONLCR;
 }
@@ -588,7 +588,7 @@ static void kobil_set_termios(struct tty_struct *tty,
 	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID ||
 			priv->device_type == KOBIL_KAAN_SIM_PRODUCT_ID) {
 		/* This device doesn't support ioctl calls */
-		*tty->termios = *old;
+		tty_termios_copy_hw(tty->termios, old_termios);
 		return;
 	}
 

