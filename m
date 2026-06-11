Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA1338936
	for <linux-serial@vger.kernel.org>; Thu, 11 Jun 2026 03:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149159; cv=none; b=nvB3HpjU4nycBfERf2MuPgaWUzY+JLK7+rUK0uoCSAS+/LOK2GqP19VUO5HUN1AM0fh48EZDDyy9MChKY53aBq8b0+KHOiIZgW0mdulmQWv9SCSh/1rJTdu37+LV0jRksq0e3kvNdH9GaZJcVTxqoNmlgD1PqhYQVbIT8+t4uQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149159; c=relaxed/simple;
	bh=jfKLiudhSeJ7Ij3548KPuavVXJyFeUm4cbLCLp5+oPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOlNkXqQ+ly0t4rZYSQQtV30td9Az595dTEnro0cwYUtd39dFMh2Xde2VPihYndkDcRYt0fSlbxhwP631mvQn8Ot2WQ16lnxSPiuKrpxD2nTETtQIu5yb0E9YeFeviwStryCotpmC+dWkKb7dOv8fwJIuKigN6L1sPSjqW71Lmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7CTj6f0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7CTj6f0"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8422871b42dso4473616b3a.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 20:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149156; x=1781753956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7DIsV2yYkeuv0vuZTHMuiTm55rfBmU9E0/9cM1N8Eo=;
        b=K7CTj6f0AJPub2ft3uOccR38CR4+c74ryDWgFaWzwirVROcm9ENEdeYOMR+2SyVmUD
         3Ox6/6DS+MTQKGgWFf1M/KfeUg6qtuNTAMNSU+ajrysxWDRr4R66B+4KJeotxq3P0mgj
         FupSx1e1a8oRIwuZxPS6uM6qnUgo7W8z9irfhx+6eadV4G++SRyzLW13RjfeZHX/SBwL
         vTeMJH3SAWm0ARPCo4b361806tIPzPDWs8u9s0hJN/HxRSjYASWItUCp0v4+NCC6q0R5
         R8ZYIBw77lgc7Afpg3shueDsky+vQF15qWKLlStUbEyM+CydZ96vZqODWomZTI7rlppy
         bNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149156; x=1781753956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7DIsV2yYkeuv0vuZTHMuiTm55rfBmU9E0/9cM1N8Eo=;
        b=pNvPWy4cE4RdwFGZ1t8WQM8DRlJpOH3A664j+cpAJ8HKujqmzmVsOr8LQWC6n8pkJs
         mvF0B+43XGfftnyR5NcuZtjwH1mHzt0U+O6NvxvqrugCvz4iqoyQVs9elZxPnigHMmt2
         Zd159FRkxvAxWe9IVqd1e2JHjAW27d5vzhVALh8uywe5JyOGWIYERF9Ow8KL4705q+0o
         M/yE4f4/EfeEKKltc7pUjXxy9HmLgEpNB7JKwH89fPN302KkZkZxxSTaWuzNRMKs6uMQ
         ODY4wzUFK2JLrk4obJprB3LrNU7abfaAhAg5Eg0g5khk7ZGbdFsO/IoZXLzhoUqhrgeQ
         ueQQ==
X-Gm-Message-State: AOJu0Yw4OwrkHRMyRSZYYxRTtpsVx86qRs+ja/BCMO93zztqUvRajz/r
	os2xkTWe/A7kZHgGs0mzARHlqZMMJV3HB8QZ+FWCivGRFgyI0x0munc00nX9Jg==
X-Gm-Gg: Acq92OGPeNxfjhrKcg1FhHoaaoK4DW6iPVcX4MLAUwQqub5bteK/8osUvwteezhW9vO
	2qHpBfiJd0eVDzMs+VEZaxO3P08eUC5g7JVz1EM/IitJq+23XNzbed/pAU0FQcJoTMmM7duRV+4
	pR7wpVX1JJnSWhAvKWITsPZlSffJ36Ob+nJL0ygWZ6QZS3AXh8aIDnLxezCZOpXMSlGG01WsxCK
	8C4nPbNn+mTj6GKsEDn2k4Zg5JE6fRZRF4rZif+5Hm7/1oDRw/2EQhhvJWEd7hnVRN1GvsONZHq
	uaBnClsQ79HKh0epmw1+NThBYMpVmupmBHZzr5hsBwuRRjRmt9kM4/4Po+Ha9q+7gPlZYWwYZ5N
	Ob9yGx1r/7VaQVXE9GvjiPGQtk+cOx8SHahSd4Gym3KqDipfKkojvVkuL2sS3iLDlscYn9BJpTF
	lWvSTcqW7hJaO4ebzREm7BWEx9Zoc7DeGED4pmT4JJD7EnkZmqCtoUFBVafd8f55ywstFlnqAK4
	LiYKmJPlpY8wdi93GIdGItHLUcBfExi9tZAgPfYEqgIOg==
X-Received: by 2002:a05:6a00:1d90:b0:841:58b0:82bb with SMTP id d2e1a72fcca58-843367c711bmr978126b3a.9.1781149156549;
        Wed, 10 Jun 2026 20:39:16 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb47eesm334548b3a.13.2026.06.10.20.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:39:16 -0700 (PDT)
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
Subject: [PATCHv3 2/6] serial: mxs-auart: rework clock handling in mxs_get_clks and probe
Date: Wed, 10 Jun 2026 20:38:52 -0700
Message-ID: <20260611033856.6476-3-rosenp@gmail.com>
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

