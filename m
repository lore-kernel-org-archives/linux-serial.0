From: Lu Jingchang-B35083 <B35083@freescale.com>
Subject: RE: [PATCH v2 2/2] serial: imx: Allow module build
Date: Wed, 5 Jun 2013 01:36:40 +0000
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CF28F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1370365718-23474-1-git-send-email-fabio.estevam@freescale.com>
 <1370365718-23474-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:21480
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929Ab3FEBhI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jun 2013 21:37:08 -0400
In-Reply-To: <1370365718-23474-2-git-send-email-fabio.estevam@freescale.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Estevam Fabio-R49496 <r49496@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>



>-----Original Message-----
>From: Estevam Fabio-R49496
>Sent: Wednesday, June 05, 2013 1:09 AM
>To: gregkh@linuxfoundation.org
>Cc: shawn.guo@linaro.org; Lu Jingchang-B35083; kernel@pengutronix.de;
>linux-serial@vger.kernel.org; Estevam Fabio-R49496
>Subject: [PATCH v2 2/2] serial: imx: Allow module build
>
>There is no need to only allow the serial driver to be built-in.
>
>Allow the imx serial driver to be build as a module.
>
>Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>---
>Changes since v1:
>- None
> drivers/tty/serial/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig index
>a9ae1cd..28cffda 100644
>--- a/drivers/tty/serial/Kconfig
>+++ b/drivers/tty/serial/Kconfig
>@@ -551,7 +551,7 @@ config BFIN_UART3_CTSRTS
> 	  Enable hardware flow control in the driver.
>
> config SERIAL_IMX
>-	bool "IMX serial port support"
>+	tristate "IMX serial port support"
> 	depends on ARCH_MXC
> 	select SERIAL_CORE
> 	select SERIAL_CORE_CONSOLE
>--
[Lu Jingchang-B35083] 
With the two patches, when configure the imx serial driver as a module, I fail to build it with following error message:

ERROR: "uart_console_device" [drivers/tty/serial/imx.ko] undefined!
make[1]: *** [__modpost] Error 1

Best regards,
Jingchang

