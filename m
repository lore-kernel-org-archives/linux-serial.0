From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH RESEND] tty: serial: omap: Remove probe error message
Date: Mon, 29 Sep 2014 09:29:42 +0200
Message-ID: <1411975782-23709-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50926 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbaI2HaX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Sep 2014 03:30:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

This error message is not necessary. The driver core code will print all
probe error messages. It also resolves some error codes to proper error
messages. For example -EPROBE_DEFER will only be printed as an info message.

This patch removes the error message as the core prints the same
information.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Hi,

I am not sure if this patch got lost, so I resend it. I rebased the patch onto
v3.17-rc1 without conflicts.

Best regards,

Markus

 drivers/tty/serial/omap-serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d017cec8a34a..a153bad142c8 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1733,8 +1733,6 @@ err_add_port:
 	pm_runtime_disable(&pdev->dev);
 err_rs485:
 err_port_line:
-	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
-				pdev->id, __func__, ret);
 	return ret;
 }
 
-- 
2.1.0

