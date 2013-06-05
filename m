From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 3/3] serial: imx: Improve Kconfig text
Date: Wed,  5 Jun 2013 00:58:48 -0300
Message-ID: <1370404728-29707-3-git-send-email-festevam@gmail.com>
References: <1370404728-29707-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gh0-f173.google.com ([209.85.160.173]:47870 "EHLO
	mail-gh0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab3FEE0W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Jun 2013 00:26:22 -0400
Received: by mail-gh0-f173.google.com with SMTP id g16so123910ghb.4
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2013 21:26:21 -0700 (PDT)
In-Reply-To: <1370404728-29707-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, b35083@freescale.com, kernel@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Some improvements in the Kconfig text:

- Vendor is Freescale now
- Provide a better example for the console parameter, which is something like
console=ttymxc0
- Do not pass the names of ancient bootloaders 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Same as v1
 drivers/tty/serial/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 7a0f705..1f2f54c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -564,15 +564,14 @@ config SERIAL_IMX_CONSOLE
 	depends on SERIAL_IMX=y
 	select SERIAL_CORE_CONSOLE
 	help
-	  If you have enabled the serial port on the Motorola IMX
+	  If you have enabled the serial port on the Freescale IMX
 	  CPU you can make it the console by answering Y to this option.
 
 	  Even if you say Y here, the currently visible virtual console
 	  (/dev/tty0) will still be used as the system console by default, but
 	  you can alter that using a kernel command line option such as
-	  "console=ttySA0". (Try "man bootparam" or see the documentation of
-	  your boot loader (lilo or loadlin) about how to pass options to the
-	  kernel at boot time.)
+	  "console=ttymxc0". (Try "man bootparam" or see the documentation of
+	  your bootloader about how to pass options to the kernel at boot time.)
 
 config SERIAL_UARTLITE
 	tristate "Xilinx uartlite serial port support"
-- 
1.8.1.2

