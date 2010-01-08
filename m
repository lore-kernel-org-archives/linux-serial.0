From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] serial/mpc52xx_uart: Drop outdated comments
Date: Fri,  8 Jan 2010 22:19:29 +0100
Message-ID: <1262985569-29826-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50833 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab0AHVTo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Jan 2010 16:19:44 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: linux-serial@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>

Most things mentioned are either obsolete (platform-support) or wrong (device
numbering, DCD spport) these days. The remaining rest is obvious.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/serial/mpc52xx_uart.c |   33 ---------------------------------
 1 files changed, 0 insertions(+), 33 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 7ce9e9f..c7ec1a2 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -29,39 +29,6 @@
  * kind, whether express or implied.
  */
 
-/* Platform device Usage :
- *
- * Since PSCs can have multiple function, the correct driver for each one
- * is selected by calling mpc52xx_match_psc_function(...). The function
- * handled by this driver is "uart".
- *
- * The driver init all necessary registers to place the PSC in uart mode without
- * DCD. However, the pin multiplexing aren't changed and should be set either
- * by the bootloader or in the platform init code.
- *
- * The idx field must be equal to the PSC index (e.g. 0 for PSC1, 1 for PSC2,
- * and so on). So the PSC1 is mapped to /dev/ttyPSC0, PSC2 to /dev/ttyPSC1 and
- * so on. But be warned, it's an ABSOLUTE REQUIREMENT ! This is needed mainly
- * fpr the console code : without this 1:1 mapping, at early boot time, when we
- * are parsing the kernel args console=ttyPSC?, we wouldn't know which PSC it
- * will be mapped to.
- */
-
-/* OF Platform device Usage :
- *
- * This driver is only used for PSCs configured in uart mode.  The device
- * tree will have a node for each PSC with "mpc52xx-psc-uart" in the compatible
- * list.
- *
- * By default, PSC devices are enumerated in the order they are found.  However
- * a particular PSC number can be forces by adding 'device_no = <port#>'
- * to the device node.
- *
- * The driver init all necessary registers to place the PSC in uart mode without
- * DCD. However, the pin multiplexing aren't changed and should be set either
- * by the bootloader or in the platform init code.
- */
-
 #undef DEBUG
 
 #include <linux/device.h>
-- 
1.6.5

