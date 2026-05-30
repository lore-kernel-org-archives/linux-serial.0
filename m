Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B12DA75C
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170945; cv=none; b=sWmqny6C0W/gSWlhdmA7fQidILJU+EWGEQj3TOMdR6w3nm4CXYESAfu1CmM8fm/Nu4JqOk4Kk1Z+NWgMm9aKg4vy26pA+BH6A6Gg4nnGzslfpd9Qfn+KU1HT1HMdDhbLi6o2NGGBsqFmpAIp9qFifzdFcdqOjn5lE7qXponQTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170945; c=relaxed/simple;
	bh=0e6oWsAqwA6Yr7Q3BRMhN0pQGfqxUUBdCSENWtkE9v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rIGVZ9aAa7XQNt7Dx3MXvJx9UB5UIv+Ay1CTWwbZn7fF5fxhCRy7bwIFVf6mTlc5wk7wGvYsbsu7Qk+boYTX90e0yN/LWt4X8hHCQaMNuMRzp4jSEY2zQbHNFVjD8Dd4yLS66oqXJYfWFkHRDz5BUn2nKBstUKrLFDincPnRy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WchOw21I; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WchOw21I"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b903567fdso2622284a91.1
        for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780170943; x=1780775743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFbb87WXannbZgAKQJkoODZG0moYWhbBBJifO3Eihyw=;
        b=WchOw21Itz+G/4cPFLPVIL9aBz2ejBzn2Owu4YMXQOCNHoXK6rTxL9bbIMDnbItHMi
         IMQcrbUm2R+FgUgODZCGa73lGSykuKQCgf6WFrq5DWXB9Nn1xpB6Oz+CqHfhzx7IO8K/
         Fze/J5WKMRIWOy6NOaa49eqaOcVsbhN3EjRQOqaZNuNNqn6xpbxVnSw7T6Mfpbf54cLl
         1P7AWY+kBw/faK4N5x/wsVtIk6TLzc2xnw70JZrqfk6SvCv19+11eqQXTVdfz1pX4QGV
         8beJTNl/0JBWDW7vebxfHixzpm4slqQWyYiVJdlBvkd3bTcbnxecGWgaA35r4I7FRDDL
         nTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780170943; x=1780775743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFbb87WXannbZgAKQJkoODZG0moYWhbBBJifO3Eihyw=;
        b=NtLpXitByJdbQUbpXpn4u54NSkXaPRYI0IPe+CxuhLnhO5G1AulQD5f0oxy6Qwx72W
         fErasyhi+ADLp/aZLPhGWjCQz1GW1wt+uq3+zrFbT1Kvp8D94oPuLnOquSrYA3wRoyvi
         VEbTWxl1cvW97L7YxAQDFdmAepNqAfeOkoIzusB1eMnDPv0xkQwHZEcc/sQq2/1sZGft
         f+UT6GimpkVUz5ILOWEPdFdcEBT/usbJ4bVJ6z3FF4g3Y6dUBQVOqrbb76XaSMEfn34G
         ML1FQCkfTr1/PnFDPdbLUH924TP810SgVHNQRC5QwGZQPtw8xwg3bwY4O6HAD1/jai1q
         dlAw==
X-Gm-Message-State: AOJu0Yxr3wRFKC+nn6BMnl82T9wCzIIWu/P9HEJVeXQ7gRZkge9gIKU+
	Zil+DT/P0vPliglIp/stxkVmp3uuLzIVdZ0pAaFclY8xK2dEYlznJC5LQ6Z2dx5f
X-Gm-Gg: Acq92OE/7g7POMeNGHddczU/RAxfgLvXxrWqOSJwVVVFZuITTxq/Mvzz3v8ypLdrTX1
	XgWpADM9FZEq9Tdl5x0wMDulNbVWqe4weU2hodQO4hbs8wm4rYjrwX37bIz7QxdQM+ZS3IzQo7J
	P6zEDu4slPXv9xSX9dA1382ZIbbKXnwGrT/A6PkV4Tyk2B68TaHyDRAoSmjBAx92N6LtPREzOpO
	Wgx6fbMK3UGTKfX49WvtPpVEVQMTw8rvfq8L5PqYcYaB3y32G/8CmIHW7JXDIYIVcellv36LFXl
	XQ4jnLFCGrO7O7bK1MIixeWRfrhYKHoSCrHeHF/LtbLASf8CtsRgsiTLmte5SaBHqnyXK0cB+NQ
	0rNBLW8e3O3wENEvdPkOsFjCxHIqTK9V1kDEAc4vqD0vvHQTGyfjV9SmE54+KcEs+3C0+mqV0So
	y+m9/qzSbblTcOHK+nnxRq2rqWn6gpMMn7Tyf0LzGyzw7z3ky1COQSV5NcfFmAOosE7Ri4dFdTF
	7LO/C0Vd+eh0G3Gbwunj/lYHoRXSnXCAn9nxJHQCtk7ng==
X-Received: by 2002:a17:90b:3f88:b0:36b:ba97:419d with SMTP id 98e67ed59e1d1-36c501cdd5dmr4347411a91.13.1780170943254;
        Sat, 30 May 2026 12:55:43 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6a34ca9sm5503001a91.9.2026.05.30.12.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 12:55:42 -0700 (PDT)
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
Subject: [PATCHv2] serial: mxs-auart: fix probe error paths and clock handling
Date: Sat, 30 May 2026 12:55:03 -0700
Message-ID: <20260530195525.5059-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: reduce overly zealous devm conversions
 drivers/tty/serial/mxs-auart.c | 127 +++++++++++++--------------------
 1 file changed, 49 insertions(+), 78 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 697318dbb146..bbe30841ce2d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1470,34 +1470,22 @@ static int mxs_get_clks(struct mxs_auart_port *s,
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
+	/*
+	 * Set mod clock rate while it is still disabled so
+	 * CLK_SET_RATE_GATE does not cause clk_set_rate to fail.
+	 * The mod clock will be enabled in mxs_auart_startup()
+	 * and in probe after mxs_get_clks returns.
+	 */
 	err = clk_set_rate(s->clk, clk_get_rate(s->clk_ahb));
-	if (err) {
+	if (err)
 		dev_err(s->dev, "Failed to set rate!\n");
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
 
-disable_clk_ahb:
-	clk_disable_unprepare(s->clk_ahb);
 	return err;
 }
 
@@ -1529,15 +1517,6 @@ static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
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
@@ -1549,21 +1528,13 @@ static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
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
 
@@ -1598,24 +1569,22 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
+	s->devtype = (unsigned long)of_device_get_match_data(&pdev->dev);
 
 	ret = mxs_get_clks(s, pdev);
 	if (ret)
 		return ret;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -ENXIO;
-		goto out_disable_clks;
-	}
+	ret = clk_prepare_enable(s->clk);
+	if (ret)
+		return ret;
 
-	s->port.mapbase = r->start;
-	s->port.membase = ioremap(r->start, resource_size(r));
-	if (!s->port.membase) {
-		ret = -ENOMEM;
-		goto out_disable_clks;
+	s->port.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
+	if (IS_ERR(s->port.membase)) {
+		ret = PTR_ERR(s->port.membase);
+		goto out_disable_clk;
 	}
+	s->port.mapbase = r->start;
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;
@@ -1630,21 +1599,17 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_iounmap;
+		goto out_disable_clk;
 	}
 
 	s->port.irq = irq;
-	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
-			       dev_name(&pdev->dev), s);
-	if (ret)
-		goto out_iounmap;
 
 	platform_set_drvdata(pdev, s);
 
 	ret = mxs_auart_init_gpios(s, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
-		goto out_iounmap;
+		goto out_disable_clk;
 	}
 
 	/*
@@ -1652,15 +1617,34 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	 */
 	ret = mxs_auart_request_gpio_irq(s);
 	if (ret)
-		goto out_iounmap;
+		goto out_disable_clk;
 
 	auart_port[s->port.line] = s;
 
 	mxs_auart_reset_deassert(s);
 
+	/* Mask all UART interrupts to prevent spurious IRQs from bootloader */
+	mxs_write(0, s, REG_INTR);
+
 	ret = uart_add_one_port(&auart_driver, &s->port);
-	if (ret)
-		goto out_free_qpio_irq;
+	if (ret) {
+		auart_port[s->port.line] = NULL;
+		goto out_disable_clk;
+	}
+
+	/*
+	 * Request the main IRQ after uart_add_one_port so that
+	 * s->port.state and s->port.lock are initialized before
+	 * the handler can run in response to a bootloader-left
+	 * interrupt.
+	 */
+	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
+			       dev_name(&pdev->dev), s);
+	if (ret) {
+		uart_remove_one_port(&auart_driver, &s->port);
+		auart_port[s->port.line] = NULL;
+		goto out_disable_clk;
+	}
 
 	/* ASM9260 don't have version reg */
 	if (is_asm9260_auart(s)) {
@@ -1672,20 +1656,13 @@ static int mxs_auart_probe(struct platform_device *pdev)
 			 (version >> 16) & 0xff, version & 0xffff);
 	}
 
-	return 0;
-
-out_free_qpio_irq:
-	mxs_auart_free_gpio_irq(s);
-	auart_port[pdev->id] = NULL;
+	/* Disable clock – startup will re-enable when the port is opened */
+	clk_disable_unprepare(s->clk);
 
-out_iounmap:
-	iounmap(s->port.membase);
+	return 0;
 
-out_disable_clks:
-	if (is_asm9260_auart(s)) {
-		clk_disable_unprepare(s->clk);
-		clk_disable_unprepare(s->clk_ahb);
-	}
+out_disable_clk:
+	clk_disable_unprepare(s->clk);
 	return ret;
 }
 
@@ -1694,13 +1671,7 @@ static void mxs_auart_remove(struct platform_device *pdev)
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

