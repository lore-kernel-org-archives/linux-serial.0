Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BF13D27F
	for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451115; cv=none; b=rBygGZ8rT5a4j7+4avC9crJPeDbUU8b7MsqkMjdR8fmZzOffatoPIo6DImQe1WtKk2fR4aMhwqzwVGjGVYp3S3glM2tActopH8yi54HxykuJujkxCcxQvTUEzRsp62QMoBeDKowgt7B0FYh8MaOvrK+XRPOvsRfUrfnswhIDuA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451115; c=relaxed/simple;
	bh=xXMdx2YgQV2v/OWZAGfu0mLEHHS2I9maO01eCHtUDpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lxr24Av/8mup7RJyuf2AhfqjD/J4bnqTIJS/6w719RPnNKfIEjOJda+KkKdbwBdSkjrLoO/ltcp7LNoIaIyO+Ih8TXNFxt2eRuvAVlhnMiVUNC1GjYrKOVcPI2nTA7KLAQu98bCYzzCQiV9pIRTDWhBdgS3RSdbkfWht5UomYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a0iZ5dJI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a0iZ5dJI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42100f37690so3109275e9.0
        for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451112; x=1717055912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8K16dWvOhO2qm+sr1y3MxtWvPvdycG1GWiFMpy3S5U=;
        b=a0iZ5dJIddxbiN/gysft3jTV/B7x2rPIz2KUzZVqUcCgvzv9T7RGUL3LSiTNnb0jgs
         z7Ux8xhH62YXxfv+Bl8tQkAK0TZm3qGKnKwAHT0MWS4cX8z20nRxcV0NobccQ/1S+6xg
         uvFKJHOBpL/3XKe+g0HsXUNLktCAoBaDQfQ6frqBmE8L8Pgd7XOJeFOUWSfZdC3nwp4n
         MX+xcxq5RHeCh7OMPxyg5ybC4I2BgdA9X6+Kg347RSWaYttSPwFSSm1LtKncoFGfswnZ
         8tUh2Z+bwihCUlVkx+KoYhwTzIHipE/ZGrv9gHImMWN2Jzbecb2OnjwVuCNnggjwSqT7
         hguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451112; x=1717055912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8K16dWvOhO2qm+sr1y3MxtWvPvdycG1GWiFMpy3S5U=;
        b=jsA8SJr5UBL2dRGRZeOCJOgONvpTFMlJzlQwJqrsvwFsq+eBsL+m91rdFynMXw47A2
         /GI2AbbzLUP5CGdLO6dC4vIIRqPCyNFEWjgrhISP3OezR6KHjfpVNCOqL9wDx1Xl1/bB
         fAc1l+EuW46dJx2Tzmpityl3bl2fyCqolo39OjzrTSRz2G4wk8oA37vcExEIqQx2MyBR
         V4TWcY1xvLI7cDRFJPb4GTZSDGkb1aOlAu+tphyo2f/orPznRPnsE1AYKzYJN8BojuvG
         w8oNuI8ZPWW6gMMK4+R3othFhteaLnX+wJYB6lI88FGoQSt326/PUydgkOvzGSD4/y7Z
         N7xg==
X-Forwarded-Encrypted: i=1; AJvYcCWoByLQK1yJYwAHgU/tMivE4l+p+AraaEpY2oiGIOl4rP4LpZRnAig/k7cblqhAn4kNBGMMNbti2JdquWXLxKhBtCcgM1D9ANXWzyAS
X-Gm-Message-State: AOJu0YxQkboVZnRsy/Z8gUkIBjTfaxnmcOO0EOXIUNdOlg4PNjvvU/Go
	bqIpCY3HQudpqFwxyXxQuRPoYu1HISXZP7AsXv5baElGQ8P/UGRv7+DiY9tOkIQ=
X-Google-Smtp-Source: AGHT+IFfe5vIFo/LgA8ARRskHuwvWe7QRmx5Miy8yG8EWQ6t9qMTpauF9TRt5VITqvCuUrFcUT4oIw==
X-Received: by 2002:a05:600c:4fd2:b0:418:3d59:c13a with SMTP id 5b1f17b1804b1-421015b3ca3mr13374455e9.9.1716451112348;
        Thu, 23 May 2024 00:58:32 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f01d7fsm17359125e9.1.2024.05.23.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:58:31 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 4/5] serial: 8250: omap: Support wakeup pinctrl state
Date: Thu, 23 May 2024 09:58:18 +0200
Message-ID: <20240523075819.1285554-5-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075819.1285554-1-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UART can be used as a wakeup source for am62 from a powered-off SoC
state. To enable wakeup from UART am62 requires a wakeup flag being set
in the pinctrl.

If the device is marked as wakeup enabled, select the 'wakeup' pinctrl
state on sys_off.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5b7508dfb5d8..617a421a1396 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -27,8 +27,10 @@
 #include <linux/pm_qos.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
+#include <linux/reboot.h>
 #include <linux/sys_soc.h>
 #include <linux/pm_domain.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "8250.h"
 
@@ -149,6 +151,9 @@ struct omap8250_priv {
 	spinlock_t rx_dma_lock;
 	bool rx_dma_broken;
 	bool throttled;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_wakeup;
 };
 
 struct omap8250_dma_params {
@@ -1345,6 +1350,30 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 	return 0;
 }
 
+static int omap8250_select_wakeup_pinctrl(struct device *dev,
+					  struct omap8250_priv *priv)
+{
+	if (IS_ERR_OR_NULL(priv->pinctrl_wakeup))
+		return 0;
+
+	if (!device_may_wakeup(dev))
+		return 0;
+
+	return pinctrl_select_state(priv->pinctrl, priv->pinctrl_wakeup);
+}
+
+static int omap8250_sysoff_handler(struct sys_off_data *data)
+{
+	struct omap8250_priv *priv = dev_get_drvdata(data->dev);
+	int ret;
+
+	ret = omap8250_select_wakeup_pinctrl(data->dev, priv);
+	if (ret)
+		dev_err(data->dev, "Failed to select pinctrl state 'wakeup', continuing poweroff\n");
+
+	return NOTIFY_DONE;
+}
+
 static struct omap8250_dma_params am654_dma = {
 	.rx_size = SZ_2K,
 	.rx_trigger = 1,
@@ -1566,6 +1595,16 @@ static int omap8250_probe(struct platform_device *pdev)
 	priv->line = ret;
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
+
+	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR_OR_NULL(priv->pinctrl))
+		priv->pinctrl_wakeup = pinctrl_lookup_state(priv->pinctrl, "wakeup");
+
+	devm_register_sys_off_handler(&pdev->dev,
+				      SYS_OFF_MODE_POWER_OFF_PREPARE,
+				      SYS_OFF_PRIO_DEFAULT,
+				      omap8250_sysoff_handler, NULL);
+
 	return 0;
 err:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.43.0

