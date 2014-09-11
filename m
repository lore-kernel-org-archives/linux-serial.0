From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] serial: 8250_pci: remove rts_n override from Baytrail quirk
Date: Thu, 11 Sep 2014 15:26:12 +0300
Message-ID: <1410438372-25204-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25889 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600AbaIKM0r (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 08:26:47 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

It should not be used together with Auto Flow Control, and
Auto Flow Control is always enabled on Baytrail.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 61830b1..f236c75 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1355,9 +1355,6 @@ ce4100_serial_setup(struct serial_private *priv,
 #define BYT_PRV_CLK_N_VAL_SHIFT		16
 #define BYT_PRV_CLK_UPDATE		(1 << 31)
 
-#define BYT_GENERAL_REG			0x808
-#define BYT_GENERAL_DIS_RTS_N_OVERRIDE	(1 << 3)
-
 #define BYT_TX_OVF_INT			0x820
 #define BYT_TX_OVF_INT_MASK		(1 << 1)
 
@@ -1412,16 +1409,6 @@ byt_set_termios(struct uart_port *p, struct ktermios *termios,
 	reg |= BYT_PRV_CLK_EN | BYT_PRV_CLK_UPDATE;
 	writel(reg, p->membase + BYT_PRV_CLK);
 
-	/*
-	 * If auto-handshake mechanism is not enabled,
-	 * disable rts_n override
-	 */
-	reg = readl(p->membase + BYT_GENERAL_REG);
-	reg &= ~BYT_GENERAL_DIS_RTS_N_OVERRIDE;
-	if (termios->c_cflag & CRTSCTS)
-		reg |= BYT_GENERAL_DIS_RTS_N_OVERRIDE;
-	writel(reg, p->membase + BYT_GENERAL_REG);
-
 	serial8250_do_set_termios(p, termios, old);
 }
 
-- 
2.1.0

