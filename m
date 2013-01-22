From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: xilinx_uartps: Remove leftover __exit_p()
Date: Tue, 22 Jan 2013 13:11:11 +0100
Message-ID: <1358856671-9155-1-git-send-email-michal.simek@xilinx.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63233 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab3AVMLQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Jan 2013 07:11:16 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so4300845wgb.11
        for <linux-serial@vger.kernel.org>; Tue, 22 Jan 2013 04:11:15 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, monstr@monstr.eu
Cc: Josh Cartwright <josh.cartwright@ni.com>

__exit_p() need to be removed after the __devexit
removal from the driver.

Warning log:
drivers/tty/serial/xilinx_uartps.c:996:12:
warning: 'xuartps_remove' defined but not used [-Wunused-function]

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e426603..ba451c7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1044,7 +1044,7 @@ MODULE_DEVICE_TABLE(of, xuartps_of_match);
 
 static struct platform_driver xuartps_platform_driver = {
 	.probe   = xuartps_probe,		/* Probe method */
-	.remove  = __exit_p(xuartps_remove),	/* Detach method */
+	.remove  = xuartps_remove,		/* Detach method */
 	.suspend = xuartps_suspend,		/* Suspend */
 	.resume  = xuartps_resume,		/* Resume after a suspend */
 	.driver  = {
-- 
1.7.0.4

