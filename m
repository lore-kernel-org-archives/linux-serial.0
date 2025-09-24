Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF973002A9;
	Wed, 24 Sep 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728281; cv=none; b=JrluzxmodAt54nORlycO6Qxp7kbRM6PiAIcKLRog5eQ5xpNrrjLRVTC/QWbALOG11Xf/k0+/ClcE/haolujGkkp7hCyJQj3zVY2/sCuNXOOiz5EJx7It+Z1wKFN3oWC0X3VJdbycODNNzGjzMM26owKvxREYIK9W+xggYAJo6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728281; c=relaxed/simple;
	bh=tHqGA1GDVcSmHIm41vaYG0ksf7PJlfQfkkuq3ezPPh8=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=FLhqCKz7E0NTGQg4YErC9sc1WegRxCr6N2lHLugQlfRoIVZtMoLp0Zhsw7FNGyMMg+uxxalvgG1JNCOFuhQ1k/iWGiCjiDlQWzhSQuKmubGU4QYkbOTd3/e5ubXkx2YNmshqDzl+b+7vrIx9VAmQIUMPdF/cWdiXnKX+M/A5RWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=LSvnmykJ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="LSvnmykJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=iti813zpcSxmyVlX1x5X73HdGQLNLqDsHQY26dzysMw=; b=LSvnmykJVxpi8gfo+CsSK81jME
	qNm6tCgjNcos6L4WJh6uBZprzmyGPSFESOS6PWEn3Yi61Oldt579J1rmhE4abrXghYnhLY2g0Bar3
	zftEj2/BuARhl7Cah3vMuF255nZauhdba3u69/Opg7UlYPAdP22RZzEi6LVNVR0koZXY=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZ6-0000RT-PX; Wed, 24 Sep 2025 11:37:57 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:35 -0400
Message-Id: <20250924153740.806444-11-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924153740.806444-1-hugo@hugovil.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 10/15] serial: sc16is7xx: use KBUILD_MODNAME
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

There is no need to redefine the driver name. Use KBUILD_MODNAME and get
rid of DRV_NAME altogether.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c     | 4 ++--
 drivers/tty/serial/sc16is7xx.h     | 1 -
 drivers/tty/serial/sc16is7xx_i2c.c | 4 ++--
 drivers/tty/serial/sc16is7xx_spi.c | 4 ++--
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 406dd7cf81fe3..d1a9fa26e9bdb 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -360,7 +360,7 @@ static DEFINE_IDA(sc16is7xx_lines);
 
 static struct uart_driver sc16is7xx_uart = {
 	.owner		= THIS_MODULE,
-	.driver_name    = SC16IS7XX_NAME,
+	.driver_name    = KBUILD_MODNAME,
 	.dev_name	= "ttySC",
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
@@ -1810,4 +1810,4 @@ module_exit(sc16is7xx_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jon Ringle <jringle@gridpoint.com>");
-MODULE_DESCRIPTION("SC16IS7xx tty serial core driver");
+MODULE_DESCRIPTION(KBUILD_MODNAME " tty serial core driver");
diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
index afb784eaee45b..9c584d6d35932 100644
--- a/drivers/tty/serial/sc16is7xx.h
+++ b/drivers/tty/serial/sc16is7xx.h
@@ -8,7 +8,6 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
-#define SC16IS7XX_NAME		"sc16is7xx"
 #define SC16IS7XX_MAX_PORTS	2 /* Maximum number of UART ports per IC. */
 
 struct device;
diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
index cd7de9e057b85..699376c3b3a54 100644
--- a/drivers/tty/serial/sc16is7xx_i2c.c
+++ b/drivers/tty/serial/sc16is7xx_i2c.c
@@ -52,7 +52,7 @@ MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
 
 static struct i2c_driver sc16is7xx_i2c_driver = {
 	.driver = {
-		.name		= SC16IS7XX_NAME,
+		.name		= KBUILD_MODNAME,
 		.of_match_table	= sc16is7xx_dt_ids,
 	},
 	.probe		= sc16is7xx_i2c_probe,
@@ -63,5 +63,5 @@ static struct i2c_driver sc16is7xx_i2c_driver = {
 module_i2c_driver(sc16is7xx_i2c_driver);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SC16IS7xx I2C interface driver");
+MODULE_DESCRIPTION(KBUILD_MODNAME " interface driver");
 MODULE_IMPORT_NS("SERIAL_NXP_SC16IS7XX");
diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc16is7xx_spi.c
index 20d736b657b17..7e76d0e38da7d 100644
--- a/drivers/tty/serial/sc16is7xx_spi.c
+++ b/drivers/tty/serial/sc16is7xx_spi.c
@@ -75,7 +75,7 @@ MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
 
 static struct spi_driver sc16is7xx_spi_driver = {
 	.driver = {
-		.name		= SC16IS7XX_NAME,
+		.name		= KBUILD_MODNAME,
 		.of_match_table	= sc16is7xx_dt_ids,
 	},
 	.probe		= sc16is7xx_spi_probe,
@@ -86,5 +86,5 @@ static struct spi_driver sc16is7xx_spi_driver = {
 module_spi_driver(sc16is7xx_spi_driver);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SC16IS7xx SPI interface driver");
+MODULE_DESCRIPTION(KBUILD_MODNAME " interface driver");
 MODULE_IMPORT_NS("SERIAL_NXP_SC16IS7XX");
-- 
2.39.5

