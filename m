Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB3369D67;
	Tue, 19 May 2026 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222924; cv=none; b=ZjxkdKtaMWEJyYv9zm6kBLP+MedbIs3zR5bJFI5HuAk/rDhwsdB1XfalvAarwMthBD4Ozi8TKU104Fd2Nn2lhcfwvOwJ2WmCPTDnoXqtJ4iW2URsl4dIhGqNfUlNPaQmPQ8Dmuev3lV70cNXGViPKinYsSnYQ0WOFis7E6SWXyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222924; c=relaxed/simple;
	bh=eZX9oBQeO1SgCJxkKcJfob423b57GKJhBKyr5Kd6Km8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tlwM8ajO2AICim369xShEQh32ahHpWONiRJnHuyoHFByE8Xt5no0hudCRTjbQ22Wnkoz8/yhJh3pjI4L/AMpP6wiYkmlaFMHsesGT+Lozs4HPHwVWLaCZfqRuIR/wWfAFcCq3NKQd+wqLsBI/ZZsGlPgTujDpzi/giFmyn9L8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYApbyfl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYApbyfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951411F000E9;
	Tue, 19 May 2026 20:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222923;
	bh=1j2HKRmxYDM7HOrPlosbj/CcPPkEZLPoQ/0gD7q1zls=;
	h=From:To:Cc:Subject:Date;
	b=aYApbyflaK6hjIrZgOlCr1Vis5aQb/D3TDXxJhjGy0WDDJfGIf5tiEmDJCqB9+1f8
	 ZFz72Xp5L8nyJcB8vrKHFxMe+QkstpKGFcaeWuUV6DZQ1Ps27CSNpvLBry3DORbzN9
	 jNF6j+/l9V0FaPmM4UsI1uBS/oKmodjw4WH2oyIeuVo99K+AsqhPrq6pIcAoHD0JVl
	 Avtoktlc+4sCkpBj2ipGo5RGinnrA9IGf7So5Q9nc72eY0qcUBTMubXtge8Xt4Kex7
	 1J93079sUnZVbJLOgkK5vCgEft1eYFDeEXZj2tPjs+/dhHnGKbRvdTVQgPR+uw+ZB5
	 36HJAx/xlaSTA==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: max310x: fix I2C-only build
Date: Tue, 19 May 2026 22:34:25 +0200
Message-Id: <20260519203506.1341241-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Allowing the driver to be built when CONFIG_SPI_MASTER is turned off
now causes build failures:

drivers/tty/serial/max310x.c: In function 'max310x_uart_init':
drivers/tty/serial/max310x.c:1737:32: error: 'max310x_spi_driver' undeclared (first use in this function); did you mean 'max310x_i2c_driver'?
 1737 |         spi_unregister_driver(&max310x_spi_driver);
      |                                ^~~~~~~~~~~~~~~~~~
      |                                max310x_i2c_driver
drivers/tty/serial/max310x.c:1737:32: note: each undeclared identifier is reported only once for each function it appears in
drivers/tty/serial/max310x.c:1740:1: error: label 'err_spi_register' defined but not used [-Werror=unused-label]
 1740 | err_spi_register:
      | ^~~~~~~~~~~~~~~~
drivers/tty/serial/max310x.c: At top level:
drivers/tty/serial/max310x.c:1502:29: error: 'regcfg' defined but not used [-Werror=unused-variable]
 1502 | static struct regmap_config regcfg = {
      |                             ^~~~~~

While fixing this, I ran into another problem with I2C=m, which
previously would just not use I2C support.

Fix the #ifdef checks to handle all combinations correctly, and
change the Kconfig dependency to ensure that the driver cannot
be built-in when I2C=m.

Fixes: 20ffe4b3330a ("serial: max310x: allow driver to be built with SPI or I2C")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/Kconfig   |  1 +
 drivers/tty/serial/max310x.c | 40 +++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 811250bbbd39..b9b40e80ea81 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -323,6 +323,7 @@ config SERIAL_MAX3100
 config SERIAL_MAX310X
 	tristate "MAX310X support"
 	depends on SPI_MASTER || I2C
+	depends on I2C || !I2C
 	select SERIAL_CORE
 	select REGMAP_SPI if SPI_MASTER
 	select REGMAP_I2C if I2C
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5168490a1cbb..042ae962c1f6 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1499,6 +1499,20 @@ static const struct of_device_id __maybe_unused max310x_dt_ids[] = {
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
+#ifdef CONFIG_SPI_MASTER
 static struct regmap_config regcfg = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -1514,20 +1528,6 @@ static struct regmap_config regcfg = {
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
@@ -1598,7 +1598,7 @@ static struct spi_driver max310x_spi_driver = {
 };
 #endif
 
-#ifdef CONFIG_I2C
+#if IS_ENABLED(CONFIG_I2C)
 static int max310x_i2c_extended_reg_enable(struct device *dev, bool enable)
 {
 	return 0;
@@ -1724,7 +1724,7 @@ static int __init max310x_uart_init(void)
 		goto err_spi_register;
 #endif
 
-#ifdef CONFIG_I2C
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&max310x_i2c_driver);
 	if (ret)
 		goto err_i2c_register;
@@ -1732,12 +1732,14 @@ static int __init max310x_uart_init(void)
 
 	return 0;
 
-#ifdef CONFIG_I2C
+#if IS_ENABLED(CONFIG_I2C)
 err_i2c_register:
+#endif
+#ifdef CONFIG_SPI_MASTER
 	spi_unregister_driver(&max310x_spi_driver);
+err_spi_register:
 #endif
 
-err_spi_register:
 	uart_unregister_driver(&max310x_uart);
 
 	return ret;
@@ -1746,7 +1748,7 @@ module_init(max310x_uart_init);
 
 static void __exit max310x_uart_exit(void)
 {
-#ifdef CONFIG_I2C
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&max310x_i2c_driver);
 #endif
 
-- 
2.39.5

