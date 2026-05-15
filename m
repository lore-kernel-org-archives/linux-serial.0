Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008A3E16AF;
	Fri, 15 May 2026 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869953; cv=none; b=iBRfQG3qFO6mmsCoRlB4a4Mx9M9O6LV3CduRyGYLLrBYHRaKPwkrbz8XI1Q4uBuNWh5WBCZtJWZcAi3CoDThUc3uPtvUAmz95G9cUb0+mDNa+833ydLFbtW3ASQqn+/0Y0LrLTuSZWpyO9HLBqNw0gXYuqpPjEPqEAILgsv4i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869953; c=relaxed/simple;
	bh=Mi5/TRu4Afi9KPgy0POhztDSq/pXN2DaIZqNIV/Bwc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fLlVzSYLWF8xJDoWOFZTb/qOB3Vcby+fnW3Jk19AGsVyJdn3AAM/S2Jebd7abmWwNSN4fGRKbnunfCryCIv2KAlfq1gyfKMpbt7Ht2T14p6Sj0XD+5C5WqVsY8/O1Hsdm+pWdIxctAVn5TiwB888wnSZ3R1ltSABS2O6q9rZIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=xMxP5Tdy; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="xMxP5Tdy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=ACzJMNCGYpDw6iLolP6eUBc4xbXZlDvQUoci6qsRFf0=; b=xMxP5TdyLVYHNv8TXCwHh3ZVbl
	FrTJi3tmiLOnNfk6zxx7HUOnJjJ5S4RjI5OGlIg3K5vZhXqRfgesDNra2Mg2DpXfs8cLrS8rBzvoR
	vzF+2Tup1u+wWgCZavOBr9y5/hrQv+6tFl7ieK4oBhbEXeythKXN6ZucYrt85V/BoIRQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wNxKe-000000006pe-0NSY;
	Fri, 15 May 2026 14:32:20 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2] serial: max310x: fix compile errors if CONFIG_SPI_MASTER is disabled
Date: Fri, 15 May 2026 14:30:58 -0400
Message-ID: <20260515183217.3554037-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Since commit 20ffe4b3330a8 ("serial: max310x: allow driver to be built with
SPI or I2C"), if I2C is enabled and SPI_MASTER is disabled, we have these
compile errors:

  drivers/tty/serial/max310x.c: In function 'max310x_uart_init':
  drivers/tty/serial/max310x.c: error: 'max310x_spi_driver' undeclared...
  drivers/tty/serial/max310x.c: In function ‘max310x_uart_init’:
  drivers/tty/serial/max310x.c: error: label ‘err_spi_register’
  defined but not used...
  drivers/tty/serial/max310x.c: error: ‘regcfg’ defined but not used

Fix by properly encapsulating i2c/spi code/variables in their respective
context with IS_ENABLED() macros for CONFIG_I2C and CONFIG_SPI_MASTER.

Fixes: 20ffe4b3330a8 ("serial: max310x: allow driver to be built with SPI or I2C")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605121847.N9DVLNg2-lkp@intel.com/
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
note: not Cc-ing stable as the commit is still in tty-next, and even if the
errors originate from original commit that added I2C support, they were not
trigerred because the driver could not be selected/compiled if
CONFIG_SPI_MASTER was disabled.

Changes for v2:
- replace #ifdef with #if IS_ENABLED() to suppoirt both built-in and modules
  options
---
 drivers/tty/serial/max310x.c | 48 +++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 9f423b3b4201d..bad5329a0c84c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
+#include <linux/kconfig.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -1507,6 +1508,21 @@ static const struct of_device_id __maybe_unused max310x_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, max310x_dt_ids);
 
+static const char *max310x_regmap_name(u8 port_id)
+{
+	switch (port_id) {
+	case 0:	return "port0";
+	case 1:	return "port1";
+	case 2:	return "port2";
+	case 3:	return "port3";
+	default:
+		WARN_ON(true);
+		return NULL;
+	}
+}
+
+#if IS_ENABLED(CONFIG_SPI_MASTER)
+
 static struct regmap_config regcfg = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -1522,20 +1538,6 @@ static struct regmap_config regcfg = {
 	.max_raw_write = MAX310X_FIFO_SIZE,
 };
 
-static const char *max310x_regmap_name(u8 port_id)
-{
-	switch (port_id) {
-	case 0:	return "port0";
-	case 1:	return "port1";
-	case 2:	return "port2";
-	case 3:	return "port3";
-	default:
-		WARN_ON(true);
-		return NULL;
-	}
-}
-
-#ifdef CONFIG_SPI_MASTER
 static int max310x_spi_extended_reg_enable(struct device *dev, bool enable)
 {
 	struct max310x_port *s = dev_get_drvdata(dev);
@@ -1606,7 +1608,8 @@ static struct spi_driver max310x_spi_driver = {
 };
 #endif
 
-#ifdef CONFIG_I2C
+#if IS_ENABLED(CONFIG_I2C)
+
 static int max310x_i2c_extended_reg_enable(struct device *dev, bool enable)
 {
 	return 0;
@@ -1726,13 +1729,13 @@ static int __init max310x_uart_init(void)
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_SPI_MASTER
+#if IS_ENABLED(CONFIG_SPI_MASTER)
 	ret = spi_register_driver(&max310x_spi_driver);
 	if (ret)
 		goto err_spi_register;
 #endif
 
-#ifdef CONFIG_I2C
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&max310x_i2c_driver);
 	if (ret)
 		goto err_i2c_register;
@@ -1740,12 +1743,13 @@ static int __init max310x_uart_init(void)
 
 	return 0;
 
-#ifdef CONFIG_I2C
+#if IS_ENABLED(CONFIG_I2C)
 err_i2c_register:
-	spi_unregister_driver(&max310x_spi_driver);
 #endif
-
+#if IS_ENABLED(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&max310x_spi_driver);
 err_spi_register:
+#endif
 	uart_unregister_driver(&max310x_uart);
 
 	return ret;
@@ -1754,11 +1758,11 @@ module_init(max310x_uart_init);
 
 static void __exit max310x_uart_exit(void)
 {
-#ifdef CONFIG_I2C
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&max310x_i2c_driver);
 #endif
 
-#ifdef CONFIG_SPI_MASTER
+#if IS_ENABLED(CONFIG_SPI_MASTER)
 	spi_unregister_driver(&max310x_spi_driver);
 #endif
 

base-commit: 16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
-- 
2.47.3

