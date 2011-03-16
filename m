From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/76] serial: omap-serial: Enable the UART wake-up bits always
Date: Wed, 16 Mar 2011 14:11:35 -0700
Message-ID: <1300309966-5745-5-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32850 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754296Ab1CPVMx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:12:53 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jarkko Nikula <jhnikula@gmail.com>

OMAP can do also dynamic idling so wake-up enable register should be set
also while system is running. If UART_OMAP_WER is not set, then for instance
the RX activity cannot wake up the UART port that is sleeping.

This RX wake-up feature was working when the 8250 driver was used instead
of omap-serial. Reason for this is that the 8250 doesn't set the
UART_OMAP_WER and then arch/arm/mach-omap2/pm34xx.c ends up saving and
restoring the reset default which is the same than value
OMAP_UART_WER_MOD_WKUP here.

Fix this by moving the conditional UART_OMAP_WER write from serial_omap_pm
into serial_omap_startup where wake-up bits are set unconditionally.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/omap-serial.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 699b344..7635379 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -520,6 +520,9 @@ static int serial_omap_startup(struct uart_port *port)
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
 
+	/* Enable module level wake up */
+	serial_out(up, UART_OMAP_WER, OMAP_UART_WER_MOD_WKUP);
+
 	up->port_activity = jiffies;
 	return 0;
 }
@@ -827,9 +830,6 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
-	/* Enable module level wake up */
-	serial_out(up, UART_OMAP_WER,
-		(state != 0) ? OMAP_UART_WER_MOD_WKUP : 0);
 }
 
 static void serial_omap_release_port(struct uart_port *port)
-- 
1.7.4.1

