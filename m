From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH] serial: mfd: adjust the baud rate setting
Date: Fri, 19 Nov 2010 10:20:26 +0800
Message-ID: <1290133226-6429-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44702 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730Ab0KSBqr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 20:46:47 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com, alan@linux.intel.com
Cc: Feng Tang <feng.tang@intel.com>

This change is made according to silicon engineers' feedback and
the real world test result.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/serial/mfd.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/serial/mfd.c b/drivers/serial/mfd.c
index 5fc699e..d40010a 100644
--- a/drivers/serial/mfd.c
+++ b/drivers/serial/mfd.c
@@ -900,8 +900,7 @@ serial_hsu_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
 	unsigned int baud, quot;
-	u32 mul = 0x3600;
-	u32 ps = 0x10;
+	u32 ps, mul;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -943,31 +942,24 @@ serial_hsu_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, 4000000);
 
 	quot = 1;
+	ps = 0x10;
+	mul = 0x3600;
 	switch (baud) {
 	case 3500000:
 		mul = 0x3345;
 		ps = 0xC;
 		break;
-	case 3000000:
-		mul = 0x2EE0;
-		break;
-	case 2500000:
-		mul = 0x2710;
-		break;
-	case 2000000:
-		mul = 0x1F40;
-		break;
 	case 1843200:
 		mul = 0x2400;
 		break;
+	case 3000000:
+	case 2500000:
+	case 2000000:
 	case 1500000:
-		mul = 0x1770;
-		break;
 	case 1000000:
-		mul = 0xFA0;
-		break;
 	case 500000:
-		mul = 0x7D0;
+		/* mul/ps/quot = 0x9C4/0x10/0x1 will make a 500000 bps */
+		mul = baud / 500000 * 0x9C4;
 		break;
 	default:
 		/* Use uart_get_divisor to get quot for other baud rates */
-- 
1.7.0.4

