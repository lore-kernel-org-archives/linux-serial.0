Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41EE33B6FB
	for <linux-serial@vger.kernel.org>; Thu, 11 Jun 2026 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149164; cv=none; b=c/E3xSicWj94OUqOWIqfrXD41uAPKTdqrPo7iVM02XB71DYqsymin0+jyI7CpGLl1OqjdrPTWgt0FeMimBOyXjmpHioEqVCVHqu8v+KcWL0vx4ej3QPF0sCVsdLyLXPvSEpT2cL59z9xukf0hKFgp+WQd2dtJOoI7FVNUKFG3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149164; c=relaxed/simple;
	bh=KHFBKElH1lggN2sZB5oI+hYuA6tBhm4+ZNyZCHF4qaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USFNpnvIhsIBaCRx5xF5mdLRN9FQcqVbdMOy+resXdyw5YuAB3Wyayj9Z18iNFA2y80xZOk3QyJUsU5B+rfyHGlpJJ2XIjhPUUSpCYfnGOktgWg/Igu2A+TWm94MhfN+G8St93N4qyJO5Dr7J/wAmUPTln+hhCWsx6e+/tuACDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqV6TPuU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqV6TPuU"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so4462420a12.0
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 20:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149159; x=1781753959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Enn6naQw+wLmV0GhfZ0seolUzIj1ObU+9VW8J0DyP44=;
        b=TqV6TPuUbgT7qmDT9jHv/gtDGhskne4WdiC/YMANwWjRXUzxPY5JDFpm+rcy4O2ZOM
         0eDdFy56sXY6qDzsOpAYAtCPhmuntbXKqm/x/YT63vxloKCGtB8nZz0FTbxoiByeg/06
         G297/lVsDU8uF1evMa5/54qtahg+BaHaDjLWsR4dV6sLplIUeYgJgWhJXqShGbWwqXqT
         BOyPjHYHFWZEahxA3ntddgyx0pY/Ksoy/BtaOAmckRNP+3wCSGAkE9KietrIqe/S3WuC
         TMIbjeDZboQVxISWpv2sZrKuWrqEbA0OmfE1Hil/zJQFThz2BG/wh1XNZ2ueK6N73SwT
         V5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149159; x=1781753959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Enn6naQw+wLmV0GhfZ0seolUzIj1ObU+9VW8J0DyP44=;
        b=tW0il0vSjOSZleU/BDn2kFeJ8hzqFsjOdM/X+SvC/ww4OWHyKrpAkpMMvdpRH1/xTB
         WONAQRsTXnTuHj0p9K/sOMlB3HGkkdKXG6ydjDFKOkBO3iZ9NqVrVlqaeOFO+n5roWac
         9sHM3B8IHzs9jvJDT3UkW+MjR9fBiKGbTAuxoIcf3FX3Duhd9+JE5BWDKf7Mhl8XY0G6
         +JyiUg6ijYedZWvWHctcEkSKUJHsTMG1KCefSid6npzqe7qPJZ4bMh5rcwG6Ez9AUEMa
         NB8CANNKzaaBqNtq7WrHp9+I47Sy9jLGfZYmnTQJeVjVPF3ppSVfNWYWseXwrs2b5Slv
         7XGA==
X-Gm-Message-State: AOJu0YyZAwcikZ++sEya9dVu/zjrT/ZskTf493ZS8pbpm7tZLj4/3rou
	Dj2ZWMTAWxUzbraxXnBiwJrF26wtDxzXh2nPq1MUbZR7LgkW4HABnTBAg4vYWw==
X-Gm-Gg: Acq92OHHiIxlS6xPzrRLf7tN2Lu+vgASjf6fxUNwZBK2OfVK9oYdw+UZUDxuSsHKDaQ
	g/QwroPei5yhxfensavhhxDI0tgqmdYzN4ApuuMBaWGMHGacZEPoNHQJiScoW2E4dXQZbB55m0Q
	IGXWlb+YNBn2YsFc1+8hoXJ1nLJzQIMax/2f6HF5mfPHTpIMQtg2gAiakJiphaJHS3OI5+mi5Dk
	qfMxn+fuv4BchX81AumQ4Wa0jwEFJXWePBrfv2IzqhVW6s5Zp4ko75l2SAtNlxSD5nT5GKCqNj0
	D5Ol/pFXMWMSvBVBYasv/E6YiLcaDKXJlxaZ2TuSx9NPVUb33hZ0a2M73YT6FcQ+B7kOESFNJcZ
	LE3eBZqrlCaFrQnvahfYLSyyYmbjQouITTc1bq1wOwGEFewCETk1XNDDdI8H2afFugkU9SmS/GC
	d40k6+2SPbrvphJsjzvyhkmQAWc20n/kVH+7GfHnSQWMbn9KN4AlU6D/Zw8GTXRu5hWYlck+vwO
	58ibvKo6QNFgQDBTTfCiL5tinrLz/rNreXVQsYKnUwu41dqWvNKJSE3
X-Received: by 2002:a05:6a00:1812:b0:842:3801:47b with SMTP id d2e1a72fcca58-84336a29db5mr1024457b3a.18.1781149158983;
        Wed, 10 Jun 2026 20:39:18 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb47eesm334548b3a.13.2026.06.10.20.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:39:18 -0700 (PDT)
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
Subject: [PATCHv3 4/6] serial: mxs-auart: fix IRQ registration ordering and manage console clock
Date: Wed, 10 Jun 2026 20:38:54 -0700
Message-ID: <20260611033856.6476-5-rosenp@gmail.com>
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

Move the main UART IRQ registration after uart_add_one_port so that
s->port.state and s->port.lock are initialized before the interrupt
handler can run. Mask all UART interrupts before adding the port to
prevent spurious IRQs left by the bootloader.

After probe succeeds, disable the module clock for non-console ports
since startup will re-enable it on port open. For console ports, keep
the clock prepared so auart_console_write() can safely call
clk_enable() from atomic context.

Guard the IRQ handler and get_mctrl with clk_enable/clk_disable since
GPIO IRQs and serial-core status queries can fire while the clock is
disabled for non-console ports.

In remove, disable the clock for console ports to balance the enable
done in probe, preventing a clock leak on unbind.

Assisted-by: opencode:big-pickle
---
 drivers/tty/serial/mxs-auart.c | 49 +++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4499e3206e85..e2b656638ab3 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -738,9 +738,13 @@ static u32 mxs_auart_modem_status(struct mxs_auart_port *s, u32 mctrl)
 static u32 mxs_auart_get_mctrl(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
-	u32 stat = mxs_read(s, REG_STAT);
+	u32 stat;
 	u32 mctrl = 0;
 
+	clk_enable(s->clk);
+	stat = mxs_read(s, REG_STAT);
+	clk_disable(s->clk);
+
 	if (stat & AUART_STAT_CTS)
 		mctrl |= TIOCM_CTS;
 
@@ -1079,6 +1083,7 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 	struct mxs_auart_port *s = context;
 	u32 mctrl_temp = s->mctrl_prev;
 
+	clk_enable(s->clk);
 	uart_port_lock(&s->port);
 
 	stat = mxs_read(s, REG_STAT);
@@ -1118,6 +1123,7 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 	}
 
 	uart_port_unlock(&s->port);
+	clk_disable(s->clk);
 
 	return IRQ_HANDLED;
 }
@@ -1603,10 +1609,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	}
 
 	s->port.irq = irq;
-	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
-			       dev_name(&pdev->dev), s);
-	if (ret)
-		goto out_disable_clk;
 
 	platform_set_drvdata(pdev, s);
 
@@ -1627,9 +1629,28 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
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
@@ -1641,10 +1662,16 @@ static int mxs_auart_probe(struct platform_device *pdev)
 			 (version >> 16) & 0xff, version & 0xffff);
 	}
 
-	return 0;
+	/*
+	 * Disable clock -- startup will re-enable when the port is opened.
+	 * For the console port the clock must stay prepared so that
+	 * auart_console_write() can safely call clk_enable() from
+	 * atomic context.
+	 */
+	if (!uart_console(&s->port))
+		clk_disable_unprepare(s->clk);
 
-out_free_qpio_irq:
-	auart_port[s->port.line] = NULL;
+	return 0;
 
 out_disable_clk:
 	clk_disable_unprepare(s->clk);
@@ -1657,6 +1684,8 @@ static void mxs_auart_remove(struct platform_device *pdev)
 
 	uart_remove_one_port(&auart_driver, &s->port);
 	auart_port[s->port.line] = NULL;
+	if (uart_console(&s->port))
+		clk_disable_unprepare(s->clk);
 }
 
 static struct platform_driver mxs_auart_driver = {
-- 
2.54.0

