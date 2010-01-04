From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] serial: Fix crash if the minimum rate of the device is > 9600
	baud
Date: Mon, 04 Jan 2010 16:26:21 +0000
Message-ID: <20100104162557.17151.23761.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54914 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752392Ab0ADQte (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jan 2010 11:49:34 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org


(Resend for -next)

In that situation if the old rate is invalid and the new rate is invalid
and the chip cannot do 9600 baud we report zero, which makes all the
drivers explode.

Instead force the rate based on min/max

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/serial/serial_core.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)


diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index fa4f170..07fe320 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -385,13 +385,20 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		}
 
 		/*
-		 * As a last resort, if the quotient is zero,
-		 * default to 9600 bps
+		 * As a last resort, if the range cannot be met then clip to
+		 * the nearest chip supported rate.
 		 */
-		if (!hung_up)
-			tty_termios_encode_baud_rate(termios, 9600, 9600);
+		if (!hung_up) {
+			if (baud <= min)                
+				tty_termios_encode_baud_rate(termios,
+							min + 1, min + 1);
+			else
+				tty_termios_encode_baud_rate(termios,
+							max - 1, max - 1);
+		}
 	}
-
+	/* Should never happen */
+	WARN_ON(1);
 	return 0;
 }
 

