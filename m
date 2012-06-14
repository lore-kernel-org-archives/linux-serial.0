From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 14/16] tty: serial: imx: remove the use of MXC_INTERNAL_IRQS
Date: Thu, 14 Jun 2012 13:59:45 +0800
Message-ID: <1339653587-4832-15-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:38874
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830Ab2FNGA6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Jun 2012 02:00:58 -0400
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

As the part of the effort to enable SPARE_IRQ for imx platform,
the macro MXC_INTERNAL_IRQS will be removed.  The imx serial driver
has a references to it for a decision on flags of request_irq call
based on rtsirq is beyond MXC_INTERNAL_IRQS.  However the searching
on imx platform code tells that rtsirq will never be beyond
MXC_INTERNAL_IRQS.  That said, the check, consequently the reference
to MXC_INTERNAL_IRQS are not needed, so remove them.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4ef7473..d5c689d6 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -169,7 +169,6 @@
 #define SERIAL_IMX_MAJOR        207
 #define MINOR_START	        16
 #define DEV_NAME		"ttymxc"
-#define MAX_INTERNAL_IRQ	MXC_INTERNAL_IRQS
 
 /*
  * This determines how often we check the modem status signals
@@ -741,10 +740,7 @@ static int imx_startup(struct uart_port *port)
 
 		/* do not use RTS IRQ on IrDA */
 		if (!USE_IRDA(sport)) {
-			retval = request_irq(sport->rtsirq, imx_rtsint,
-				     (sport->rtsirq < MAX_INTERNAL_IRQ) ? 0 :
-				       IRQF_TRIGGER_FALLING |
-				       IRQF_TRIGGER_RISING,
+			retval = request_irq(sport->rtsirq, imx_rtsint, 0,
 					DRIVER_NAME, sport);
 			if (retval)
 				goto error_out3;
-- 
1.7.5.4


