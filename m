From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 2/2] serial: imx: Allow module build
Date: Tue, 4 Jun 2013 14:08:38 -0300
Message-ID: <1370365718-23474-2-git-send-email-fabio.estevam@freescale.com>
References: <1370365718-23474-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:46880
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755644Ab3FDRJC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jun 2013 13:09:02 -0400
In-Reply-To: <1370365718-23474-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, b35083@freescale.com, kernel@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

There is no need to only allow the serial driver to be built-in.

Allow the imx serial driver to be build as a module.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a9ae1cd..28cffda 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -551,7 +551,7 @@ config BFIN_UART3_CTSRTS
 	  Enable hardware flow control in the driver.
 
 config SERIAL_IMX
-	bool "IMX serial port support"
+	tristate "IMX serial port support"
 	depends on ARCH_MXC
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
-- 
1.8.1.2


