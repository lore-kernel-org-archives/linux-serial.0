From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH 5/8] altera_uart: Make it possible to use Altera UART and
 8250 ports together
Date: Fri, 1 Oct 2010 17:22:07 +0400
Message-ID: <20101001132207.GE25897@oksana.dev.rtsoft.ru>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33073 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339Ab0JANW3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 09:22:29 -0400
Content-Disposition: inline
In-Reply-To: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

This fixes tty name and major number conflicts. The major number
204 is used across many platform-specific serial drivers, so we
use that.

Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
Acked-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/serial/altera_uart.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/altera_uart.c b/drivers/serial/altera_uart.c
index f1985aa..99e007f 100644
--- a/drivers/serial/altera_uart.c
+++ b/drivers/serial/altera_uart.c
@@ -28,6 +28,7 @@
 #include <linux/altera_uart.h>
 
 #define DRV_NAME "altera_uart"
+#define SERIAL_ALTERA_MAJOR 204
 
 /*
  * Altera UART register definitions according to the Nios UART datasheet:
@@ -471,7 +472,7 @@ static int __init altera_uart_console_setup(struct console *co, char *options)
 static struct uart_driver altera_uart_driver;
 
 static struct console altera_uart_console = {
-	.name	= "ttyS",
+	.name	= "ttyAL",
 	.write	= altera_uart_console_write,
 	.device	= uart_console_device,
 	.setup	= altera_uart_console_setup,
@@ -502,8 +503,8 @@ console_initcall(altera_uart_console_init);
 static struct uart_driver altera_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= DRV_NAME,
-	.dev_name	= "ttyS",
-	.major		= TTY_MAJOR,
+	.dev_name	= "ttyAL",
+	.major		= SERIAL_ALTERA_MAJOR,
 	.minor		= 64,
 	.nr		= CONFIG_SERIAL_ALTERA_UART_MAXPORTS,
 	.cons		= ALTERA_UART_CONSOLE,
@@ -603,3 +604,4 @@ MODULE_DESCRIPTION("Altera UART driver");
 MODULE_AUTHOR("Thomas Chou <thomas@wytron.com.tw>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS_CHARDEV_MAJOR(SERIAL_ALTERA_MAJOR);
-- 
1.7.0.5

