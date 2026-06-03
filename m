Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C33DDDD8
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 02:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455558; cv=none; b=fxA+mXL7/pZt0UrDY/ZPewzoSSfrJCi+IMZFxgwQ6iylgSUw/oooy4aVibSO5hLXPc2HyE7t6cgF8v64N54a/nQZAt9OXdpm7ZFAf1PBc8TMFwzlAS0hNSDr+HtUcsjhzjpCFm8n3GPDL47hL/DAYJ2AZx39LFfLwG4jskCmGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455558; c=relaxed/simple;
	bh=Mw6uZCGJXMEV6EuSRORcbRYN77L14z2+GP+f8v7Yems=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KX1jNtmsRkJVzN3XtmEUa4kTjiG0XyUM3xDFqUwQu+YuzRUVbJ06UNDZTTtllLxxY+9gMMSBGrrPtsF/TO0qTelRj1Ytm/Fc2OotV37tjGwi3OxycGN9ZfYaWAUov9SMujAT5zFdE/mzmMZmauxj13pndODhTaYmn4akDo2FH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMj5ARDt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMj5ARDt"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf1f074a12so51703305ad.0
        for <linux-serial@vger.kernel.org>; Tue, 02 Jun 2026 19:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780455556; x=1781060356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYa7LbLjk11lrjjaU1fZoPN6rpBXsfSmsjALmXq19N8=;
        b=tMj5ARDtvAb3sIOpYfJ5nWeB08tiR2NHulyKjt1PPQGQf8szY0L/PP7ZJXcWxSVghJ
         WunaQcatVyJwqQuVr1XeLtma3JeqXSlJORYEo+4rN9bExy8XyN0GxeaMaGk3EULrTzJH
         laBqAhuSlfG6B92njMt9VY+uVJNqec/kFNKp/NyxdEA5u4c7vJkQ3CA2soykyQ67XF8g
         kazvPZg/XjrAUKoAmy6WQnCLqT8U1/8fZ3Xl9Pp2KMZGxp86NYo9YYpUvITmgu60jcPB
         eGUJPuiLtPJAYILmpO7f9yeyD5n7uKB0lQ/eYIzkRkQANRie7yWUiJB+34NVhqDa6jO+
         prNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780455556; x=1781060356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYa7LbLjk11lrjjaU1fZoPN6rpBXsfSmsjALmXq19N8=;
        b=rUVa/wXGu3OpFkR8xxyvFa+BKGB6dYtox+guY/9CbrcQA1vp69e8EXn0llBry61HzA
         Ywh1CeTSMKe6U3WVEjRwhEKgdMOCc7/ytoEjI5VdGdBdldPPeEsDcH2HliGiR4K4VfJy
         8eMEqXplKozGPdszZ9pzzjAFr5sWw3vutuasyztS7tG7UKYAB8aQk0u1GvhOrH8gmWvB
         Ctu82VKgpbfpsUIOXbbPT6GiE7CVSkNdCwN54nZeq9FGU/bWws4mHLZI0VRL1hN6BSRt
         8l9cx+NA2MrFESzXmP5/wi/wtmmg7A1dpSzGcUFLGwCRGhAqpt2+8A0ZwCDXB94P7ruf
         UzEg==
X-Gm-Message-State: AOJu0YymasGCCwheDwnJWoEfMcmOv3c7JJOHo+q3wNFtWIJq3pGevbpU
	IgdLmBsLdzhzcYlRjmQLrwvynm1b4fla+Sb6POzdinXuxPDtkT8ShS5eqmV8byJC
X-Gm-Gg: Acq92OHlnk+21Z9YQqnGXO1vsZHCox806Z/49fFL9NwV/6qQrx1MsHUsXS/KeyPNmGc
	S6YSFukWoEYxzxjOaY5+Tklo6dYZF3nE/sqA04BvhnzqKDAVVsNwYA8TNhKuFONDo75zZWQCvo/
	pdW70JsXe3O6Y24M2No6OJ4NBZpTDU0QjloEYHum0DvSsPHJiXBwdPBYReYLKd+YH5zIcK5srzK
	sQ+jpz9e5Uv+tkVQ9HoP8g+v8e717PMDOYr0QueYe38qSq+KltKuHr84wFAyZ14qNtnuMlwlcpc
	QEyU/iBNpqDzM+952adIDAykV6SUX5lIYVuCGL1om3I5DtbRp0ahB5jIc92YeDTzSABa9hgNMau
	ycuXUUx+IVzlN4ylrZbId2xUf3GNmlYtkw1jgZJnfjeKVNLdhcpPUu50Ov15wHpJzZNArU1YA4I
	uJ1YWjxBpnFoYlN/yMGGVblJDVXCFIkU65tHGtLvfH5i+Fuda418VOHtK7qaV7zyH3+tHZdxCg6
	vx4TFad1inbtIviPahlI02bosxzscCuv13/llSOR8aqDSGW35QsH3ul
X-Received: by 2002:a17:902:d48d:b0:2bf:2015:5b93 with SMTP id d9443c01a7336-2c163a2311amr14365355ad.11.1780455556485;
        Tue, 02 Jun 2026 19:59:16 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm8093805ad.17.2026.06.02.19.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:59:15 -0700 (PDT)
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
Subject: [PATCH 1/3] serial: mxs-auart: rework clock handling in mxs_get_clks and probe
Date: Tue,  2 Jun 2026 19:58:55 -0700
Message-ID: <20260603025857.287148-2-rosenp@gmail.com>
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
index 697318dbb146..1390fa000a5b 100644
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

