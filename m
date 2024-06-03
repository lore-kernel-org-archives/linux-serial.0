Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85512C478;
	Mon,  3 Jun 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418269; cv=none; b=gdN2wNjpVbU7gCQno+en1SlBqaFcePVkd9LKSATFSnphTQIIt16ExK5rQJWmTBBDPFNKtqTcj7mG+XW+u33NQE8ES2cdLYbWUsiNbbiUHMsfOzjbLpwZ/ilNoAxnubXoyAc7CgDuAprFZq1lB/WM8EFxDR7+1T551CVT+vDYyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418269; c=relaxed/simple;
	bh=RsZDNYZFr1sN1TmKUqEFg9ql+dm/ol7ON0v/8wO17Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IaaS21sp2R6h8/4iGWGDoXahAE+eZMEIuV5KhE2INcB5y9siCeqd/7nC6C9qblhWyyv89vVwYIr6LK2M/ClM79eHeC30HfkB/AaV/Eu+0FGaecfE0XSFRx8KDZVqu/ZFs67o9Dt5yc3fxybXfuiml/c8CTFc8PC5y4e+PpBD7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=K3eZgebq; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="K3eZgebq"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0C34F3FAE8;
	Mon,  3 Jun 2024 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717418259;
	bh=lXgAgJh56208citeJjAWVQZbibVrADnZ2ctRoypgJtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=K3eZgebqwPs6PmTcDznpCJ8RH2M6Np5F/p6En0baCYlgVpOwAwBWWk+xAs961O43I
	 +64GU80bCddCSIj4WDVcXHDx5lSKdL2yyWgT33tcKuQUpNY4t0Dhkej0sPLleyFUKZ
	 UKMN5oU1zrPEorBpBo+Nd1iEMoUWZfGsa9L2iqwbsz2mjzfhI5JB5QvuXUGtWTOox1
	 01Ef1YIiWylP0URJ0mJzMpXdkRrTWz2bMhLfIgYdWOQ1jgY5lUq+RDVlI0S1GvPUZO
	 9rns/V0mop0xryMoRRC8K0MieZFbEPzu13lCD36Cch4rxSHe50a+GVPehvIJlp86jv
	 gcs6QQVsiCGwg==
From: Hui Wang <hui.wang@canonical.com>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	hui.wang@canonical.com
Subject: [PATCH 2/2] serial: sc16is7xx: setup reset pin if it is defined in device tree
Date: Mon,  3 Jun 2024 20:37:10 +0800
Message-Id: <20240603123710.649549-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603123710.649549-1-hui.wang@canonical.com>
References: <20240603123710.649549-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain designs connect a gpio to the reset pin, and the reset pin
needs to be setup correctly before accessing the chip.

Here adding a function to handle the reset pin. This change has no
impact if there is no reset_gpios defined in the device tree.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/tty/serial/sc16is7xx.c     | 22 ++++++++++++++++++++++
 drivers/tty/serial/sc16is7xx.h     |  2 ++
 drivers/tty/serial/sc16is7xx_i2c.c |  2 ++
 drivers/tty/serial/sc16is7xx_spi.c |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index bf0065d1c8e9..53bfb603b03c 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -19,6 +19,7 @@
 #include <linux/kthread.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_gpio.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/sched.h>
@@ -1467,6 +1468,27 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
 
+void sc16is7xx_setup_reset_pin(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	int reset_gpio, err;
+
+	reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
+	if (!gpio_is_valid(reset_gpio))
+		return;
+
+	err = devm_gpio_request_one(dev, reset_gpio, GPIOF_OUT_INIT_LOW,
+				    "sc16is7xx-reset");
+	if (err) {
+		dev_err(dev, "failed to request sc16is7xx-reset-gpios: %d\n", err);
+		return;
+	}
+
+	/* Deassert the reset pin */
+	gpio_set_value_cansleep(reset_gpio, 1);
+}
+EXPORT_SYMBOL_GPL(sc16is7xx_setup_reset_pin);
+
 int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		    struct regmap *regmaps[], int irq)
 {
diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
index afb784eaee45..f4ae114cc41a 100644
--- a/drivers/tty/serial/sc16is7xx.h
+++ b/drivers/tty/serial/sc16is7xx.h
@@ -33,6 +33,8 @@ const char *sc16is7xx_regmap_name(u8 port_id);
 
 unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id);
 
+void sc16is7xx_setup_reset_pin(struct device *dev);
+
 int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		    struct regmap *regmaps[], int irq);
 
diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
index 3ed47c306d85..9833c3b935c2 100644
--- a/drivers/tty/serial/sc16is7xx_i2c.c
+++ b/drivers/tty/serial/sc16is7xx_i2c.c
@@ -21,6 +21,8 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
 	if (!devtype)
 		return dev_err_probe(&i2c->dev, -ENODEV, "Failed to match device\n");
 
+	sc16is7xx_setup_reset_pin(&i2c->dev);
+
 	memcpy(&regcfg, &sc16is7xx_regcfg, sizeof(struct regmap_config));
 
 	for (i = 0; i < devtype->nr_uart; i++) {
diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc16is7xx_spi.c
index 73df36f8a7fd..ce38561faaf0 100644
--- a/drivers/tty/serial/sc16is7xx_spi.c
+++ b/drivers/tty/serial/sc16is7xx_spi.c
@@ -38,6 +38,8 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 	if (!devtype)
 		return dev_err_probe(&spi->dev, -ENODEV, "Failed to match device\n");
 
+	sc16is7xx_setup_reset_pin(&spi->dev);
+
 	memcpy(&regcfg, &sc16is7xx_regcfg, sizeof(struct regmap_config));
 
 	for (i = 0; i < devtype->nr_uart; i++) {
-- 
2.34.1

