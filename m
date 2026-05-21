Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65563806A1;
	Thu, 21 May 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377631; cv=none; b=sD+lcXAfrghKrf3GOM6bPQHSCkCOO7PuUYYSQqcnGiyRUEtYIcPZq27vsyNuaPBFwamYE0DQo+pif2qRTWYttDMiXCE4Cag2r0ojW9nqIIuzbFSk4QVi67MaQphI0y+mrdqdm024VsRmgRlkX3nZAWG5YUdTYPZUd6PpZk+wh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377631; c=relaxed/simple;
	bh=V8mssCa6B2H7gbxf3NdF5TiDoNSvHSyKMCLv0C0Gc1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uZjETlqotkuQlre/lzJqqCgoYWF7Ds2qenpex7tJXb2JI46Vd9u+S1hpYpQgJDuh0HtCrqNxTALMTWAu4+uzQJS+Ttd91KYEguFGf2ixvM0iGcByw50hj2XHHJR0Aru/7Pil23m2uNiN3bOe/LZe1yT5PfQ3xXk/jlYDyWxF6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ztuANXj5; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ztuANXj5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=JVJJsbuC0NVA1dp6yk1AJj/5rBFtcOSY1MtDq77fQM8=; b=ztuANXj5B/pjji+B+JIw7JA+wj
	5VYSRJWh0k1EQVtK7FASMBgjuUu4qIOfsCBZ7c8WXZ9ptSlHo+tIS+8uRhoQwqtQ/O42fQjDUgsbX
	0n2N2/NJNgVaLU4eKp6w6sVjFlgRchJbz0t/wA7NhtD1GQefIoVOtLe/ix97tddIv3YA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ5P2-000000001XZ-2tTu;
	Thu, 21 May 2026 11:33:41 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3] serial: max310x: fix compile errors if CONFIG_SPI_MASTER is disabled
Date: Thu, 21 May 2026 11:33:29 -0400
Message-ID: <20260521153333.2336642-1-hugo@hugovil.com>
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

Also fix link failure with SERIAL_MAX310X=y and I2C=m by modifying Kconfig
depends.

Fixes: 20ffe4b3330a8 ("serial: max310x: allow driver to be built with SPI or I2C")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605121847.N9DVLNg2-lkp@intel.com/
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
note: not Cc-ing stable as the commit is still in tty-next, and even if the
errors originate from original commit that added I2C support, they were not
trigerred because the driver could not be selected/compiled if
CONFIG_SPI_MASTER was disabled.

Changes for v3:
- Fix link failure with SERIAL_MAX310X=y and I2C=m (Arnd Bergmann)

Changes for v2:
- replace #ifdef with #if IS_ENABLED() to suppoirt both built-in and modules
  options
---
 drivers/tty/serial/Kconfig   |  2 +-
 drivers/tty/serial/max310x.c | 48 +++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f834e5d292fd7..4accbfa75074c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -321,7 +321,7 @@ config SERIAL_MAX3100
 
 config SERIAL_MAX310X
 	tristate "MAX310X support"
-	depends on SPI_MASTER || I2C
+	depends on (SPI_MASTER && !I2C) || I2C
 	select SERIAL_CORE
 	select REGMAP_SPI if SPI_MASTER
 	select REGMAP_I2C if I2C
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

