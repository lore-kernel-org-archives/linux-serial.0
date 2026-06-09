Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FE3F23BE
	for <linux-serial@vger.kernel.org>; Tue,  9 Jun 2026 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044662; cv=none; b=fL6xA0CiYqs8FcrDiI5N3sKvcJukLuih5C384KWqbx0yWUxGNKKRoW3GnHqIFkUd9d7WCWKS+diBXq/pIvBIWJND1X82g411ejYYm4O4ud0DRtYMbCV5XOb09a9NirRTeMeN4Fhm+V1km2p66VPUyn5s9LIwJCo2Tadu17P9LQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044662; c=relaxed/simple;
	bh=KHFBKElH1lggN2sZB5oI+hYuA6tBhm4+ZNyZCHF4qaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzJOgcRNx/w0Zha55p/7asNb6HigvP3hfHs68kjWWhjSJgqDxkh8zG9HR9dy25hwzh7vGdBHriC+JlJBLDvValENDCheGEVe535YU3/SYFcQyHt/9zKTMoTxlPAM1saU5jKIOTgoF9aVSBP802g7eGsambXXCp3n4hTEKMXmWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhdN96B1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhdN96B1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso43807395ad.1
        for <linux-serial@vger.kernel.org>; Tue, 09 Jun 2026 15:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781044660; x=1781649460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Enn6naQw+wLmV0GhfZ0seolUzIj1ObU+9VW8J0DyP44=;
        b=KhdN96B1CGua831QXzIeO2A0g1nlAW+tIW2NLpZWXsztnyfHyBoetK696neiFXFP3Y
         xGHNSIX+/3NOD7kZ4OPMMOStlZmrjozZuEo5NpYhM160oCJDTtGf0A8R7QRIfmSLd34U
         6h9a2EWHB3I3XqDLwWWV0G8Lte0x8YAPcGrbzocKi9CbtpaUqPK5vOZ3pokc9rgfVhJQ
         r2IHMZ5O2Vfruj3RtX7TvrARN+z7v5JaElObRqccwQk1iHueXv01Xeofz283MxuGsmS4
         Y1hM0VpBy0szldn/wbWUUzuqaAPILY5CC4gW28Nehkq/ZkpvEDR3uzXt6gq/EMUorog5
         7YZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781044660; x=1781649460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Enn6naQw+wLmV0GhfZ0seolUzIj1ObU+9VW8J0DyP44=;
        b=CQ83+dvc8c30Fg4deHW1N5qwnch1oEZfawOzpPz2LfsBiqGS5vGTHriudJYujzcARE
         sgxIG3A4pw82yukHCycxECx3MdSWP0HJtD35Jnx2cdPTLSG9V316spV4lJg/glQr4Uzp
         TfKXUvXnxemko3VPuJXMzO/RUMSqeUUuDG6jnR/aeAGg4XzOOT0VdHNGqhFdjMqvFXdA
         C7dXEUeox1groQIF5D7eSIgoKEfzyQAo902vjORjPAJtC71ULKT2ZVWMGQnAsRfOhz+A
         F0g15eFmKya5cyNsdu/5WX+Fg9Ox/V4gG7hWiHdHP4SiZNQ0ys0F3uIHqmMuhMsSh6hB
         cwkA==
X-Gm-Message-State: AOJu0Yz5/LEheNjHX/bv11VUmpk0fe29EQvGoZkfer7qGCc5cgGqV3q0
	idHYb9WO3Fd2c1eM3MQdc0lYNez6L/9yhYPeazui9pVKzc6n/YTK23TO60Fr2CaW
X-Gm-Gg: Acq92OHqqxP0GLWDD2LNuJItP95GtxK2wzKJyUm1hg1yAkOpcOZIE88fi4kDFh8CV0G
	jKQtdeH/+FHBUs5WzDxaOFqlAOMCpITHia3kWR/P6tKTMWltQioz+5RUDpG/VZndfRAJFQyLZAk
	CLxdyxvdkJVLoJhVLavpqz86cpjZBHd/ZgbwZMGEb40TfbQhAxUzniuVLSDL2inCdTxnL7tqgum
	Qv1nFkn8Dm4gU8nd7Mux9nvY76UYU6suGQpfsIAEhh5Jf99lXq+GwH9M2L8M//J2h910tGIjdXk
	GzeceL4RX0F8mWNYqtO0CdhppYKY40dRrUeHRZtzuY3SR1cr06UywfUXJjJQtDI3WiqSYMHNCNg
	a7z2jKKPqZj56gh1n4vWCCuOfNJu8geUVjcHzZBgNr2gSqi8zHa4fGvnM0Yv+Zt8RedXwLb3ajf
	Gz+1N4BjclT/ZVb6DdVHcis49pChzku7rwFy9BSEuq0eq+bJw/ql/iXUu6LRUMiIGBISwA6HA1w
	N3Jh3d+JntQpYZJK9ipr0pvEgH6lgmGz/MJSfbcTJcYPQ==
X-Received: by 2002:a17:903:1aef:b0:2c2:7e17:39f6 with SMTP id d9443c01a7336-2c27e173ecfmr119389525ad.36.1781044659986;
        Tue, 09 Jun 2026 15:37:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm293750655ad.9.2026.06.09.15.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:37:39 -0700 (PDT)
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
Subject: [PATCHv2 4/4] serial: mxs-auart: fix IRQ registration ordering and manage console clock
Date: Tue,  9 Jun 2026 15:37:17 -0700
Message-ID: <20260609223717.41670-5-rosenp@gmail.com>
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

