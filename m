Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C71D4604
	for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678260; cv=none; b=lPDK8J/91pp3/B6rwmDoZrdi74h7Y/wYVdb3IWUpen9KCe1eSSddediXSz3FFso4YQ9iR+eAQ5vSuk5zuxdlluaizJUEmkHvnymrGIsozN212Fofrbzqgf3ZQCn5RZn6/pDK1cpnqdxo6ZeMYt7i+N/upBzk8Y1Mz51bGLkktLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678260; c=relaxed/simple;
	bh=cvXLylORKw894oxYTuEZeViXynITomEuscveNdNCxgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiquyn35+Nl0g4hQT/Z7GAdsEE05xdP1RmeLu/tMpfSZhD1v07z3wcYukFeqbmUS9reYpPanQ0MirqScA1MAsHSGtkIp3AmjbRhwHygx1Tf5m82hBUra8f2BOWvZr8bHR7Q9WCPWnqgoN9dwrtFHXlAdhEQXT3DlIZBcXauTR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=keO9F3W+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="keO9F3W+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4316cce103dso19482585e9.3
        for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 05:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731678256; x=1732283056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QflYe9Uttnm4Ku+Zy3VUc0FNhJJkvv+YuMrekm3fOjY=;
        b=keO9F3W+nVGZMNuY9V21Pj8J3bkho7f9utN5jPPVrY2g9srF3vAgjhXs7ZnLKVb7qN
         GMGzYuClPBl+WGjPcqmSGTZDCghwYsV7P2U/9vbzEfv1vg6Yz4Sbl6oENNKszIlXKsnw
         JJ+r9HVVBkQeMYDOHuQQMXiSxA1J8TOvqIJdEXsiHhYq7J13VVOda6RBiMPWnNC6GG90
         fIrX3BGV3pWaSqpTv8dVt3ZY6EiDBVtBAc0fjNuEBe4G/aMnNrkQ2ef4lzagcmw8XZlZ
         DcI2BcPdR4anOiJcVDEJCvH2qx88lXffgL3HPylpMjvRG4escJAWsW6IzUp/u0lJr3id
         USBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678256; x=1732283056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QflYe9Uttnm4Ku+Zy3VUc0FNhJJkvv+YuMrekm3fOjY=;
        b=TwM48fLJq5F78u92jCVRFMZBFQww6QoSZ5fcM3Z9AoLgk4vlxQq9opJjjjs2qj0NFp
         3J3TBMqkxbqstrkqRU5qOKydjiBYwUXGoNQJ2XigucU6i58AXUBBpFpL5wxtGCzDpCzY
         pKDnOxAJRZWbrhiCqJ3bSys8sX2BfWMcenfkHukLqLLs5IbSJHtOV1VD/V5ihFSTdZCZ
         h+eelomQ7nAhahiaLFaB7JyDgidUuM3s7ebvYK1gjn/WESTY0ykaSpXQQ0NPgnCqw93X
         8ZqxlmkEA8HK5kZqwoS99sFi2V+MSN8YMNZKaO/2lWMyVMrMO8CdRS363n7Bf4zmhZyG
         2w+A==
X-Forwarded-Encrypted: i=1; AJvYcCUo4dXL9T+iGvCrZ5rmFJemx+l3QiwELS7sfHOKYy/W1UBcLPoTLStBqMYjO4WPSHepdfhwKGhadc7oaQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDiaoqRex3WCFuQIIyCw7WeNXF3eQ6U3oKq4GkStRPq0vCob7d
	VMhzLjwlbkHGBkXaR9XrDtD8avPsZHA+nGdyx/8X/lz/EYyXzg1V899FwKArruA=
X-Google-Smtp-Source: AGHT+IEsR7G1hgK+fmAed/LYpCR8sEfBfQmvxReRtCLi1L0/hyDVglC8dL6z2/8gYOyTa/fuZVe4iw==
X-Received: by 2002:a05:6000:18af:b0:37d:7e71:67a0 with SMTP id ffacd0b85a97d-38225a21d40mr2940930f8f.9.1731678256207;
        Fri, 15 Nov 2024 05:44:16 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3fc9sm4378016f8f.20.2024.11.15.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:44:15 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 3/8] serial: sh-sci: Update the suspend/resume support
Date: Fri, 15 Nov 2024 15:43:56 +0200
Message-Id: <20241115134401.3893008-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S supports a power saving mode where power to most of the
SoC components is turned off. When returning from this power saving mode,
SoC components need to be re-configured.

The SCIFs on the Renesas RZ/G3S need to be re-configured as well when
returning from this power saving mode. The sh-sci code already configures
the SCIF clocks, power domain and registers by calling uart_resume_port()
in sci_resume(). On suspend path the SCIF UART ports are suspended
accordingly (by calling uart_suspend_port() in sci_suspend()). The only
missing setting is the reset signal. For this assert/de-assert the reset
signal on driver suspend/resume.

In case the no_console_suspend is specified by the user, the registers need
to be saved on suspend path and restore on resume path. To do this the
sci_console_setup() function was added. There is no need to cache/restore
the status or FIFO registers. Only the control registers. To differentiate
b/w these, the struct sci_port_params::regs was updated with a new member
that specifies if the register needs to be chached on suspend. Only the
RZ_SCIFA instances were updated with this new support as the hardware for
the rest of variants was missing for testing.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- rebased on top of the update version of patch 2/8 from
  this series

 drivers/tty/serial/sh-sci.c | 53 ++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ade151ff39d2..e53496d2708e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -101,7 +101,7 @@ enum SCI_CLKS {
 		if ((_port)->sampling_rate_mask & SCI_SR((_sr)))
 
 struct plat_sci_reg {
-	u8 offset, size;
+	u8 offset, size, suspend_cacheable;
 };
 
 struct sci_port_params {
@@ -134,6 +134,8 @@ struct sci_port {
 	struct dma_chan			*chan_tx;
 	struct dma_chan			*chan_rx;
 
+	struct reset_control		*rstc;
+
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct dma_chan			*chan_tx_saved;
 	struct dma_chan			*chan_rx_saved;
@@ -153,6 +155,7 @@ struct sci_port {
 	int				rx_trigger;
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
+	unsigned int			console_cached_regs[SCIx_NR_REGS];
 	u16				hscif_tot;
 
 	bool has_rtscts;
@@ -298,17 +301,17 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 	 */
 	[SCIx_RZ_SCIFA_REGTYPE] = {
 		.regs = {
-			[SCSMR]		= { 0x00, 16 },
-			[SCBRR]		= { 0x02,  8 },
-			[SCSCR]		= { 0x04, 16 },
+			[SCSMR]		= { 0x00, 16, 1 },
+			[SCBRR]		= { 0x02,  8, 1 },
+			[SCSCR]		= { 0x04, 16, 1 },
 			[SCxTDR]	= { 0x06,  8 },
 			[SCxSR]		= { 0x08, 16 },
 			[SCxRDR]	= { 0x0A,  8 },
-			[SCFCR]		= { 0x0C, 16 },
+			[SCFCR]		= { 0x0C, 16, 1 },
 			[SCFDR]		= { 0x0E, 16 },
-			[SCSPTR]	= { 0x10, 16 },
+			[SCSPTR]	= { 0x10, 16, 1 },
 			[SCLSR]		= { 0x12, 16 },
-			[SEMR]		= { 0x14, 8 },
+			[SEMR]		= { 0x14, 8, 1 },
 		},
 		.fifosize = 16,
 		.overrun_reg = SCLSR,
@@ -3380,6 +3383,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 
 	sp = &sci_ports[id];
+	sp->rstc = rstc;
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(data);
@@ -3507,13 +3511,34 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
+static void sci_console_setup(struct sci_port *s, bool save)
+{
+	for (u16 i = 0; i < SCIx_NR_REGS; i++) {
+		struct uart_port *port = &s->port;
+
+		if (!s->params->regs[i].suspend_cacheable)
+			continue;
+
+		if (save)
+			s->console_cached_regs[i] = sci_serial_in(port, i);
+		else
+			sci_serial_out(port, i, s->console_cached_regs[i]);
+	}
+}
+
 static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
 		uart_suspend_port(&sci_uart_driver, &sport->port);
 
+		if (!console_suspend_enabled && uart_console(&sport->port))
+			sci_console_setup(sport, true);
+		else
+			return reset_control_assert(sport->rstc);
+	}
+
 	return 0;
 }
 
@@ -3521,8 +3546,18 @@ static __maybe_unused int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
+		if (!console_suspend_enabled && uart_console(&sport->port)) {
+			sci_console_setup(sport, false);
+		} else {
+			int ret = reset_control_deassert(sport->rstc);
+
+			if (ret)
+				return ret;
+		}
+
 		uart_resume_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
-- 
2.39.2

