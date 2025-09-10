Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150E30FC3D;
	Wed, 10 Sep 2025 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539440; cv=none; b=s9d/s4kYtpSNndutJN/yjpoUufvRxew5DOt/auLx4qZ9tqTXYfcYxsXb9bNTao6kBKkgZXlvP5X83FWctI+fXAzDANFvriPPE2wlHDXaBahw5VBMmJvk5wEjMxr7TunKcsgyWx7cBO5LdULrNZr8UtIVBtXZqMG32lvgmfMnSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539440; c=relaxed/simple;
	bh=u01b/oiLKeGK9/KT8JgvFv/p5W3E/aZpSOzfJMIofiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=e7ifzOie9I+4HBKDuOfiYw3PqQ3ABzPjwLa+/5LAyvKpP7z/SDJVzaxxgT1tsxeLyLoPUXoWIc3fkCC2nc6r2w0ijERjrB4T5cvqKuf0CsVvrhhuneU2VxhBMLOlr0PTLw47yxJ3+VzyOU1CBO7kJg0rqWvfZkZLHD+j2HJq+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eyZhsvi3; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eyZhsvi3"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ALNoxC600362;
	Wed, 10 Sep 2025 16:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757539430;
	bh=iUPPMaqnvzEwIfBCj818WmKjsFyCRvzYa1dHNs7kXjU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=eyZhsvi3iaznKcVFErdQnz7XSr0MBi7TfhhgHH3baqpln4iRB6LMtVGAbbaAT2vIf
	 dWzSspz3PLhBpoM4W6ifFUFSzvcbpJbSVaamcr8WUFgzrLd4OQsyqPaOMjQOIZpi5P
	 0pwF+icWCLVYOoVbLOoT+WaSnbxfIkooqiJve6ww=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ALNnFp572646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 16:23:49 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 16:23:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 16:23:49 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ALNnZ51097742;
	Wed, 10 Sep 2025 16:23:49 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Wed, 10 Sep 2025 16:23:32 -0500
Subject: [PATCH v2 2/2] serial: 8250: omap: Support wakeup pinctrl state on
 suspend
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250910-uart-daisy-chain-8250-omap-v2-2-e90d44c1a9ac@ti.com>
References: <20250910-uart-daisy-chain-8250-omap-v2-0-e90d44c1a9ac@ti.com>
In-Reply-To: <20250910-uart-daisy-chain-8250-omap-v2-0-e90d44c1a9ac@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <d-gole@ti.com>, <vishalm@ti.com>,
        <sebin.francis@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
        <a-kaur@ti.com>, <andriy.shevchenko@linux.intel.com>,
        <yujiaoliang@vivo.com>, <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>,
        Kendall Willis
	<k-willis@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Markus Schneider-Pargmann <msp@baylibre.com>

UART can be used as a wakeup source for am62 from suspend to ram states.
To enable wakeup from UART am62 requires a wakeup flag being set in the
pinctrl.

If the device is marked as wakeup enabled, select the 'wakeup' pinctrl
state on suspend and restore the default pinctrl state on resume.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index bb23afdd63f29353351aa21fccf6c8de99011a65..9e49ef48b851bf6cd3b04a77a4d0d7b4e064dc5f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -27,6 +27,8 @@
 #include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
+#include <linux/reboot.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "8250.h"
 
@@ -145,6 +147,9 @@ struct omap8250_priv {
 	spinlock_t rx_dma_lock;
 	bool rx_dma_broken;
 	bool throttled;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_wakeup;
 };
 
 struct omap8250_dma_params {
@@ -1349,6 +1354,18 @@ static int omap8250_no_handle_irq(struct uart_port *port)
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
 static struct omap8250_dma_params am654_dma = {
 	.rx_size = SZ_2K,
 	.rx_trigger = 1,
@@ -1573,6 +1590,11 @@ static int omap8250_probe(struct platform_device *pdev)
 	priv->line = ret;
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
+
+	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR_OR_NULL(priv->pinctrl))
+		priv->pinctrl_wakeup = pinctrl_lookup_state(priv->pinctrl, "wakeup");
+
 	return 0;
 err:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
@@ -1630,6 +1652,13 @@ static int omap8250_suspend(struct device *dev)
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int err = 0;
 
+	err = omap8250_select_wakeup_pinctrl(dev, priv);
+	if (err) {
+		dev_err(dev, "Failed to select wakeup pinctrl, aborting suspend %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
 	serial8250_suspend_port(priv->line);
 
 	err = pm_runtime_resume_and_get(dev);
@@ -1651,6 +1680,13 @@ static int omap8250_resume(struct device *dev)
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int err;
 
+	err = pinctrl_select_default_state(dev);
+	if (err) {
+		dev_err(dev, "Failed to select default pinctrl state on resume: %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
 	if (uart_console(&up->port) && console_suspend_enabled) {
 		err = pm_runtime_force_resume(dev);
 		if (err)

-- 
2.34.1

