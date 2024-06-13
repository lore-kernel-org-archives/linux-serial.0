Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D813D60F;
	Thu, 13 Jun 2024 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267168; cv=none; b=YLwwlE2lP/rZ//8f2RJKUWIrUJGGIIgIrgdf8/occKLfIOUNSKMVVg18MOLBFd47IRn9dkeYRFOex0F89BpiDhzH4VoTpcXdnNBAzA0WbWn6zqm+Zy3xohE/S4ri6P01AUsaalH6tL40zoXW29tYuauJ66R2+45NlfEsx5HBu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267168; c=relaxed/simple;
	bh=jU1EnDb3tl8Xhz1lojdqSXTpbRfIvrdw+jjvmdVMHfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQtGtcJchYWCw/57bN7FlJkvrrA71fHXquC8VKti+jy2XsHyYr9IBiElTn+xo0NmmkQ1uxKUfmSLBkrSg9GCuG+cEGtIO2uloTG9bEPyl+Bai89V728FhpF7eL70vBALt7f+wTWtPHla3qn4z9LALHdmQu9Qq5KLJW3K47E8zCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GbdN4jZv; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GbdN4jZv"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5FBAC40825;
	Thu, 13 Jun 2024 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718267163;
	bh=eOYA1o/Yn3jOv9XLDfBaGTEfpxEHAJrPOdKXnD8e8Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=GbdN4jZvJG5Z0QM/bDHziFE7NGHC0TZRUp9LwhK2Z7+QBX7Fs2f+uH30cbG318X/3
	 g3M+X2LlPBlIhtbRmbDkoGQvCnMvW44Y59wG3j+SEUphcBwxpcjchkPm2lBTwBErQG
	 dBo5XbpkBvd6WOqXdeBc3Te0PdtOE4mKF/1IU6MtTL2M/EXFJN+3fEgGFpNvMtBWpd
	 SX7fX/dtPEWu9bCt8qmtXeR7xv4CRJkpgOhv6/VRbU8D01UP6qY93w+wDXCYiJAeRK
	 fldyU1P4IRAHhmWuIPBGk3+7cVQcp7KVo5o/xXpBe0aPbjw2bmPD0H1btgwFFd/9r7
	 gw1AxRwXk901A==
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
Subject: [PATCH v4 2/2] serial: sc16is7xx: hardware reset chip if reset-gpios is defined in DT
Date: Thu, 13 Jun 2024 16:25:28 +0800
Message-Id: <20240613082528.22591-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613082528.22591-1-hui.wang@canonical.com>
References: <20240613082528.22591-1-hui.wang@canonical.com>
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
In the v4:
 - Move sc16is7xx_reset(dev, regmaps[0]) to the where software reset was located
 - Move /* Deassert GPIO */ to the end of corresponding statement
 - Change the comment before reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH)
 - Change udelay(5) to usleep_range(5, 10)
 
 drivers/tty/serial/sc16is7xx.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index bf0065d1c8e9..a67c4eda0c03 100644
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
@@ -1467,6 +1468,32 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
 
+/* Reset device, purging any pending irq / data */
+static int sc16is7xx_reset(struct device *dev, struct regmap *regmap)
+{
+	struct gpio_desc *reset_gpio;
+
+	/*
+	 * The reset input is active low, and flag GPIOD_OUT_HIGH ensures the
+	 * GPIO is low once devm_gpiod_get_optional returns a valid gpio_desc.
+	 */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio), "Failed to get reset GPIO\n");
+
+	if (reset_gpio) {
+		/* The minimum reset pulse width is 3 us. */
+		usleep_range(5, 10);
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
@@ -1536,9 +1563,9 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
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
@@ -1663,6 +1690,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 	}
 
+out_kthread:
 	kthread_stop(s->kworker_task);
 
 out_clk:
-- 
2.34.1

