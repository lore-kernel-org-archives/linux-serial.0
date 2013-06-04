From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] serial: imx: Allow module build
Date: Mon,  3 Jun 2013 23:51:47 -0300
Message-ID: <1370314308-11637-2-git-send-email-festevam@gmail.com>
References: <1370314308-11637-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:51589 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384Ab3FDCwG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 22:52:06 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so584946yho.15
        for <linux-serial@vger.kernel.org>; Mon, 03 Jun 2013 19:52:05 -0700 (PDT)
In-Reply-To: <1370314308-11637-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, b35083@freescale.com, kernel@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need to only allow the serial driver to be built-in.

Allow the imx serial driver to be build as a module.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 7e7006f..bfe9ad8 100644
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
@@ -560,7 +560,7 @@ config SERIAL_IMX
 	  can enable its onboard serial port by enabling this option.
 
 config SERIAL_IMX_CONSOLE
-	bool "Console on IMX serial port"
+	tristate "Console on IMX serial port"
 	depends on SERIAL_IMX
 	select SERIAL_CORE_CONSOLE
 	help
-- 
1.8.1.2

