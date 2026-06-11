Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D933B975
	for <linux-serial@vger.kernel.org>; Thu, 11 Jun 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149161; cv=none; b=OpMhr8NiYogj+6L85qCLZ3wJHs+A3ho6sqQxFjQVRs1cb3jmjifFFhxK61HGlQYrUGty0JbdAvT6N3aKul1Ncba9RFUILq96bikmT/Ncu4PTJUWbrMdSJ58uVblikxIRs+DOF6+S17uYPEvWTkO/Dj4AOGSHS8/J3jAn4pGNSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149161; c=relaxed/simple;
	bh=VuqAk7fmE2Ltz5WBlY6dQwYowm3411vf/6KNWP2/3e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgzZhB2iy81yp9oIKa7XjDKPzHQMjNBzHwgnkhWkvfuteamFgMnsALNiDYpS1Su+lMOeZZGmcCKVLTKGqKLhHRWLvE/fP0Kad13fHxus25TRVC03x0jU7KuNs1/SwTB8dufOnU2eDwr7luND7jHBRvuZ4uh4CBd2FRlbaO4bJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBK4J1GX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBK4J1GX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-842319576d5so4205287b3a.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149158; x=1781753958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jagaY783ZQexk/NjgnRY09dQ8WqyYDUPOGhKANIhzfg=;
        b=EBK4J1GX1aBiMD5oh4L/Ab0D+Ubk1GZ6ZMHuqctGK8hQJkSR0TPjgvx1zkeFDMALrY
         W2QrW4xmmtNOVRvZx/eecADvqiYDS0hi45QLOB+xwM5087cdQdIbHRe8Bvxb3lGe/B3S
         U87lmDFcw59WKCrQunSd2+PElEk6Hg4b6GHNVG92PzLxtYkjELDZHW1BBVn2fPLgk3wx
         Fu2t9HBjtV8RMiMwe9la3jMgthwDL4tCGZdPcyfeop0L3DiJv/6Qvq1oTzIHRWfSwdt5
         esav2sevGKSIY2hOX4iqet0ts/o7JD2ESn/ry9h+gSDMOwnHAtinxTTiROEN3/I40BkX
         +aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149158; x=1781753958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jagaY783ZQexk/NjgnRY09dQ8WqyYDUPOGhKANIhzfg=;
        b=fXo1c8JS7e2oIX7wT/3Gmb15QAG0oYxE7UbIHpzQXjAZUhixksLLETs6wqzXUMq4n3
         OfFO1PG6THmNcpL63QpzerMzxiXvaX+PfIsSASdkSqfrj7hRMTvPM6l2zbkATH+aRmqx
         MYwtHAPWLyNLCUCGIC8+yGco9Z7Mds5c9A4t42qb/LhohsI7oRmG6MC1mnDDP/wiT2UN
         nlIjtOHIzYFLMTxVrj9XDWZgOLEC6dgQgvnq46uaSMBiVBv64YpAhXY4pTM1joSidXz3
         Jc9XhRq2DQOqfOafi5oAXy3tY9RH6cCof9+Jhy8wQTygqxbDM5wJzi1iSVVk1FrRU/kx
         vV0w==
X-Gm-Message-State: AOJu0YxwpfTPVySFcDgGwxumDpB699GmWLuaOKrqnD7ghKgLb97f5aGY
	Ke2KgT/0d+iCAk/VaCWkh+ubClqgZTBRRJ+0UFIVNi+OEO0oFxjleZFy/ZgNmQ==
X-Gm-Gg: Acq92OHJLLm9S+mBwxZtXcClXcU1q3UdDhrPJY2uW6sInwgIuZJhqvgO7gVl7cQjf0K
	SviAUNPXMGlLm4WS8Hq+tVCTv1ZN61m1vmuaGlM8fDjCxzgptxEeakoEOWXnxXiIn1Jr/4YKlj9
	hkS+MdgajuneTy9SYFxDOe+qSKlGfL1MD7BvAzMYGowLwMIJaOsjEGOBw5L7T2rjVuNMIBvoTSK
	p4D7VMcQpfC8Wp/f4o4AbhMSxyh5mpQQ06IODRpCNGWm8v5ZDWvBZ92d4PYGfIkK/zxJ+oHeBCz
	psRVaXwyYKGnGYZ01/xulCEnQCcaxXtno5NHyRGDh2oEyypUKlp+0aFmFSmV8HOLFfYqdjR2nEf
	zSb2UjV7QYdZ734W2OV+/m18UXaz3sgfatPt385kJI382r3A5oQTiZ3SdhjyS0gCfJySoqnId0H
	D3cjsAzGprdx0OJkd31hgQ+mciUz42ITeorH1ChSUioZNBah4Ik2KB1G3EvI4dsPGvt9+cghvMl
	3QL6+eqVBRe7jAR1UjxmRiZua/6TyJmWterqliIakOekKgz1rzgvPD3
X-Received: by 2002:a05:6a00:88e:b0:842:48ae:1d56 with SMTP id d2e1a72fcca58-84336b9dc4amr1007360b3a.35.1781149157745;
        Wed, 10 Jun 2026 20:39:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb47eesm334548b3a.13.2026.06.10.20.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:39:17 -0700 (PDT)
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
Subject: [PATCHv3 3/6] serial: mxs-auart: use devm resources for iomem and GPIO IRQs
Date: Wed, 10 Jun 2026 20:38:53 -0700
Message-ID: <20260611033856.6476-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611033856.6476-1-rosenp@gmail.com>
References: <20260611033856.6476-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_get_resource + ioremap with
devm_platform_get_and_ioremap_resource and convert GPIO IRQ
request_irq/free_irq to devm_request_irq. This eliminates the
mxs_auart_free_gpio_irq function and its call sites, and the
out_iounmap error label. Simplify the remove function accordingly.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 53 +++++++---------------------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index aa59a48bfad7..4499e3206e85 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1517,15 +1517,6 @@ static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
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
@@ -1537,21 +1528,13 @@ static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
 			continue;
 
 		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
-		err = request_irq(irq[i], mxs_auart_irq_handle,
-				IRQ_TYPE_EDGE_BOTH, dev_name(s->dev), s);
+		err = devm_request_irq(s->dev, irq[i], mxs_auart_irq_handle,
+				       IRQ_TYPE_EDGE_BOTH, dev_name(s->dev), s);
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
 
@@ -1596,18 +1579,12 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -ENXIO;
+	s->port.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
+	if (IS_ERR(s->port.membase)) {
+		ret = PTR_ERR(s->port.membase);
 		goto out_disable_clk;
 	}
-
 	s->port.mapbase = r->start;
-	s->port.membase = ioremap(r->start, resource_size(r));
-	if (!s->port.membase) {
-		ret = -ENOMEM;
-		goto out_disable_clk;
-	}
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;
@@ -1622,21 +1599,21 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_iounmap;
+		goto out_disable_clk;
 	}
 
 	s->port.irq = irq;
 	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
 			       dev_name(&pdev->dev), s);
 	if (ret)
-		goto out_iounmap;
+		goto out_disable_clk;
 
 	platform_set_drvdata(pdev, s);
 
 	ret = mxs_auart_init_gpios(s, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
-		goto out_iounmap;
+		goto out_disable_clk;
 	}
 
 	/*
@@ -1644,7 +1621,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	 */
 	ret = mxs_auart_request_gpio_irq(s);
 	if (ret)
-		goto out_iounmap;
+		goto out_disable_clk;
 
 	auart_port[s->port.line] = s;
 
@@ -1667,11 +1644,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	return 0;
 
 out_free_qpio_irq:
-	mxs_auart_free_gpio_irq(s);
-	auart_port[pdev->id] = NULL;
-
-out_iounmap:
-	iounmap(s->port.membase);
+	auart_port[s->port.line] = NULL;
 
 out_disable_clk:
 	clk_disable_unprepare(s->clk);
@@ -1683,11 +1656,7 @@ static void mxs_auart_remove(struct platform_device *pdev)
 	struct mxs_auart_port *s = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&auart_driver, &s->port);
-	auart_port[pdev->id] = NULL;
-	mxs_auart_free_gpio_irq(s);
-	iounmap(s->port.membase);
-	if (is_asm9260_auart(s))
-		clk_disable_unprepare(s->clk);
+	auart_port[s->port.line] = NULL;
 }
 
 static struct platform_driver mxs_auart_driver = {
-- 
2.54.0

