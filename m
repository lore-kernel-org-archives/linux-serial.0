From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH 1/2] serial: bfin_sport_uart: Fix incorrect placement of
 __initdata
Date: Fri, 9 Aug 2013 01:46:04 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE31BC15DB@NWD2MBX7.ad.analog.com>
References: <1375962051-31873-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:34676
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967342Ab3HIBra convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 21:47:30 -0400
In-Reply-To: <1375962051-31873-1-git-send-email-sachin.kamat@linaro.org>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>

Acked-by: Sonic Zhang<sonic.zhang@analog.com>

>-----Original Message-----
>From: Sachin Kamat [mailto:sachin.kamat@linaro.org]
>Sent: Thursday, August 08, 2013 7:41 PM
>To: linux-serial@vger.kernel.org
>Cc: uclinux-dist-devel@blackfin.uclinux.org; gregkh@linuxfoundation.org;
>jslaby@suse.cz; sachin.kamat@linaro.org; Zhang, Sonic
>Subject: [PATCH 1/2] serial: bfin_sport_uart: Fix incorrect placement of __initdata
>
>__initdata should be placed between the variable name and equal sign for the
>variable to be placed in the intended section.
>
>Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>Cc: Sonic Zhang <sonic.zhang@analog.com>
>---
> drivers/tty/serial/bfin_sport_uart.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
>index 424ed36..016c3e9 100644
>--- a/drivers/tty/serial/bfin_sport_uart.c
>+++ b/drivers/tty/serial/bfin_sport_uart.c
>@@ -884,7 +884,7 @@ static struct platform_driver sport_uart_driver = {  };
>
> #ifdef CONFIG_SERIAL_BFIN_SPORT_CONSOLE -static __initdata struct
>early_platform_driver early_sport_uart_driver = {
>+static struct early_platform_driver early_sport_uart_driver __initdata
>+= {
>       .class_str = CLASS_BFIN_SPORT_CONSOLE,
>       .pdrv = &sport_uart_driver,
>       .requested_id = EARLY_PLATFORM_ID_UNSET,
>--
>1.7.9.5
>


