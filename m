From: Claudio Scordino <claudio@evidence.eu.com>
Subject: [PATCH] CRIS RS485: Check SER_RS485_RTS_BEFORE_SEND before delaying.
Date: Wed, 11 Aug 2010 17:09:31 +0200
Message-ID: <4C62BD2B.2010508@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: starvik@axis.com, linux-cris-kernel <linux-cris-kernel@axis.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Hinko Kocevar <hinko.kocevar@cetrtapot.si>, Janez Cufer <janez.cufer@cetrtapot.si>, Andy Whitcroft <apw@canonical.com>, Linux Kernel <linux-kernel@vger.kernel.org>, dev-etrax <dev-etrax@axis.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Jesper,

	the following patch fixes the usage of the delay in RS485 mode
on the Cris architecture.

Very recently, the RS485 interface has been fixed by adding two further
fields (see commit 1b6331848b69d1ed165a6bdc75c4046d68767563).

This patch checks the value of the flag SER_RS485_RTS_BEFORE_SEND before
delaying.

Best regards,

	Claudio


CRIS RS485: Check SER_RS485_RTS_BEFORE_SEND before delaying.

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
---
 drivers/serial/crisv10.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/crisv10.c b/drivers/serial/crisv10.c
index c856905..a2237e7 100644
--- a/drivers/serial/crisv10.c
+++ b/drivers/serial/crisv10.c
@@ -1411,11 +1411,12 @@ e100_enable_rs485(struct tty_struct *tty, struct serial_rs485 *r)
 		       CONFIG_ETRAX_RS485_LTC1387_RXEN_PORT_G_BIT, 1);
 #endif
 
-	info->rs485.flags = r->flags;
-	if (r->delay_rts_before_send >= 1000)
+	info->rs485 = *r;
+
+	/* Maximum delay before RTS equal to 1000 */
+	if (info->rs485.delay_rts_before_send >= 1000)
 		info->rs485.delay_rts_before_send = 1000;
-	else
-		info->rs485.delay_rts_before_send = r->delay_rts_before_send;
+
 /*	printk("rts: on send = %i, after = %i, enabled = %i",
 		    info->rs485.rts_on_send,
 		    info->rs485.rts_after_sent,
@@ -3234,9 +3235,9 @@ rs_write(struct tty_struct *tty,
 		e100_disable_rx(info);
 		e100_enable_rx_irq(info);
 #endif
-
-		if (info->rs485.delay_rts_before_send > 0)
-			msleep(info->rs485.delay_rts_before_send);
+		if ((info->rs485.flags & SER_RS485_RTS_BEFORE_SEND) &&
+			(info->rs485.delay_rts_before_send > 0))
+				msleep(info->rs485.delay_rts_before_send);
 	}
 #endif /* CONFIG_ETRAX_RS485 */
 
@@ -3694,6 +3695,11 @@ rs_ioctl(struct tty_struct *tty, struct file * file,
 
 		rs485data.delay_rts_before_send = rs485ctrl.delay_rts_before_send;
 		rs485data.flags = 0;
+		if (rs485data.delay_rts_before_send != 0)
+			rs485data.flags |= SER_RS485_RTS_BEFORE_SEND;
+		else
+			rs485data.flags &= ~(SER_RS485_RTS_BEFORE_SEND);
+
 		if (rs485ctrl.enabled)
 			rs485data.flags |= SER_RS485_ENABLED;
 		else
@@ -4527,6 +4533,7 @@ static int __init rs_init(void)
 		/* Set sane defaults */
 		info->rs485.flags &= ~(SER_RS485_RTS_ON_SEND);
 		info->rs485.flags |= SER_RS485_RTS_AFTER_SEND;
+		info->rs485.flags &= ~(SER_RS485_RTS_BEFORE_SEND);
 		info->rs485.delay_rts_before_send = 0;
 		info->rs485.flags &= ~(SER_RS485_ENABLED);
 #endif
-- 
1.6.0.4
