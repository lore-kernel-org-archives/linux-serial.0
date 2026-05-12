Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E78375AB8;
	Tue, 12 May 2026 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599688; cv=none; b=G8FoMQg56YnhH8htC4UERj9UjtX1L2Wwd1kuNKk2OtW/Wc8Px1k4k/obEUq0KgOm/7vdajgsSqojn+wxKw72OsGpiaXloSYhOiP9xZ8VZeFgw+CwbdTIM61R/oJrYQSzq47vPgqrsHrtmoZUDRJmd+JBJvBdvix1vbCi26xFW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599688; c=relaxed/simple;
	bh=r+sXz3uH5sQZpNp/YoIK6kdyiYZrgn0zeWL6OApwdcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rNBi+RO6sm7D1qR2f2z+T+WPwjBVuAwAIlXltCVwPOVt10A8FC0DI7Y53z/59T7YKQdua3Me9shsPP+7rOSRRrI8SnPrC8V1bb4JqapdQS7grJjE+2rBh9bvFJZ6xS67RwEDmC1XXjXBcl6TJ0+/kodRSQgXNs49X+A7cXdPZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=A8aZzBUr; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="A8aZzBUr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=hT8uGlRMRjMmBXxX1W6Ax5Q/FoO092OZqWtzvemA05E=; b=A8aZzBUrPkgIt3KxtLJ7elxqdy
	y+Wr1cy5ViR/463egONOi0/GjPJqqs9XCLtzGuQX481nZzlLENesacZk9ykIvdEF3WVBfb/OXjthR
	i/Rw7z3Osuf/GfcAVHh1k6rVb14DaoJcdAHJNFHilQvyEAV8Y8mT/8wjDsK/gus/T/Yw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wMp1c-000000004AI-02kR;
	Tue, 12 May 2026 11:28:00 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	linux-serial@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: max310x: fix compile errors if CONFIG_SPI_MASTER is disabled
Date: Tue, 12 May 2026 11:27:45 -0400
Message-ID: <20260512152749.1767622-1-hugo@hugovil.com>
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
context with CONFIG_I2C and CONFIG_SPI_MASTER.

Fixes: 20ffe4b3330a8 ("serial: max310x: allow driver to be built with SPI or I2C")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605121847.N9DVLNg2-lkp@intel.com/
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
note: not Cc-ing stable as the commit is still in tty-next, and even if the
errors originate from original commit that added I2C support, they were not
trigerred because the driver could not be selected/compiled if
CONFIG_SPI_MASTER was disabled.
---
 drivers/tty/serial/max310x.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 9f423b3b4201d..8380fa1b0c0eb 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1507,6 +1507,21 @@ static const struct of_device_id __maybe_unused max310x_dt_ids[] = {
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
+
 static struct regmap_config regcfg = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -1522,20 +1537,6 @@ static struct regmap_config regcfg = {
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
@@ -1742,10 +1743,11 @@ static int __init max310x_uart_init(void)
 
 #ifdef CONFIG_I2C
 err_i2c_register:
-	spi_unregister_driver(&max310x_spi_driver);
 #endif
-
+#ifdef CONFIG_SPI_MASTER
+	spi_unregister_driver(&max310x_spi_driver);
 err_spi_register:
+#endif
 	uart_unregister_driver(&max310x_uart);
 
 	return ret;

base-commit: 16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
-- 
2.47.3

