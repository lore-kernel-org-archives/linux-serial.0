Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703C3DD865
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455563; cv=none; b=WkR/cMNjnRiJjI7+eI2DVJSuyQfNThMkOWNIFDw+MLq6pQb8V+5zS6+WeAGt1LoUMiN359u6/gHDimisEGz/FA+6RI/xdE4urwVXqyRNPE2T+D9+jfAM3XExv3Oj1qxJQmzah9goNZfp4Cp0p+dVV7158xLBSLb8Tw5tG+9vdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455563; c=relaxed/simple;
	bh=ro5ZEfTmRSMETPH4SY7HmpTDWhtnqn6QdkxvFDRAIY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqBFCLxmM955GhFJBmNkUaDmv1ZI/TLwhlE+M9bUnJwyF2GHfRjYJ8I2NML+80Nz21xa9zjFPXgqfjaNC2htZnruinJqjArGLh+1Io9KmEojy/6J21VtSX8QHfKUJewoj3BnyJ5MtghjH24usJFUo+W6aSY3r7ylmHdkWAhFojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl/7GjpI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl/7GjpI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c132ac5ec2so10784795ad.1
        for <linux-serial@vger.kernel.org>; Tue, 02 Jun 2026 19:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780455558; x=1781060358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBVGXB/2UTdyKtSi19WHbufi1S2ilaO9ich5RG7k16s=;
        b=Hl/7GjpIRa8EcyV5ZyELyXbwX0NZfAkoohH8UiVZNB7YOi5J7yCft9UNO2RFOnK5Qn
         0EHy2Dz6UNa2L6/6PEJPtsWC81ljf4qJhvxS4zYgf+FRRfXTlVyvUx1xqgCN+9XJ4s9K
         trgBkWtiGBTrQ4FvydKgC6yJvMXsAbRx1vpqOYi03BTpBU4JlZL2RIzhdXokXRldXtKk
         hFXBfUnEVIco1ggUQgWji9bxcrfE+HPK+u6PyJryaAJMp3wQWUOXY4u2Zn7QlCXoHlDw
         l9EWgmX2iFgzKg+iZ5EU/RNxGOQkM1pOiS0SdUFYGBIRCwCgrOA0+q0XGF1GbT0WTu7p
         1ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780455558; x=1781060358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EBVGXB/2UTdyKtSi19WHbufi1S2ilaO9ich5RG7k16s=;
        b=hC6OiUHDsNzuP8hDMN52E2qjkFrObQjFe+j5JrIeshnGpyLmjvdz4DKSfNXFgllFLq
         TqGfV1xK8VtYk19wniEiW2Mp5z3XA4EE6oG0xdgT7tkCPsbmT+isuvxAEFeyMdKzK4g8
         bsevauuzZhIckJ3TUqPuhocNYy1S8AiTc4nJzheOVQns4x84TQ+f3VVVWXvEmSRC8Pyi
         jMGgMksei2q3vJ4I/EK44LPMKmglASFX2TABAf/yfyvcitw9E2/G2JDjFjUvRnEY3tzo
         Dix5prRZwH22NXB0GrdZ2UGM5Xc6+uPQ/T+rXqUcErlddOT3UabN8Ea5WsmfQv3dl4Nj
         2d4A==
X-Gm-Message-State: AOJu0YytQUC3uDXaiEHPoR3435wRvqkX3R3T5UhW9AMrlDleo/rwP/Jk
	9RGuic7/td9JvcE+kNZOHzJMZ0ZdeDuk5MrqtsiCruZTCa9Rw7k32CGul+5hbScJ
X-Gm-Gg: Acq92OHFFKdSdlrB7fHRGyl2T91aGEK91PW0I0tS00XNJdaxdfdBmEY0OuTWrZlk1nP
	bgqPzSb0huwpCstp1AKJ5whubqQcexWmPfj7gx0ZQrql3aPAScLgAiHQRYYRR1RaznmMp6TAXF1
	vSDo68ipbgLWEfW1NrchataZ/NfK5FYhM7ycYVk2nvi6lVkpeq3Cg4Nd1rcOHi5hQUgkgJ1juQQ
	T51E89y71re7XhYcLHZg0SUD/cyLUlhy98wzokFzXznn9j6OB6tUmby/LY55IWn1VkPztEMqsRl
	BrQuKpyJ8b4oVrGgTM2j3+goKFYxs3MWike+XQeqPptiT37kdYMUzt3KfAmKoQcbRHq2/HGwWXW
	sMw+Ac798KIuoaw0odDn2xyHdc7grmIhADSHbOqszWhHvx6NKwH6q6MD1JkC3Ic0oVbGqPXHJ8q
	wmAtOkn7W3T0+smKVj/szKW4bVdDaP5WjpqJn8pv/Ck4+jlY6FBCrK9vjrwEHHeSRtDoL3j/ein
	9XXNGxOQ5obN7AJyMdSBiJ/oMCXgsn2jKuBgG7Acb6rag==
X-Received: by 2002:a17:902:ccd1:b0:2c0:f807:56b6 with SMTP id d9443c01a7336-2c163a16bcdmr15056895ad.4.1780455557822;
        Tue, 02 Jun 2026 19:59:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm8093805ad.17.2026.06.02.19.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:59:17 -0700 (PDT)
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
Subject: [PATCH 2/3] serial: mxs-auart: use devm resources for iomem and GPIO IRQs
Date: Tue,  2 Jun 2026 19:58:56 -0700
Message-ID: <20260603025857.287148-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603025857.287148-1-rosenp@gmail.com>
References: <20260603025857.287148-1-rosenp@gmail.com>
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
 drivers/tty/serial/mxs-auart.c | 55 ++++++++--------------------------
 1 file changed, 12 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 1390fa000a5b..4499e3206e85 100644
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
 
@@ -1586,7 +1569,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
+	s->devtype = (unsigned long)of_device_get_match_data(&pdev->dev);
 
 	ret = mxs_get_clks(s, pdev);
 	if (ret)
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

