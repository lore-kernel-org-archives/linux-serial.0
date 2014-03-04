From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 2/2] serial: 8250_pci: change BayTrail default uartclk
Date: Mon, 3 Mar 2014 19:54:36 -0600 (CST)
Message-ID: <1222639163.81280.1393898076434.JavaMail.zimbra@xes-inc.com>
References: <694295964.81260.1393897982162.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:31963 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755665AbaCDByk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Mar 2014 20:54:40 -0500
In-Reply-To: <694295964.81260.1393897982162.JavaMail.zimbra@xes-inc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>

The Intel BayTrail HSUART power-on default reference clock is 44.2368 MHz,
but 73.728 MHz provides 0% error for additional "conventional" baud rates
above 460800 (e.g. 576000, 921600, and 1152000).

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/tty/serial/8250/8250_pci.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e4289b2..75398af 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1400,9 +1400,9 @@ byt_set_termios(struct uart_port *p, struct ktermios *termios,
 		p->uartclk = 40000000;
 		break;
 	default:
-		m = 6912;
-		n = 15625;
-		p->uartclk = 44236800;
+		m = 2304;
+		n = 3125;
+		p->uartclk = 73728000;
 	}
 
 	/* Reset the clock */
@@ -3469,6 +3469,10 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud	= 921600,
 		.reg_shift      = 2,
 	},
+	/*
+	 * Intel BayTrail HSUART reference clock is 44.2368 MHz at power-on,
+	 * but is overridden by byt_set_termios.
+	 */
 	[pbn_byt] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
-- 
1.7.9.5

