From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH RESEND] tty: serial: omap: Remove probe error message
Date: Wed,  5 Nov 2014 13:20:50 +0100
Message-ID: <1415190050-31300-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40479 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbaKEMVS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 07:21:18 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

This error message is not necessary. The driver core code will print all
probe error messages. It also resolves some error codes to proper error
messages. For example -EPROBE_DEFER will only be printed as an info message.

This patch removes the error message as the core prints the same
information.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Felipe Balbi <balbi@ti.com>
---

Hi,

this is another resend of this patch. I rebased it onto v3.18-rc3.

Regards,

Markus

 drivers/tty/serial/omap-serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 18c30cabe27f..6cda5cd8b513 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1747,8 +1747,6 @@ err_add_port:
 	pm_runtime_disable(&pdev->dev);
 err_rs485:
 err_port_line:
-	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
-				pdev->id, __func__, ret);
 	return ret;
 }
 
-- 
2.1.1

