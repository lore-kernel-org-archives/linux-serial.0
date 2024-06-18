Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93351139D11;
	Tue, 18 Jun 2024 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710087; cv=none; b=Pk0AT9mjiFcgQWDXcMp2y3hXspl68ojtrg7Q87ilJfRPqoR4Chx4IF15SPzgmKHsTwjR2jHMMDC8+NjEe0YfqIiAom3zVfEZIHYSVPKD+Vf9SQ5EMWp400CEJCy0L0xCnGwyFDWEx6liG+LUUDnNslA9nUtDnQRaDCaqCLD0g3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710087; c=relaxed/simple;
	bh=liqIQf/51gU0hCkHyFFUyrlyRfkSWPW0/N0Yi+ZfDcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ce4keZk3mYwg5xRqQlXsO5xdrPcfc9oamcjmUE0dTRlbNdcjpqe2M6uC0+10eg0q43Wvrhstd+2YpvXxd/ezGJXg5bfufQo16Wc8bnVhiREvla2BHFye43KLFgVi8BZn5EaAHqhvzMqxrxAE+NTPje0h6Di0OKQswpbBd3YFcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=m4qIfuH3; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="m4qIfuH3"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9A7E04087E;
	Tue, 18 Jun 2024 11:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718710082;
	bh=EuA5G7ftWh/W73RPr/IVD057SZHjTDVJktOyJiM2CIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=m4qIfuH3MKe+j/BXGdj3BV9+Rzttew9kgDSdgMX1eRM7e4dsBYRK1dyOJ2yHWcAOp
	 sHVqdYUlkxk5urYWsCnOKmQgr8jAwRYxz/AjxZWitE98rnN8flAcZnWena5NTMjwTt
	 rJIvYe49gk/AQJ9VRQhAtaPAGDbVIUIbVy+2dCNdMNn+5EVKf0hVDxPwXC/m6epvbe
	 eiBPL0UTC2lcsQ/hZsiqhgrC1ATh9PMhQsaqqLkFgST9MCejgmLjQ5gYwc1aVRSMEA
	 YN+PRMlsexkRZHSo5GTue44TD2MjIF+PdNXk8/7sMrBYIr3aB/VX8jG9x0azu7fERQ
	 4OQ/d5a6+FpPQ==
From: Hui Wang <hui.wang@canonical.com>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	lech.perczak@camlingroup.com,
	Maarten.Brock@sttls.nl,
	hui.wang@canonical.com
Subject: [PATCH v6 2/2] serial: sc16is7xx: hardware reset chip if reset-gpios is defined in DT
Date: Tue, 18 Jun 2024 19:26:20 +0800
Message-Id: <20240618112620.152848-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618112620.152848-1-hui.wang@canonical.com>
References: <20240618112620.152848-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some boards connect a GPIO to the reset pin, and the reset pin needs
to be set up correctly before accessing the chip.

Add a function to handle the chip reset. If the reset-gpios is defined
in the DT, do hardware reset through this GPIO, otherwise do software
reset as before.

Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
In the v6:
 - change the comment "The reset input is active low, and flag
   GPIOD_OUT_HIGH ensures the GPIO is low once devm_gpiod_get_optional
   returns a valid gpio_desc" to "Assert reset GPIO if defined and
   valid"

 drivers/tty/serial/sc16is7xx.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index bf0065d1c8e9..c79dcd7c8d1a 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/idr.h>
 #include <linux/kthread.h>
@@ -1467,6 +1468,29 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
 
+/* Reset device, purging any pending irq / data */
+static int sc16is7xx_reset(struct device *dev, struct regmap *regmap)
+{
+	struct gpio_desc *reset_gpio;
+
+	/* Assert reset GPIO if defined and valid. */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio), "Failed to get reset GPIO\n");
+
+	if (reset_gpio) {
+		/* The minimum reset pulse width is 3 us. */
+		fsleep(5);
+		gpiod_set_value_cansleep(reset_gpio, 0); /* Deassert GPIO */
+	} else {
+		/* Software reset */
+		regmap_write(regmap, SC16IS7XX_IOCONTROL_REG,
+			     SC16IS7XX_IOCONTROL_SRESET_BIT);
+	}
+
+	return 0;
+}
+
 int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		    struct regmap *regmaps[], int irq)
 {
@@ -1536,9 +1560,9 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	}
 	sched_set_fifo(s->kworker_task);
 
-	/* reset device, purging any pending irq / data */
-	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
-		     SC16IS7XX_IOCONTROL_SRESET_BIT);
+	ret = sc16is7xx_reset(dev, regmaps[0]);
+	if (ret)
+		goto out_kthread;
 
 	/* Mark each port line and status as uninitialised. */
 	for (i = 0; i < devtype->nr_uart; ++i) {
@@ -1663,6 +1687,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 	}
 
+out_kthread:
 	kthread_stop(s->kworker_task);
 
 out_clk:
-- 
2.34.1

