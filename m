Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186232BE050;
	Thu,  4 Sep 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021110; cv=none; b=PBJJNaKEXUtWZaB/cpY+hov4jfOZ72lPw1CxpMt4IJaW0C52q20sKMwBXG/4XjhE13aT8r+oaKzECMK39jcZ4fQ+++zTM7dWdjcG4LJ6U4BdokwLrXubv5ZZCEubEj99hViEDqxSScj4vt5utqz9a1si1wPT0Cgkg9D2w94eZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021110; c=relaxed/simple;
	bh=dQThrLQFDn6/9HUHfoM9KqjetvzbcwKFUWuVunPKJdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lby6y1uTnPq8GexdsNKnvI/+s9Pk/Y2ECCz7yJgNVLD/8LWMikExI1LkVGbiVVSzyI8mRE4fPwcEe92SDvf1xOQyM4VVb9lllce4YYXbW7QuWYNmg2sjE/fGRDJETYSphUDxDFv+UVbVUz/IIc3kGxxGZHxBxx9jI9MHMmJ+Sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uYtXkufg; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uYtXkufg"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584LP0AP3603119;
	Thu, 4 Sep 2025 16:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757021100;
	bh=o3L77FAgZE7CyMiTKAGd3ndivBgklsA1s4OZmLaELQ8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uYtXkufgJCOYL2cOkcbj9+ijF9E5KsknZrKqnNCBtMpWNQPER+tZAaAyMt2bP40cj
	 gvrBoy9zB2dgPnfj7BhMObJNAnD0nub/ln6NlAvarcnY6A5KDjN9PEnSg9f9GORvnb
	 y68WSqRRdNC5aYVejnU2tvHNRuX9j8xjJa/hl/vQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584LP0s21154231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 16:25:00 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 16:25:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 16:25:00 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584LOvlg3611150;
	Thu, 4 Sep 2025 16:25:00 -0500
From: Kendall Willis <k-willis@ti.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
        <k-willis@ti.com>, <john.ogness@linutronix.de>,
        <andriy.shevchenko@linux.intel.com>, <yujiaoliang@vivo.com>,
        <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>
Subject: [PATCH 3/3] serial: 8250: omap: Support wakeup pinctrl state on suspend
Date: Thu, 4 Sep 2025 16:24:55 -0500
Message-ID: <20250904212455.3729029-4-k-willis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904212455.3729029-1-k-willis@ti.com>
References: <20250904212455.3729029-1-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
 drivers/tty/serial/8250/8250_omap.c | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index bb23afdd63f29..9e49ef48b851b 100644
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

