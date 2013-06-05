From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 2/3] serial: imx: Allow module build
Date: Wed,  5 Jun 2013 00:58:47 -0300
Message-ID: <1370404728-29707-2-git-send-email-festevam@gmail.com>
References: <1370404728-29707-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gg0-f170.google.com ([209.85.161.170]:40949 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3FEEE5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Jun 2013 00:04:57 -0400
Received: by mail-gg0-f170.google.com with SMTP id s6so278671ggc.15
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2013 21:04:57 -0700 (PDT)
In-Reply-To: <1370404728-29707-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, b35083@freescale.com, kernel@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need to only allow the serial driver to be built-in.

Allow the imx serial driver to be built as a module.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Use depends on SERIAL_IMX=y as done on many other serial drivers
 drivers/tty/serial/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 7e7006f..7a0f705 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -551,7 +551,7 @@ config BFIN_UART3_CTSRTS
 	  Enable hardware flow control in the driver.
 
 config SERIAL_IMX
-	bool "IMX serial port support"
+	tristate "IMX serial port support"
 	depends on ARCH_MXC
 	select SERIAL_CORE
 	select RATIONAL
@@ -561,7 +561,7 @@ config SERIAL_IMX
 
 config SERIAL_IMX_CONSOLE
 	bool "Console on IMX serial port"
-	depends on SERIAL_IMX
+	depends on SERIAL_IMX=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  If you have enabled the serial port on the Motorola IMX
-- 
1.8.1.2

