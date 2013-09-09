From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH 3/7] serial: bfin_uart: Remove casting the return value
 which is a void pointer
Date: Mon, 9 Sep 2013 07:27:27 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE31BC7699@NWD2MBX7.ad.analog.com>
References: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
 <003c01cead1a$a8052ef0$f80f8cd0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:36481
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751517Ab3IIH2W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Sep 2013 03:28:22 -0400
In-Reply-To: <003c01cead1a$a8052ef0$f80f8cd0$%han@samsung.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Acked-by: Sonic Zhang<sonic.zhang@analog.com>

>-----Original Message-----
>From: Jingoo Han [mailto:jg1.han@samsung.com]
>Sent: Monday, September 09, 2013 1:09 PM
>To: 'Greg Kroah-Hartman'
>Cc: linux-serial@vger.kernel.org; Zhang, Sonic; 'Jingoo Han'
>Subject: [PATCH 3/7] serial: bfin_uart: Remove casting the return value which is a
>void pointer
>
>Casting the return value which is a void pointer is redundant.
>The conversion from void pointer to any other pointer type is guaranteed by the C
>programming language.
>
>Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>---
> drivers/tty/serial/bfin_uart.c |   15 ++++++---------
> 1 file changed, 6 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c index
>3c75e8e..74749a6 100644
>--- a/drivers/tty/serial/bfin_uart.c
>+++ b/drivers/tty/serial/bfin_uart.c
>@@ -1240,7 +1240,7 @@ static int bfin_serial_probe(struct platform_device *pdev)
>                        */
> #endif
>               ret = peripheral_request_list(
>-                      (unsigned short *)dev_get_platdata(&pdev->dev),
>+                      dev_get_platdata(&pdev->dev),
>                       DRIVER_NAME);
>               if (ret) {
>                       dev_err(&pdev->dev,
>@@ -1358,8 +1358,7 @@ static int bfin_serial_probe(struct platform_device *pdev)
> out_error_unmap:
>               iounmap(uart->port.membase);
> out_error_free_peripherals:
>-              peripheral_free_list(
>-                      (unsigned short *)dev_get_platdata(&pdev->dev));
>+              peripheral_free_list(dev_get_platdata(&pdev->dev));
> out_error_free_mem:
>               kfree(uart);
>               bfin_serial_ports[pdev->id] = NULL;
>@@ -1377,8 +1376,7 @@ static int bfin_serial_remove(struct platform_device *pdev)
>       if (uart) {
>               uart_remove_one_port(&bfin_serial_reg, &uart->port);
>               iounmap(uart->port.membase);
>-              peripheral_free_list(
>-                      (unsigned short *)dev_get_platdata(&pdev->dev));
>+              peripheral_free_list(dev_get_platdata(&pdev->dev));
>               kfree(uart);
>               bfin_serial_ports[pdev->id] = NULL;
>       }
>@@ -1432,8 +1430,8 @@ static int bfin_earlyprintk_probe(struct platform_device
>*pdev)
>               return -ENOENT;
>       }
>
>-      ret = peripheral_request_list(
>-              (unsigned short *)dev_get_platdata(&pdev->dev), DRIVER_NAME);
>+      ret = peripheral_request_list(dev_get_platdata(&pdev->dev),
>+                                      DRIVER_NAME);
>       if (ret) {
>               dev_err(&pdev->dev,
>                               "fail to request bfin serial peripherals\n"); @@ -1463,8
>+1461,7 @@ static int bfin_earlyprintk_probe(struct platform_device *pdev)
>       return 0;
>
> out_error_free_peripherals:
>-      peripheral_free_list(
>-              (unsigned short *)dev_get_platdata(&pdev->dev));
>+      peripheral_free_list(dev_get_platdata(&pdev->dev));
>
>       return ret;
> }
>--
>1.7.10.4
>
>


