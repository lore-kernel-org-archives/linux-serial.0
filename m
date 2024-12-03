Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55505192D98
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231854; cv=none; b=aTA/kDdJlgwuLx1Xg0vGOcLQVppQa7Pe93D7llxaLF+6vjnTIHqzM7fa2U+7HZYydVP/JISbo1izCLjBbUlH/HmUN4oH4bV6uWVZnfd3RHuwtcRf7RjX7sjVDNGWK/rr7sD9M1bXFXx0CL4nIDKOX8SHtX8Gc8eBheC6M9rgudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231854; c=relaxed/simple;
	bh=30opDZZU1fj4UyhQKi2nibfpWYPfAGmJ8l1Av16HoTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SogHDNdRiY8sth2VM0BPTYjU34QVCdEa/tLMIoQTIinAm/yPC4maG72HUsjfhKC1V6+QX7ctjUOZIf+G8F6qaSlbSFZNTlmP+x4aWKMGgqE8oS6cOn9tTqKTYGIHilfYAqIoX54PdGFHwOPhCPqiXzKtJ6fUBlzpWjGyckaJGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4Y2h5h0tZZz3j1b8; Tue,  3 Dec 2024 14:17:27 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2] serial: altera_jtaguart: Use KBUILD_MODNAME
Date: Tue,  3 Dec 2024 14:17:27 +0100
Message-Id: <20241203131727.9078-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20241203131430.7094-1-tklauser@distanz.ch>
References: <20241203131430.7094-1-tklauser@distanz.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

There is no need to redefine the driver name. Use KBUILD_MODNAME and get
rid of DRV_NAME altogether.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/linux-serial/2024120337-unending-renewed-8e7e@gregkh/
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
v2: actually get rid of DRV_NAME definition

 drivers/tty/serial/altera_jtaguart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index b9c3c3bed0c1..a9dd083d45d1 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -24,8 +24,6 @@
 #include <linux/io.h>
 #include <linux/altera_jtaguart.h>
 
-#define DRV_NAME "altera_jtaguart"
-
 /*
  * Altera JTAG UART register definitions according to the Altera JTAG UART
  * datasheet: https://www.altera.com/literature/hb/nios2/n2cpu_nii51009.pdf
@@ -365,7 +363,7 @@ OF_EARLYCON_DECLARE(juart, "altr,juart-1.0", altera_jtaguart_earlycon_setup);
 
 static struct uart_driver altera_jtaguart_driver = {
 	.owner		= THIS_MODULE,
-	.driver_name	= "altera_jtaguart",
+	.driver_name	= KBUILD_MODNAME,
 	.dev_name	= "ttyJ",
 	.major		= ALTERA_JTAGUART_MAJOR,
 	.minor		= ALTERA_JTAGUART_MINOR,
@@ -451,7 +449,7 @@ static struct platform_driver altera_jtaguart_platform_driver = {
 	.probe	= altera_jtaguart_probe,
 	.remove = altera_jtaguart_remove,
 	.driver	= {
-		.name		= DRV_NAME,
+		.name		= KBUILD_MODNAME,
 		.of_match_table	= of_match_ptr(altera_jtaguart_match),
 	},
 };
@@ -481,4 +479,4 @@ module_exit(altera_jtaguart_exit);
 MODULE_DESCRIPTION("Altera JTAG UART driver");
 MODULE_AUTHOR("Thomas Chou <thomas@wytron.com.tw>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
-- 
2.47.1

