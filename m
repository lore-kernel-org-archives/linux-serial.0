From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 10/11] Blackfin Serial Driver: handle anomaly 05000231
Date: Tue,  2 Jun 2009 03:11:39 -0400
Message-ID: <1243926700-30485-10-git-send-email-vapier@gentoo.org>
References: <1243926700-30485-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:46642 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758565AbZFBHLw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jun 2009 03:11:52 -0400
In-Reply-To: <1243926700-30485-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

05000231 - UART STB Bit Incorrectly Affects Receiver Setting
For processors affected by this, we cannot safely allow CSTOPB to be set
as the UART will then be unable to properly clock in bytes.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/serial/bfin_5xx.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index ab583ef..64603f5 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -828,8 +828,16 @@ bfin_serial_set_termios(struct uart_port *port, struct ktermios *termios,
 			__func__);
 	}
 
-	if (termios->c_cflag & CSTOPB)
-		lcr |= STB;
+	/* Anomaly notes:
+	 *  05000231 -  STOP bit is always set to 1 whatever the user is set.
+	 */
+	if (termios->c_cflag & CSTOPB) {
+		if (ANOMALY_05000231)
+			printk(KERN_WARNING "STOP bits other than 1 is not "
+				"supported in case of anomaly 05000231.\n");
+		else
+			lcr |= STB;
+	}
 	if (termios->c_cflag & PARENB)
 		lcr |= PEN;
 	if (!(termios->c_cflag & PARODD))
-- 
1.6.3.1

