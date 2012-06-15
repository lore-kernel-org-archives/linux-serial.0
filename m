From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/4] serial: imx: Remove unneeded '#ifdef CONFIG_OF'
Date: Fri, 15 Jun 2012 14:23:04 -0300
Message-ID: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:13375
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751124Ab2FORXb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 13:23:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, shawn.guo@linaro.org, marex@denx.de, Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

CONFIG_OF is always selected for imx SoCs so it is safe
to drop the '#ifdef CONFIG_OF'.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>
Cc: <linux-serial@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0af4eec..4bfa95d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1399,7 +1399,6 @@ static int serial_imx_resume(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 /*
  * This function returns 1 iff pdev isn't a device instatiated by dt, 0 iff it
  * could successfully get all information from dt or a negative errno.
@@ -1433,13 +1432,6 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 
 	return 0;
 }
-#else
-static inline int serial_imx_probe_dt(struct imx_port *sport,
-		struct platform_device *pdev)
-{
-	return 1;
-}
-#endif
 
 static void serial_imx_probe_pdata(struct imx_port *sport,
 		struct platform_device *pdev)
-- 
1.7.1


