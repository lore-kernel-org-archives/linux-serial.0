From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 1/2] serial: 8250_pci: more BayTrail error-free bauds
Date: Mon, 3 Mar 2014 19:54:29 -0600 (CST)
Message-ID: <376255937.81261.1393898069932.JavaMail.zimbra@xes-inc.com>
References: <263958445.81234.1393897872966.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:65504 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755623AbaCDByd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Mar 2014 20:54:33 -0500
In-Reply-To: <263958445.81234.1393897872966.JavaMail.zimbra@xes-inc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>

Support the following additional baud rates with 0% error:
	500000, 1500000, 2500000, 3500000

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/tty/serial/8250/8250_pci.c |   37 ++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 50228ee..e4289b2 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1365,22 +1365,43 @@ byt_set_termios(struct uart_port *p, struct ktermios *termios,
 		struct ktermios *old)
 {
 	unsigned int baud = tty_termios_baud_rate(termios);
-	unsigned int m = 6912;
-	unsigned int n = 15625;
+	unsigned int m, n;
 	u32 reg;
 
-	/* For baud rates 1M, 2M, 3M and 4M the dividers must be adjusted. */
-	if (baud == 1000000 || baud == 2000000 || baud == 4000000) {
+	/*
+	 * For baud rates 0.5M, 1M, 1.5M, 2M, 2.5M, 3M, 3.5M and 4M the
+	 * dividers must be adjusted.
+	 *
+	 * uartclk = (m / n) * 100 MHz, where m <= n
+	 */
+	switch (baud) {
+	case 500000:
+	case 1000000:
+	case 2000000:
+	case 4000000:
 		m = 64;
 		n = 100;
-
 		p->uartclk = 64000000;
-	} else if (baud == 3000000) {
+		break;
+	case 3500000:
+		m = 56;
+		n = 100;
+		p->uartclk = 56000000;
+		break;
+	case 1500000:
+	case 3000000:
 		m = 48;
 		n = 100;
-
 		p->uartclk = 48000000;
-	} else {
+		break;
+	case 2500000:
+		m = 40;
+		n = 100;
+		p->uartclk = 40000000;
+		break;
+	default:
+		m = 6912;
+		n = 15625;
 		p->uartclk = 44236800;
 	}
 
-- 
1.7.9.5

