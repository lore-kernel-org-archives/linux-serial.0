From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc9] serial: fix platform driver hotplug/coldplug
Date: Sun, 13 Apr 2008 11:15:26 -0700
Message-ID: <200804131115.26592.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:34057 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751999AbYDMS2O (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 13 Apr 2008 14:28:14 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org
Cc: kay@ascent

=46rom: Kay Sievers <kay.sievers@vrfy.org>

Since 43cc71eed1250755986da4c0f9898f9a635cb3bf, the platform
modalias is prefixed with "platform:". Add MODULE_ALIAS() to the
hotpluggable serial platform drivers, to re-enable auto loading.

NOTE that Kconfig for some of these drivers doesn't allow modular
builds, and thus doesn't match the driver source's unload support.
Presumably their unload code is buggy and/or weakly tested...

[ dbrownell@users.sourceforge.net: more drivers, registration fixes ]
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/serial/atmel_serial.c |    1 +
 drivers/serial/bfin_5xx.c     |    2 ++
 drivers/serial/imx.c          |    2 ++
 drivers/serial/mcf.c          |    1 +
 drivers/serial/mpc52xx_uart.c |    2 ++
 drivers/serial/mpsc.c         |    2 ++
 drivers/serial/netx-serial.c  |    2 ++
 drivers/serial/pnx8xxx_uart.c |    1 +
 drivers/serial/pxa.c          |    3 ++-
 drivers/serial/s3c2410.c      |    4 ++++
 drivers/serial/sa1100.c       |    2 ++
 drivers/serial/sc26xx.c       |    2 ++
 drivers/serial/sh-sci.c       |    1 +
 drivers/serial/uartlite.c     |    3 +++
 drivers/serial/vr41xx_siu.c   |    3 +++
 15 files changed, 30 insertions(+), 1 deletion(-)

--- g26.orig/drivers/serial/atmel_serial.c	2008-04-13 10:43:34.00000000=
0 -0700
+++ g26/drivers/serial/atmel_serial.c	2008-04-13 10:46:32.000000000 -07=
00
@@ -1577,3 +1577,4 @@ module_exit(atmel_serial_exit);
 MODULE_AUTHOR("Rick Bronson");
 MODULE_DESCRIPTION("Atmel AT91 / AT32 serial port driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:atmel_usart");
--- g26.orig/drivers/serial/bfin_5xx.c	2008-04-13 10:43:34.000000000 -0=
700
+++ g26/drivers/serial/bfin_5xx.c	2008-04-13 10:49:15.000000000 -0700
@@ -1243,6 +1243,7 @@ static struct platform_driver bfin_seria
 	.resume		=3D bfin_serial_resume,
 	.driver		=3D {
 		.name	=3D "bfin-uart",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -1301,3 +1302,4 @@ MODULE_AUTHOR("Aubrey.Li <aubrey.li@anal
 MODULE_DESCRIPTION("Blackfin generic serial port driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV_MAJOR(BFIN_SERIAL_MAJOR);
+MODULE_ALIAS("platform:bfin-uart");
--- g26.orig/drivers/serial/imx.c	2008-04-13 10:43:35.000000000 -0700
+++ g26/drivers/serial/imx.c	2008-04-13 10:49:52.000000000 -0700
@@ -1090,6 +1090,7 @@ static struct platform_driver serial_imx
 	.resume		=3D serial_imx_resume,
 	.driver		=3D {
 	        .name	=3D "imx-uart",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -1124,3 +1125,4 @@ module_exit(imx_serial_exit);
 MODULE_AUTHOR("Sascha Hauer");
 MODULE_DESCRIPTION("IMX generic serial port driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imx-uart");
--- g26.orig/drivers/serial/mcf.c	2008-04-13 10:43:35.000000000 -0700
+++ g26/drivers/serial/mcf.c	2008-04-13 10:46:32.000000000 -0700
@@ -649,5 +649,6 @@ module_exit(mcf_exit);
 MODULE_AUTHOR("Greg Ungerer <gerg@snapgear.com>");
 MODULE_DESCRIPTION("Freescale ColdFire UART driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mcfuart");
=20
 /*********************************************************************=
*******/
--- g26.orig/drivers/serial/mpc52xx_uart.c	2008-04-13 10:48:05.00000000=
0 -0700
+++ g26/drivers/serial/mpc52xx_uart.c	2008-04-13 10:54:40.000000000 -07=
00
@@ -1188,6 +1188,8 @@ mpc52xx_uart_resume(struct platform_devi
 }
 #endif
=20
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:mpc52xx-psc");
=20
 static struct platform_driver mpc52xx_uart_platform_driver =3D {
 	.probe		=3D mpc52xx_uart_probe,
--- g26.orig/drivers/serial/mpsc.c	2008-04-13 10:43:35.000000000 -0700
+++ g26/drivers/serial/mpsc.c	2008-04-13 11:00:58.000000000 -0700
@@ -1964,6 +1964,7 @@ static struct platform_driver mpsc_drive
 	.remove	=3D mpsc_drv_remove,
 	.driver	=3D {
 		.name	=3D MPSC_CTLR_NAME,
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -2007,3 +2008,4 @@ MODULE_DESCRIPTION("Generic Marvell MPSC
 MODULE_VERSION(MPSC_VERSION);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV_MAJOR(MPSC_MAJOR);
+MODULE_ALIAS("platform:" MPSC_CTLR_NAME);
--- g26.orig/drivers/serial/netx-serial.c	2008-04-13 10:43:35.000000000=
 -0700
+++ g26/drivers/serial/netx-serial.c	2008-04-13 10:55:40.000000000 -070=
0
@@ -713,6 +713,7 @@ static struct platform_driver serial_net
=20
 	.driver		=3D {
 		.name   =3D DRIVER_NAME,
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -745,3 +746,4 @@ module_exit(netx_serial_exit);
 MODULE_AUTHOR("Sascha Hauer");
 MODULE_DESCRIPTION("NetX serial port driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
--- g26.orig/drivers/serial/pnx8xxx_uart.c	2008-04-13 10:43:35.00000000=
0 -0700
+++ g26/drivers/serial/pnx8xxx_uart.c	2008-04-13 10:46:32.000000000 -07=
00
@@ -850,3 +850,4 @@ MODULE_AUTHOR("Embedded Alley Solutions,
 MODULE_DESCRIPTION("PNX8XXX SoCs serial port driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV_MAJOR(SERIAL_PNX8XXX_MAJOR);
+MODULE_ALIAS("platform:pnx8xxx-uart");
--- g26.orig/drivers/serial/pxa.c	2008-04-13 10:43:35.000000000 -0700
+++ g26/drivers/serial/pxa.c	2008-04-13 10:56:07.000000000 -0700
@@ -833,6 +833,7 @@ static struct platform_driver serial_pxa
 	.resume		=3D serial_pxa_resume,
 	.driver		=3D {
 	        .name	=3D "pxa2xx-uart",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -861,4 +862,4 @@ module_init(serial_pxa_init);
 module_exit(serial_pxa_exit);
=20
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("platform:pxa2xx-uart");
--- g26.orig/drivers/serial/s3c2410.c	2008-04-13 10:43:35.000000000 -07=
00
+++ g26/drivers/serial/s3c2410.c	2008-04-13 10:46:32.000000000 -0700
@@ -1935,3 +1935,7 @@ console_initcall(s3c24xx_serial_initcons
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung S3C2410/S3C2440/S3C2412 Serial port driver=
");
+MODULE_ALIAS("platform:s3c2400-uart");
+MODULE_ALIAS("platform:s3c2410-uart");
+MODULE_ALIAS("platform:s3c2412-uart");
+MODULE_ALIAS("platform:s3c2440-uart");
--- g26.orig/drivers/serial/sa1100.c	2008-04-13 10:43:35.000000000 -070=
0
+++ g26/drivers/serial/sa1100.c	2008-04-13 10:57:07.000000000 -0700
@@ -884,6 +884,7 @@ static struct platform_driver sa11x0_ser
 	.resume		=3D sa1100_serial_resume,
 	.driver		=3D {
 		.name	=3D "sa11x0-uart",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -917,3 +918,4 @@ MODULE_AUTHOR("Deep Blue Solutions Ltd")
 MODULE_DESCRIPTION("SA1100 generic serial port driver $Revision: 1.50 =
$");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV_MAJOR(SERIAL_SA1100_MAJOR);
+MODULE_ALIAS("platform:sa11x0-uart");
--- g26.orig/drivers/serial/sc26xx.c	2008-04-13 10:43:35.000000000 -070=
0
+++ g26/drivers/serial/sc26xx.c	2008-04-13 10:57:14.000000000 -0700
@@ -732,6 +732,7 @@ static struct platform_driver sc26xx_dri
 	.remove	=3D __devexit_p(sc26xx_driver_remove),
 	.driver	=3D {
 		.name	=3D "SC26xx",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -753,3 +754,4 @@ MODULE_AUTHOR("Thomas Bogend=F6rfer");
 MODULE_DESCRIPTION("SC681/SC2692 serial driver");
 MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:SC26xx");
--- g26.orig/drivers/serial/sh-sci.c	2008-04-13 10:43:35.000000000 -070=
0
+++ g26/drivers/serial/sh-sci.c	2008-04-13 10:46:32.000000000 -0700
@@ -1552,3 +1552,4 @@ module_init(sci_init);
 module_exit(sci_exit);
=20
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sh-sci");
--- g26.orig/drivers/serial/uartlite.c	2008-04-13 10:48:05.000000000 -0=
700
+++ g26/drivers/serial/uartlite.c	2008-04-13 10:59:04.000000000 -0700
@@ -561,6 +561,9 @@ static int __devexit ulite_remove(struct
 	return ulite_release(&pdev->dev);
 }
=20
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:uartlite");
+
 static struct platform_driver ulite_platform_driver =3D {
 	.probe	=3D ulite_probe,
 	.remove	=3D __devexit_p(ulite_remove),
--- g26.orig/drivers/serial/vr41xx_siu.c	2008-04-13 10:43:35.000000000 =
-0700
+++ g26/drivers/serial/vr41xx_siu.c	2008-04-13 10:46:32.000000000 -0700
@@ -960,3 +960,6 @@ static void __exit vr41xx_siu_exit(void)
=20
 module_init(vr41xx_siu_init);
 module_exit(vr41xx_siu_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:SIU");
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
