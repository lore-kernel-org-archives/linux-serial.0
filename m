Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F2184103;
	Fri, 14 Jun 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361548; cv=none; b=to9fp3dCzMZJ4bW4wRvhzRywUTIX609xPmugvRJEU0tLU8BGOUWYKiB8qOGmcvOU5tZtOXBhxkrwhHAjeP/KS1LfnO0vTu7zoQgqV9yHFKi/JQNhETXKxvZguBES4FBhRpIcPHYfG+SjWt5yLnX9qCgkEGBMy0ebH10UDnkPlKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361548; c=relaxed/simple;
	bh=D1kAYjq+RBU2ebxwe5SBPfnToRE7zwPXLmuGypIW1EQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUjPWrL4jnCZOiErQYMk/y6E2tqwoE9NgcwG/BHdW+q+87yDBoO6D/zTtRUWwi3/Wvbf7tQ5VCnHjBs1ph8UbE2cUbYVh7Oo5v7OGX3uFzahEh8/iWP+kgKaZjCwity43G/ddvTYN7SmfzUvqjXle7fpOzUgp3cWGWn/F5O9484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H1ycY0Jd; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H1ycY0Jd"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B9192412C8;
	Fri, 14 Jun 2024 10:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718361134;
	bh=7lJ4PmSTvGKL8dkVO2rFkfAr3uH3sj1fkbkm4IcWgwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=H1ycY0JdH9FZwca4vELnnhsJBHHmHvrM+WAVfZWllbQNo9vXar+riWADbvzTN3ro6
	 ZrWLim0Vbq3CGDSiJDeTYOMBpQhrw9jq6gN/CpX1SfaneD6m/5iTw1KESvXJdmN3h1
	 jfw0f7PmBh4LMIT8qxF5T5+JT65Ht21XDiB7c9QGBtzKM1AiBwSNqArbW1KywHqmMz
	 KNkT7U5SDqWphkxcOMPwuF84/NiZE0Yka+FU8YymujjTC4esSzvv2A89p6aKhCfHZG
	 uDFUqSYiuetq7YE8CT1PwgH0DhQmdgranG16gAKm+enH+Kw92PcZK1Lz5Iuu3BOuci
	 08NAxMHGqi/+w==
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
Subject: [PATCH v5 2/2] serial: sc16is7xx: hardware reset chip if reset-gpios is defined in DT
Date: Fri, 14 Jun 2024 18:29:52 +0800
Message-Id: <20240614102952.679806-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614102952.679806-1-hui.wang@canonical.com>
References: <20240614102952.679806-1-hui.wang@canonical.com>
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

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
in the V5:
 - change setup to set up in the commit header
 - change othwerwise to otherwise in the commit header
 - change usleep_range(5, 10) to fsleep(5)

drivers/tty/serial/sc16is7xx.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index bf0065d1c8e9..eefa40006c71 100644
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

