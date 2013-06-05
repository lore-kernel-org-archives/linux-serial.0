From: Lu Jingchang-B35083 <B35083@freescale.com>
Subject: RE: [PATCH v2 2/2] serial: imx: Allow module build
Date: Wed, 5 Jun 2013 02:33:17 +0000
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CF2E7@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1370365718-23474-1-git-send-email-fabio.estevam@freescale.com>
 <1370365718-23474-2-git-send-email-fabio.estevam@freescale.com>,<B56CDBE15CE27145A4B77D2D24263E851CF28F@039-SN1MPN1-003.039d.mgd.msft.net>
 <86D15885F63D1143A519F161FB828EAF267106@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:31216 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751026Ab3FECeE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jun 2013 22:34:04 -0400
In-Reply-To: <86D15885F63D1143A519F161FB828EAF267106@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Estevam Fabio-R49496 <r49496@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>



>-----Original Message-----
>From: Estevam Fabio-R49496
>Sent: Wednesday, June 05, 2013 9:47 AM
>To: Lu Jingchang-B35083; gregkh@linuxfoundation.org
>Cc: shawn.guo@linaro.org; kernel@pengutronix.de; linux-
>serial@vger.kernel.org; festevam@gmail.com
>Subject: RE: [PATCH v2 2/2] serial: imx: Allow module build
>
>Hi Lu,
>
>[Sorry for top-posting. I only have email access from browser now].
>
>Building as module does work for me.
>
>Please do a 'make clean' and then try again.
>
>
[Lu Jingchang-B35083] 
With make arch=ARM clean, I still meet the same fail problem. Does the driver support console when built as module?
If it does, I see that "uart_console_device" referenced by imx.c is not exported with EXPORT_SYMBOL in serial core.
>From the patch, I think the drive support console when built as module, doesn't it?
But explanation from Arnd Bergmann [arnd@arndb.de] yesterday is: "All serial port drivers do this. IIRC the reason is that the console has to be started from console_initcall(), which is not available in modules."
It seems serial driver module mode doesn't support console support, do I misunderstand? 
Thanks!


Best regards,
Jingchang
________________________________________
>From: Lu Jingchang-B35083
>Sent: Tuesday, June 04, 2013 8:36 PM
>To: Estevam Fabio-R49496; gregkh@linuxfoundation.org
>Cc: shawn.guo@linaro.org; kernel@pengutronix.de; linux-
>serial@vger.kernel.org
>Subject: RE: [PATCH v2 2/2] serial: imx: Allow module build
>
>>-----Original Message-----
>>From: Estevam Fabio-R49496
>>Sent: Wednesday, June 05, 2013 1:09 AM
>>To: gregkh@linuxfoundation.org
>>Cc: shawn.guo@linaro.org; Lu Jingchang-B35083; kernel@pengutronix.de;
>>linux-serial@vger.kernel.org; Estevam Fabio-R49496
>>Subject: [PATCH v2 2/2] serial: imx: Allow module build
>>
>>There is no need to only allow the serial driver to be built-in.
>>
>>Allow the imx serial driver to be build as a module.
>>
>>Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>>---
>>Changes since v1:
>>- None
>> drivers/tty/serial/Kconfig | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>index a9ae1cd..28cffda 100644
>>--- a/drivers/tty/serial/Kconfig
>>+++ b/drivers/tty/serial/Kconfig
>>@@ -551,7 +551,7 @@ config BFIN_UART3_CTSRTS
>>         Enable hardware flow control in the driver.
>>
>> config SERIAL_IMX
>>-      bool "IMX serial port support"
>>+      tristate "IMX serial port support"
>>       depends on ARCH_MXC
>>       select SERIAL_CORE
>>       select SERIAL_CORE_CONSOLE
>>--
>[Lu Jingchang-B35083]
>With the two patches, when configure the imx serial driver as a module, I
>fail to build it with following error message:
>
>ERROR: "uart_console_device" [drivers/tty/serial/imx.ko] undefined!
>make[1]: *** [__modpost] Error 1
>
>Best regards,
>Jingchang

