Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AD2EA47C
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009596; cv=none; b=jepufa3tUDHr+KQndK46D5UAKrfbe3B6zPNfXQpbp2OTUM6GVclb68zYMAuJ2EQTbGGb6iQwBYAktFk9darHRsP9EnLMo9j8cfC7GZOkXF4JuOunEIMYO9cSZAOps/Xb99gu43wMd9PPe+RqIvyhpe6PclqiqiMKaBfDFnEa7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009596; c=relaxed/simple;
	bh=ks+rZadk+kPZAouysE15J3frO84jNoGPHcYZM4fvoh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGQF1borPg8cSPou9GtrFYCXvxyiotwpknpDSU8Bk7/fOprrVgYi6AJ/sMlk4PniDCAPqqZ3jKg+aF1DlFtg6ZxfGY3qTZtP5bBVLj2dw/zkx/VGhlF6q6CTRzdk7Obn9Jo/VkLmFxTGR3uR6OluMqrsQvzCbTQ8/buyPiqPieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6su1kiM; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6su1kiM"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f0ad52830cso17247067eec.1
        for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780009595; x=1780614395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLSjl6CXuzR38T343RTt9SyGP7hxMKOqUC5yJePUlLg=;
        b=h6su1kiM6cnxVyLXpO8EXW4jNXRUnM6A8etNY/wwBlqGs+EW9BDlfC/VWc3EbGBQ7T
         CuxNvYq+RDReN/DkwBrnZbwv5eKnxtjedRQNNUKXsIEDbg+diWOhImVbYWAd//zL4i/O
         ZCbuwYywgQ/7IfNAJrsaZrVRjDWLXPjoXHhFMB7fzhrKtP9riUSA8m2PaymqLu0wMgdM
         STlmW0sIZDuLSfRSkGE/CCgiwMjnS2e3gRqhPs0lAhm/XaVRE9Qpgpbs5Fiw38kzjmxy
         Ie1O7Hdac2l/ihiFauby4tYCIAQYXXe2S9+zXsubzO7sCEUdqDf2bEJK0rjT5sQLR/xB
         LaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009595; x=1780614395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLSjl6CXuzR38T343RTt9SyGP7hxMKOqUC5yJePUlLg=;
        b=XNwE53VzGyS3eewrWO8rNdJwL1XajSNRLeYEZDHzSBQnY3giEYcHopLqGOSn8TS9nL
         XXQG67rREuyGtvRauqidDMNM/D5FXiJl6J/AIMO2ZQecLsERKwkN7APIbumSAETEe9kw
         h5DxBPdgO499nJQy2R6ZPAuhBX6q63Mv/6f71UDgOtI4uYGVw4pBLRrR8ub9M7NkBDp7
         A0YlZYD8eIEvdfDDWQFdpUWAVpKHXVpmMu6FElV/2uBaxcRFM9Qm8XJ7taVsuCMPV3zs
         dZtVEekQBRjki5Hma+jwIm8f09jK3FQ9B5ZNxRKZ/wcVwO0v0bvS2PxrIk+Ox+LPxvVw
         R2Mw==
X-Gm-Message-State: AOJu0YxjS3rIPmsdb38ni7WQf3ISVUFrBJa501t52vBPaO4tRBN2FLDW
	Rnyjt15IUteVAG1aV3Vekmphdwmwv7SHlyC/Vg4nNYOqeuHoKhwRMsf6rXhmoiNr
X-Gm-Gg: Acq92OHAvMSEHVhaNhWBd6vUESZJLIs+vr6ePQBD2cRCdXktEkYELMX7EYBL0Z5zd7d
	ngdmyKRYsXEOjM8rMs922D92AveAlg+2/8OVWABeCImJdHdJdKYq3O+Eekn5ElpKJVZVn+yqqVu
	NVglqfq8afUYtgbJkxL9bPXbCwpnWLqlkCXqNN/UrsSoz/rD3AbmIVwki87KNqt87c44cjHPMon
	ATbStwfn8w9ALgiTArzvMGLCIRlvRkYzL8IAOgjbgUOXJq+yXSSox0pJWnSfAs8iwBZLF7D+i9L
	hatqBERjDhFII5prxODAdrNf15siir7EHiqegJvNXr/mwM2gR7ZobTEQdExmnQAx8jl8cjgxvYD
	8E4u1Zr9T/pHsRfPSpoXWV8i3sWE+6AQfZfqUyeC0r7rh/xoy6CIWCjInPjOKCCeKD/7qy3XWPf
	1dDyhkKWg6mIh/0waeyJEH1rt4Yvb6JJuJnvQzj9fpfzki2bWHjiVyLfh7eUS9S9az0cRqO2MsB
	DGamXXdXt96xBU06PcFlRn+lWGQ5M39jsJgmr1bq59lYQ==
X-Received: by 2002:a05:7300:cd97:b0:2ea:b975:3db1 with SMTP id 5a478bee46e88-304eb0f8bdemr260267eec.23.1780009594548;
        Thu, 28 May 2026 16:06:34 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ebcc8016sm223109eec.23.2026.05.28.16.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:06:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCH] serial: mxs-auart: fix probe error paths and clock handling
Date: Thu, 28 May 2026 16:06:16 -0700
Message-ID: <20260528230616.186792-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported three pre-existing bugs in the mxs-auart driver:

- For non-ASM9260 variants, mxs_get_clks() obtained the clock but never
  prepared/enabled it, leaving register accesses in probe at risk of
  faulting if the bootloader had gated the clock.
- The error path and remove function used pdev->id instead of
  s->port.line to clear the auart_port[] slot.  For DT-probed devices
  pdev->id is -1, causing an out-of-bounds write and leaving a dangling
  pointer in the array.
- The probe error path called iounmap() while the IRQ was still
  registered. An interrupt during that window would dereference the
  unmapped membase.

All of this is a consequence of using mixed devm and non devm. Instead
of working around these issues, go full devm so that everything can be
cleaned up properly.

devm_clk_get_enabled allows removing clk_prepare_enable.

devm_platform_get_and_ioremap_resource is a bit worrying as it calls
request_mem_region. Manual review of the dts files shows no overlapping
memory regions, so should be good to go.

Use devm in mxs_auart_request_gpio_irq as devm is used in probe.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 110 ++++++---------------------------
 1 file changed, 20 insertions(+), 90 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 697318dbb146..8b6463df11b3 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1457,48 +1457,24 @@ static void mxs_init_regs(struct mxs_auart_port *s)
 static int mxs_get_clks(struct mxs_auart_port *s,
 			struct platform_device *pdev)
 {
-	int err;
-
 	if (!is_asm9260_auart(s)) {
-		s->clk = devm_clk_get(&pdev->dev, NULL);
+		s->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 		return PTR_ERR_OR_ZERO(s->clk);
 	}
 
-	s->clk = devm_clk_get(s->dev, "mod");
+	s->clk = devm_clk_get_enabled(s->dev, "mod");
 	if (IS_ERR(s->clk)) {
 		dev_err(s->dev, "Failed to get \"mod\" clk\n");
 		return PTR_ERR(s->clk);
 	}
 
-	s->clk_ahb = devm_clk_get(s->dev, "ahb");
+	s->clk_ahb = devm_clk_get_enabled(s->dev, "ahb");
 	if (IS_ERR(s->clk_ahb)) {
 		dev_err(s->dev, "Failed to get \"ahb\" clk\n");
 		return PTR_ERR(s->clk_ahb);
 	}
 
-	err = clk_prepare_enable(s->clk_ahb);
-	if (err) {
-		dev_err(s->dev, "Failed to enable ahb_clk!\n");
-		return err;
-	}
-
-	err = clk_set_rate(s->clk, clk_get_rate(s->clk_ahb));
-	if (err) {
-		dev_err(s->dev, "Failed to set rate!\n");
-		goto disable_clk_ahb;
-	}
-
-	err = clk_prepare_enable(s->clk);
-	if (err) {
-		dev_err(s->dev, "Failed to enable clk!\n");
-		goto disable_clk_ahb;
-	}
-
-	return 0;
-
-disable_clk_ahb:
-	clk_disable_unprepare(s->clk_ahb);
-	return err;
+	return clk_set_rate(s->clk, clk_get_rate(s->clk_ahb));
 }
 
 static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
@@ -1529,15 +1505,6 @@ static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
 	return 0;
 }
 
-static void mxs_auart_free_gpio_irq(struct mxs_auart_port *s)
-{
-	enum mctrl_gpio_idx i;
-
-	for (i = 0; i < UART_GPIO_MAX; i++)
-		if (s->gpio_irq[i] >= 0)
-			free_irq(s->gpio_irq[i], s);
-}
-
 static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
 {
 	int *irq = s->gpio_irq;
@@ -1549,21 +1516,13 @@ static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
 			continue;
 
 		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
-		err = request_irq(irq[i], mxs_auart_irq_handle,
-				IRQ_TYPE_EDGE_BOTH, dev_name(s->dev), s);
+		err = devm_request_irq(s->dev, irq[i], mxs_auart_irq_handle, IRQ_TYPE_EDGE_BOTH,
+				       dev_name(s->dev), s);
 		if (err)
 			dev_err(s->dev, "%s - Can't get %d irq\n",
 				__func__, irq[i]);
 	}
 
-	/*
-	 * If something went wrong, rollback.
-	 * Be careful: i may be unsigned.
-	 */
-	while (err && (i-- > 0))
-		if (irq[i] >= 0)
-			free_irq(irq[i], s);
-
 	return err;
 }
 
@@ -1604,18 +1563,10 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -ENXIO;
-		goto out_disable_clks;
-	}
-
+	s->port.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
+	if (IS_ERR(s->port.membase))
+		return PTR_ERR(s->port.membase);
 	s->port.mapbase = r->start;
-	s->port.membase = ioremap(r->start, resource_size(r));
-	if (!s->port.membase) {
-		ret = -ENOMEM;
-		goto out_disable_clks;
-	}
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;
@@ -1628,23 +1579,20 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->mctrl_prev = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto out_iounmap;
-	}
+	if (irq < 0)
+		return irq;
 
 	s->port.irq = irq;
-	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
-			       dev_name(&pdev->dev), s);
+	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0, dev_name(&pdev->dev), s);
 	if (ret)
-		goto out_iounmap;
+		return ret;
 
 	platform_set_drvdata(pdev, s);
 
 	ret = mxs_auart_init_gpios(s, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
-		goto out_iounmap;
+		return ret;
 	}
 
 	/*
@@ -1652,15 +1600,17 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	 */
 	ret = mxs_auart_request_gpio_irq(s);
 	if (ret)
-		goto out_iounmap;
+		return ret;
 
 	auart_port[s->port.line] = s;
 
 	mxs_auart_reset_deassert(s);
 
 	ret = uart_add_one_port(&auart_driver, &s->port);
-	if (ret)
-		goto out_free_qpio_irq;
+	if (ret) {
+		auart_port[s->port.line] = NULL;
+		return ret;
+	}
 
 	/* ASM9260 don't have version reg */
 	if (is_asm9260_auart(s)) {
@@ -1673,20 +1623,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-out_free_qpio_irq:
-	mxs_auart_free_gpio_irq(s);
-	auart_port[pdev->id] = NULL;
-
-out_iounmap:
-	iounmap(s->port.membase);
-
-out_disable_clks:
-	if (is_asm9260_auart(s)) {
-		clk_disable_unprepare(s->clk);
-		clk_disable_unprepare(s->clk_ahb);
-	}
-	return ret;
 }
 
 static void mxs_auart_remove(struct platform_device *pdev)
@@ -1694,13 +1630,7 @@ static void mxs_auart_remove(struct platform_device *pdev)
 	struct mxs_auart_port *s = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&auart_driver, &s->port);
-	auart_port[pdev->id] = NULL;
-	mxs_auart_free_gpio_irq(s);
-	iounmap(s->port.membase);
-	if (is_asm9260_auart(s)) {
-		clk_disable_unprepare(s->clk);
-		clk_disable_unprepare(s->clk_ahb);
-	}
+	auart_port[s->port.line] = NULL;
 }
 
 static struct platform_driver mxs_auart_driver = {
-- 
2.54.0

