From: akpm@linux-foundation.org
Subject: [patch 4/5] serial167: fix read buffer overflow
Date: Thu, 06 Aug 2009 16:08:21 -0700
Message-ID: <200908062308.n76N8LOV009723@imap1.linux-foundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47593 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756879AbZHFXIz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Aug 2009 19:08:55 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com, jirislaby@gmail.com

From: Roel Kluin <roel.kluin@gmail.com>

Check whether index is within bounds before grabbing the element.

Also, since NR_PORTS is defined ARRAY_SIZE(cy_port), cy_port[NR_PORTS] is
out of bounds as well.

[akpm@linux-foundation.org: cleanup, remove (long) casts]
Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/char/serial167.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff -puN drivers/char/serial167.c~serial167-fix-read-buffer-overflow drivers/char/serial167.c
--- a/drivers/char/serial167.c~serial167-fix-read-buffer-overflow
+++ a/drivers/char/serial167.c
@@ -221,8 +221,7 @@ static inline int serial_paranoia_check(
 		return 1;
 	}
 
-	if ((long)info < (long)(&cy_port[0])
-	    || (long)(&cy_port[NR_PORTS]) < (long)info) {
+	if (info < &cy_port[0] || info >= &cy_port[NR_PORTS]) {
 		printk("Warning: cyclades_port out of range for (%s) in %s\n",
 				name, routine);
 		return 1;
@@ -521,15 +520,13 @@ static irqreturn_t cd2401_tx_interrupt(i
 		panic("TxInt on debug port!!!");
 	}
 #endif
-
-	info = &cy_port[channel];
-
 	/* validate the port number (as configured and open) */
 	if ((channel < 0) || (NR_PORTS <= channel)) {
 		base_addr[CyIER] &= ~(CyTxMpty | CyTxRdy);
 		base_addr[CyTEOIR] = CyNOTRANS;
 		return IRQ_HANDLED;
 	}
+	info = &cy_port[channel];
 	info->last_active = jiffies;
 	if (info->tty == 0) {
 		base_addr[CyIER] &= ~(CyTxMpty | CyTxRdy);
_
