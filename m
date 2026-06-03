Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5073DDDD4
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455565; cv=none; b=hFZVqXIrPcnSWGDN+31TB02r3tkGdNtEvKWFwk4sQMF6FtN8o/vPKN7DJpGTl82z4oQwIAyiPR6yuUHHKb8Ta4L1F0oxW4eGAO6X+XviGNHnEamGpN9qUc5kGlnU8IW4+CZVuztiIDupS3fwVWRNNF1wmYiCp6ZtsaZelN+GeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455565; c=relaxed/simple;
	bh=FvzXCTxllUlReWFN1nSFe7p5Rlpa73XzrCT7b2L5aBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiWEHbEXg92wQg32PKnb/IL/BlLTxQ/oz1YW19NNkalmUoYPD5g6ufshR5ZMlSM84o7+pqFrJK66CDTvaP/YtHbyWwb4tWE3o9Ze3NRf1obwx0Cojov4H0tEX5TpRiJ5R+oWsz5yb2TuvquPkVpKi4dCa+z2+s74UBkm5kksuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Znd+I2PA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Znd+I2PA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so21480885ad.2
        for <linux-serial@vger.kernel.org>; Tue, 02 Jun 2026 19:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780455559; x=1781060359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQM8/bXLwnHI0Nwp6B/mbCtcMHwqmZBefz4Rf3Ov6Bg=;
        b=Znd+I2PAUjLF896gtUB5FqH8pEHWwb8vmMdAgrCPL/3yjl9ehaqiw/E31OoPCOsQ7m
         f2ZXPWQ4VhqDV1tQ4lIf17buzTN+Jh4wcw6FrfzrGuRr84bt6qxQMN/41PAKsPXbCoeu
         KRIYWLb1Dy6XiT5eEK1Kx4NYTuDWYb2BDNPoXLLP7Kd9DKcwWmScGXLsvb5O466X62Rw
         pnMFJELAjW8hQOQlKxzZOtArn7fhmis1cJw7+IJG5/QZ07mu2/up9+AUnI/EKsPP+76a
         M41Mp8eUmms2MET8TalBhfwaBG+gSfty4DRNP+Chl3CujSh8S5emCRO2/YqhBLPkARtR
         0iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780455559; x=1781060359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CQM8/bXLwnHI0Nwp6B/mbCtcMHwqmZBefz4Rf3Ov6Bg=;
        b=oiIs8dr05S1so0LyCGTK64C9dM+BKkipY9oGZvMB8FzA0wiRUnkDoqoAJnSIuXOSx+
         /JYzjKIpgjnmVdXjQ86Z8MQuH3dSES+zc++MiM3PyLVjVk2BH9xrnsfbL3ME9o+cAnjR
         4PDL0EPqjkS2SIgvxAP5JoFx2dTuDdj+OU0cBkQwkA5VzxNmvTu6Qgeq10I7ae+7S4q7
         UZHqW9aqO//J80COC2vD4EC9rONYUn9BQCPqQbAzBXa3YfFhOcLX2YanrECcjGYsNYcc
         Q78o7XOD0lQlM0svvPZqEOE2bllR3t2MupMDzCg927OoV2ORzUAprfm+j2C0coyv3Rxa
         D0Uw==
X-Gm-Message-State: AOJu0Yx/d5qyQhoo78O5TdzbOj1TRwutYYG4AaF5OpxVIzjtm3+9jETl
	KZKN5E40D4QvVJnQCE8VVT+26GrhXpY16w3NkExQqE9F9bWEDaI+0H+m+knz+sX5
X-Gm-Gg: Acq92OEFVHK7p1JKWO7vnSnT3EINRTo/HqMEy3aMHPcVEHUIE4Yv23LagfKwQzOLZDn
	BV6MMzI3TfbkqdjTSIB+WEMz+RvzKH70Me9KZppGTS4bS39+YG2m2LYxo8WF/TOVBHW2/HpeuUW
	CLGAR98h7q4D//nx/buLkfJKsSrNLh/w+XniHToopetGDqlSb2wvmxDMWLeuNCMhb7oB7dOMLp/
	r91HJbJspababo3XyeigQtZy+yNd5fFoevqtz7MvimzV1ivSJxExpDEjYe8+0RgVnctaVUzyHn0
	PIVQQhDR63JxMgVT/dTyt8o2181xYcWmXdYI0nHwayJN2IpTrLO1oXlXF+nQgQNTlb5bGU+mNHo
	g/wl2rY4SBvyALK1fEy3KEnmJQYRKh6bM9pFAVnCIgGdp4MeEFFMthD1w6qk4PxQoYa4hHUmTPt
	xKjE5UqqUxgbEUCeyq/CThDTfIovusG0pm4ArkaPHXZL0X7+eck+wHdrmiEkDFvaqvqyuqg5Yrw
	qlQGkmnJ6bl9KDq3EdZsJMYbYmBvNohIiENwpG5GAJCmQ==
X-Received: by 2002:a17:903:948:b0:2bf:23ad:8595 with SMTP id d9443c01a7336-2c1639ec888mr14025245ad.4.1780455559275;
        Tue, 02 Jun 2026 19:59:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm8093805ad.17.2026.06.02.19.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:59:18 -0700 (PDT)
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
Subject: [PATCH 3/3] serial: mxs-auart: fix IRQ registration ordering and manage console clock
Date: Tue,  2 Jun 2026 19:58:57 -0700
Message-ID: <20260603025857.287148-4-rosenp@gmail.com>
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

Move the main UART IRQ registration after uart_add_one_port so that
s->port.state and s->port.lock are initialized before the interrupt
handler can run. Mask all UART interrupts before adding the port to
prevent spurious IRQs left by the bootloader.

After probe succeeds, disable the module clock for non-console ports
since startup will re-enable it on port open. For console ports, keep
the clock prepared so auart_console_write() can safely call
clk_enable() from atomic context.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 39 ++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4499e3206e85..d40d82f112c0 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1603,10 +1603,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	}

 	s->port.irq = irq;
-	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
-			       dev_name(&pdev->dev), s);
-	if (ret)
-		goto out_disable_clk;

 	platform_set_drvdata(pdev, s);

@@ -1627,9 +1623,28 @@ static int mxs_auart_probe(struct platform_device *pdev)

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
@@ -1641,10 +1656,16 @@ static int mxs_auart_probe(struct platform_device *pdev)
 			 (version >> 16) & 0xff, version & 0xffff);
 	}

-	return 0;
+	/*
+	 * Disable clock - startup will re-enable when the port is opened.
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
--
2.54.0

