Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573B8BF7;
	Tue,  4 Jun 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507693; cv=none; b=J0TBNjoniPgm2/+ZOmBqVvVm1FyNMCcNqYydZ5dnp0e0roxjpPteGDXDG03Rj9B5CiQlmRGJAiXjOsDFJ1eaUBZBjYsHZNkGSfd6SdOFzTkkqHThrC9OslDs/MxzPQQxUOrJKNGbQryMCUvTvhK4K7e5ohDT5OSPkPNMFN1FXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507693; c=relaxed/simple;
	bh=/BMjW0MPIaUYuAZqk/GA+B9Bbj5pQx9MlrStm4g8BTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qstDxQRJL3d0HiCkLtqbDPzpPnDX2I2j789wh+fo+tQUIF/0Bpqld3NAdb5Cy9NqSc42pARTauWKHxn2jFEh/8QJEP4Z1xyHoUdLEjIbi8OkgKyi02gmfecmX4AjfdUXaU2BI49FM5WYTkGLgBasNQ3J9XxkzPRhLZ0Bt7rcJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ekXgKXF0; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ekXgKXF0"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 97D3A3F102;
	Tue,  4 Jun 2024 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717507683;
	bh=pQuy+Fq7YAtyQ2tFQisuhZqKXVXSeo26qt+wm2s0Ku4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=ekXgKXF0bYJxBSs7Ki/aYhFbte8Jhpl8uOGeQoGk/8SxkCIOcuWxkX1e3/p5iPtZp
	 92lalRmt3PtzfT7QUtRDLCvQPUoXObZocWlUbvWJWiojqclm9PLm/rzazm6oSZ2tIE
	 YBBgK599TRMkmrTikvnq+Nzcc8gz67O6ZI1YCIDO1MM4hb9DfbC73xPw8HYOPXsd36
	 tvyVtC90OpbZCtpDHZdjcngL1eW8B3jeXwaA0eIMZsA9V7365Itbrs/k5D4FJXJqd2
	 n4XjOFEtlPKCTl1fzdN7bl1fGFcXQUc59IaE+p0piMsF2zvHttAjl8NxWd8npjvDkn
	 ZjaQKgu9nuqgQ==
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
	hui.wang@canonical.com
Subject: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if reset-gpios is defined in dt
Date: Tue,  4 Jun 2024 21:27:26 +0800
Message-Id: <20240604132726.1272475-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604132726.1272475-1-hui.wang@canonical.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain designs connect a gpio to the reset pin, and the reset pin
needs to be setup correctly before accessing the chip.

Here adding a function to handle the chip reset. If the reset-gpios is
defined in the dt, do the hard reset through this gpio, othwerwise do
the soft reset as before.

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
In the v2:
 - move the soft reset and hard reset into one fucntion
 - move the reset function to sc16is7xx.c and call it in _probe()
 - add udelay(5) before deasserting the gpio reset pin

 drivers/tty/serial/sc16is7xx.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index bf0065d1c8e9..119abfb4607c 100644
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
@@ -1467,6 +1468,25 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
 
+static int sc16is7xx_reset(struct device *dev, struct regmap *regmaps[])
+{
+	struct gpio_desc *reset_gpiod;
+
+	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (!reset_gpiod)
+		/* soft reset device, purging any pending irq / data */
+		regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
+			     SC16IS7XX_IOCONTROL_SRESET_BIT);
+	else if (!IS_ERR(reset_gpiod)) {
+		/* delay 5 us (at least 3 us) and deassert the gpio to exit the hard reset */
+		udelay(5);
+		gpiod_set_value_cansleep(reset_gpiod, 0);
+	} else
+		return PTR_ERR(reset_gpiod);
+
+	return 0;
+}
+
 int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		    struct regmap *regmaps[], int irq)
 {
@@ -1527,6 +1547,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 
+	ret = sc16is7xx_reset(dev, regmaps);
+	if (ret)
+		goto out_clk;
+
 	kthread_init_worker(&s->kworker);
 	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
 				      "sc16is7xx");
@@ -1536,10 +1560,6 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	}
 	sched_set_fifo(s->kworker_task);
 
-	/* reset device, purging any pending irq / data */
-	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
-		     SC16IS7XX_IOCONTROL_SRESET_BIT);
-
 	/* Mark each port line and status as uninitialised. */
 	for (i = 0; i < devtype->nr_uart; ++i) {
 		s->p[i].port.line = SC16IS7XX_MAX_DEVS;
-- 
2.34.1

