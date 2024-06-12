Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A6155726;
	Wed, 12 Jun 2024 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198222; cv=none; b=lIxCGLcALbcrRSC9Q4GjY6SQdqtG6skUuFP+xl36MwalD6gVRtwjIxTvqVrwaNNRWTQR5MPus+gxGyZdJNoXSBPzMNNFu0AGrCx+P2vV3/SqqxD2tqJW7YouLqyt9I0Wc08gcDPLI0iEwr9Qxj36CWgQ/1wUjp3L90BAVqaG2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198222; c=relaxed/simple;
	bh=jbzWZ4STrU6UB+yumd57tv7CyJh2rXs/X2GNqKYCGOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXOHZVXCI2jG6y6VdB4dknlPF1pfKdZgkMA6xvu5dJh5ukXwgCJRZf1wFo7JT0bYm6euEHWe8aUk2cmpptp64oE8GUQaGbh+mIcdNjKgd6Z88OUqAPzjNhNifrouzkUlrL849xj3gO85S3un6R39I0S7njuabepxX3BS0ORPpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bmj+Eb2D; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bmj+Eb2D"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 645ED3F527;
	Wed, 12 Jun 2024 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718198218;
	bh=wA7bn0i6YsxzjYEXmfThRikO7zneS7zg93RvI9VLHTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=bmj+Eb2DYA0h+zWl2GP+GdEdSrbA+Mib3NToe5Y/vKC/CN24ZckU1Om1LVw+CW+ex
	 7uPpiCxSkLsUK4/kRSMxULHI/bBTBPDRC2QZQ/c3jk6PclJe7jfB3Ku7iuml9y3+lw
	 bEr6YoSQyJf7076MC83Vtq8eKu55pGL5j6CB8UTvUGXYDSEhf48tGj1NhLcWb5CvvN
	 yjiptr90TySwJcOLdfO4EMnEJZc15QcWHYSeVGd+Gq6s+dFFrgpURC/qCi9LHbIXHv
	 NHsJ8m5/0HIlLfb2itSZx39/KycWRqkdYq+c3jmT77nl2y/Zv1E5axRJq+J34tG2Hj
	 ikpRkNFaDI5Rg==
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
Subject: [PATCH v3 2/2] serial: sc16is7xx: hardware reset chip if reset-gpios is defined in DT
Date: Wed, 12 Jun 2024 21:14:54 +0800
Message-Id: <20240612131454.49671-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612131454.49671-1-hui.wang@canonical.com>
References: <20240612131454.49671-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some boards connect a GPIO to the reset pin, and the reset pin needs
to be setup correctly before accessing the chip.

Add a function to handle the chip reset. If the reset-gpios is defined
in the DT, do hardware reset through this GPIO, othwerwise do software
reset as before.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
In the v3:
 - drop Reviewed-by
 - adjust the sequence of if, else if and else
 - replace PTR_ERR(reset_gpiod) with dev_err_probe
 - change GPIOD_OUT_LOW to GPIOD_OUT_HIGH, this will assert the reset pin after requesting the GPIO
 - change the 2nd parameter struct regmap *regmap[] to struct regmap *regmap
 - address all spelling and description issues in the v2
 
 drivers/tty/serial/sc16is7xx.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index bf0065d1c8e9..8c7e0fe76049 100644
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
@@ -1467,6 +1468,30 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
 
+/* Reset device, purging any pending irq / data */
+static int sc16is7xx_reset(struct device *dev, struct regmap *regmap)
+{
+	struct gpio_desc *reset_gpio;
+
+	/* The reset GPIO is ACTIVE_LOW, flag GPIOD_OUT_HIGH asserts the reset GPIO */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio), "Failed to get reset GPIO\n");
+
+	if (reset_gpio) {
+		/* The minimum reset pulse width is 3 us. */
+		udelay(5);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+		/* Deassert GPIO */
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
@@ -1527,6 +1552,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 
+	ret = sc16is7xx_reset(dev, regmaps[0]);
+	if (ret)
+		goto out_clk;
+
 	kthread_init_worker(&s->kworker);
 	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
 				      "sc16is7xx");
@@ -1536,10 +1565,6 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
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

