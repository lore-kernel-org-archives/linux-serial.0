Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108953E4507
	for <linux-serial@vger.kernel.org>; Tue,  9 Jun 2026 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044661; cv=none; b=GjOV/GrEverGbC84ecQpP5mF73IFkzPHmVsWNYDYjYogMBETRRhJ2gmOCJMYxoOSZGAzfvJibhIYEyQUkb4C8JmrQx2DoggB+RrF/3rj2UaSILDyAHsf23Li+XM9GH16tG0tbZe+vwbbOUbACqsSpfPmUgx8gN5pJPOnorQvALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044661; c=relaxed/simple;
	bh=jfKLiudhSeJ7Ij3548KPuavVXJyFeUm4cbLCLp5+oPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhw7aNwcC71ZGGwlEQdjaDo+J6Y/45zWhuq6i5vJezhTVNGYIupuTzbLCRswG42+tmFmG1M4GzYwUeNDJqK5dPuum06PC7vgNwFvNGwBTn4NjKAmiV+JWS0JtolsgK0tr2BFMPsakGu3AJtabffTr7agpLFHJtOg4v2N947VmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3envGZR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3envGZR"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c858cc9870aso3098494a12.0
        for <linux-serial@vger.kernel.org>; Tue, 09 Jun 2026 15:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781044657; x=1781649457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7DIsV2yYkeuv0vuZTHMuiTm55rfBmU9E0/9cM1N8Eo=;
        b=K3envGZRMOnD006MT2fb2vZYu/2QW922S/CtEi5PdCKIIll7+4LMthYljLRQhJcO1n
         mSSqzhuQS6I3LlAwsZXCJg/ommvPw18wQgzr3ZIVMAFApqOKZcgyHBcDG99TtaBNyzBF
         fx7Q9g7laV5Gt3mDSruDoR+d6rH/Z5Tvz0GYNH1RRr0hpmGAe7Ft8Eg+NNc/iAGpZfrc
         LHkt8vrbidvxvldly+OkCMVkB+OLVaQp2Q2gGtZq/sTHho9pPKO8uDtzRjqkBdIx6+vr
         EFpJjSqIMxL7R/8fAS8Z5HsIhDkAWhjU2qM9UKxPgDBYIab6PXXRx/XqIaG7Il7za9y9
         sHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781044657; x=1781649457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7DIsV2yYkeuv0vuZTHMuiTm55rfBmU9E0/9cM1N8Eo=;
        b=oRviWQDeKdQV3+ITvwtb7lAangk5zdkp3hB6lcDD/YoaV4UHAmwvFXvsOsIFbZVyY0
         AXBF2byC66my+2LS/5Jr+hEBzcNtMAtjkCEwxF+S+pLYnrJYmmAvRXaXWuuiwu1es7rW
         JKugTpwZIH6c4wauKW6ZttOz1FqGqmxqPbNoRh4gYlisogRX42oRr+9BTxkPhAXvd8/p
         ANP7kUbhtRfjNuhvMdeYMGN/IhyYvxXI3/f6QPwI5c4FcDd/eUpWaLN8bnErm910olCo
         YipLMvreKcwNa0ebuvZ4SFJ7Ir7Sx9QjuV45L+8LE2eUKmoUNdtv6lvT0ym2uEaFsHTs
         U19w==
X-Gm-Message-State: AOJu0YzJ17ZTh/daB3Q/JYmyvuPZcSIG9Z8pSgViL/GkNmoDMEhsRozO
	q0336xZiQuVwCRoCWm/YTkp9e0c59Ke9ws65CZHTdQM70CjQY6i2gQaA4/LPdyRn
X-Gm-Gg: Acq92OEmW9P2JXimfVlvcG0UvaK5KIJUoF6SDZfBQ+LjP0ABpoxvqJv/L0JRJkydIvH
	WQpcVJp3oOKetCXQX+3w+KIGhzw/lFhsxY2fWSRQBd17CU8QCi4BjSdBVYr92EN6SsHIhGGo1H8
	iIc15ERK8xA4Znh6CKvtYSw0JEVkiliF4K21tN6hizi2Jrlm2dDkqvYLEKa5oVq/wDXfKNf3UbV
	+i1QHFrfq5XH1gdNqMp1pi400DFHk1La4EDjnjXdNue488E4a6wC/HsEoRc7zJi588W73phCZ6S
	dcj6boqfY++hqplCMEF2ZR9u4b7tDTlkDMw9s6NSi37eXK2MyAWaO2ytGY61J9iZuXWnykpyVK1
	Oct8GNoMKqQB6t9FMX0t6zTaybR/wIfbJrOZJY1qL9jlQBzFhkhk97wDa4sOCYcX+lHHAYn9Bsp
	Z7e3xea15XULWSe9NgUIuESGWjZUDzAxSTGFU1zZm3EAp+A0BBipFNkDhY7FoGSsAt77Ig+jBP6
	Z8KmRPIF6l9elQPTs3A7Z58VBi2vgGSjo6jnXp7tfzW9Q==
X-Received: by 2002:a17:903:990:b0:2bf:1845:baf5 with SMTP id d9443c01a7336-2c1ec918402mr185643335ad.12.1781044657308;
        Tue, 09 Jun 2026 15:37:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm293750655ad.9.2026.06.09.15.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:37:36 -0700 (PDT)
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
Subject: [PATCHv2 2/4] serial: mxs-auart: rework clock handling in mxs_get_clks and probe
Date: Tue,  9 Jun 2026 15:37:15 -0700
Message-ID: <20260609223717.41670-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609223717.41670-1-rosenp@gmail.com>
References: <20260609223717.41670-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_enabled for the AHB clock so its enable/disable
lifetime is managed by the driver model. Move the mod clock
(clk) prepare_enable out of mxs_get_clks and into probe so that
clk_set_rate is called while the clock is still disabled, avoiding
CLK_SET_RATE_GATE failures. Clean up the error labels accordingly.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 47 ++++++++++++----------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index de97c0f74e7d..aa59a48bfad7 100644
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
 	return err;
 }
 
@@ -1604,17 +1592,21 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = clk_prepare_enable(s->clk);
+	if (ret)
+		return ret;
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		ret = -ENXIO;
-		goto out_disable_clks;
+		goto out_disable_clk;
 	}
 
 	s->port.mapbase = r->start;
 	s->port.membase = ioremap(r->start, resource_size(r));
 	if (!s->port.membase) {
 		ret = -ENOMEM;
-		goto out_disable_clks;
+		goto out_disable_clk;
 	}
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
@@ -1681,11 +1673,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 out_iounmap:
 	iounmap(s->port.membase);
 
-out_disable_clks:
-	if (is_asm9260_auart(s)) {
-		clk_disable_unprepare(s->clk);
-		clk_disable_unprepare(s->clk_ahb);
-	}
+out_disable_clk:
+	clk_disable_unprepare(s->clk);
 	return ret;
 }
 
@@ -1697,10 +1686,8 @@ static void mxs_auart_remove(struct platform_device *pdev)
 	auart_port[pdev->id] = NULL;
 	mxs_auart_free_gpio_irq(s);
 	iounmap(s->port.membase);
-	if (is_asm9260_auart(s)) {
+	if (is_asm9260_auart(s))
 		clk_disable_unprepare(s->clk);
-		clk_disable_unprepare(s->clk_ahb);
-	}
 }
 
 static struct platform_driver mxs_auart_driver = {
-- 
2.54.0

