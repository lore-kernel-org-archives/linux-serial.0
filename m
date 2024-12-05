Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CF1D54F4
	for <linux-serial@vger.kernel.org>; Thu,  5 Dec 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389929; cv=none; b=ddX5r1OsrORfDiX1wWDJCq7P9UnvujATY6L0B0W6u0QFzslW3zqzCy4ZAMGTZLIkRxOC7d5ZPK1mT8N9l2M5S6itOCeQzj2sPgz1wxtCBADnG9ABOnN1yRw6HXzXqGf2cdKQ1mHa7vqpZUjgnX26R8GMWWOBiQMNBG5YOYcP/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389929; c=relaxed/simple;
	bh=XnWT7P98gZo4YtdUnZhQORL+DpBX3vkudEFPuNlSmgE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dKGJfBVydaNAsVGqCuW0+NnqZy2gXG9QS4ktghorlyHEoBfr7uvuXvq+MTtmCcbuSWqj9re1utbWcUbBb64grcztBs8FNYFTeNml5IdXKqVU0+pfJgp25tMl7QQC4G6nSVzWBSyqwzaCnGvz86hjdIF4QbPEzeKp8fC1WMJFUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4Y3pYG72wqz3j1C8; Thu,  5 Dec 2024 10:11:38 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] serial: altera_uart: Use KBUILD_MODNAME
Date: Thu,  5 Dec 2024 10:11:38 +0100
Message-Id: <20241205091138.25894-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

There is no need to redefine the driver name. Use KBUILD_MODNAME and get
rid of DRV_NAME altogether.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_uart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index c94655453c33..1759137121cc 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -24,7 +24,6 @@
 #include <linux/io.h>
 #include <linux/altera_uart.h>
 
-#define DRV_NAME "altera_uart"
 #define SERIAL_ALTERA_MAJOR 204
 #define SERIAL_ALTERA_MINOR 213
 
@@ -518,7 +517,7 @@ OF_EARLYCON_DECLARE(uart, "altr,uart-1.0", altera_uart_earlycon_setup);
  */
 static struct uart_driver altera_uart_driver = {
 	.owner		= THIS_MODULE,
-	.driver_name	= DRV_NAME,
+	.driver_name	= KBUILD_MODNAME,
 	.dev_name	= "ttyAL",
 	.major		= SERIAL_ALTERA_MAJOR,
 	.minor		= SERIAL_ALTERA_MINOR,
@@ -619,7 +618,7 @@ static struct platform_driver altera_uart_platform_driver = {
 	.probe	= altera_uart_probe,
 	.remove = altera_uart_remove,
 	.driver	= {
-		.name		= DRV_NAME,
+		.name		= KBUILD_MODNAME,
 		.of_match_table	= of_match_ptr(altera_uart_match),
 	},
 };
@@ -649,5 +648,5 @@ module_exit(altera_uart_exit);
 MODULE_DESCRIPTION("Altera UART driver");
 MODULE_AUTHOR("Thomas Chou <thomas@wytron.com.tw>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
 MODULE_ALIAS_CHARDEV_MAJOR(SERIAL_ALTERA_MAJOR);
-- 
2.47.1

