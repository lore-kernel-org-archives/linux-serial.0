Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AC1DF740
	for <linux-serial@vger.kernel.org>; Wed,  6 Nov 2024 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894500; cv=none; b=q1a3/93lAxeWr5PqrURqzHvgMjYCx/FrZR0OUCl+qUwOzOqYryAa9dni9jHWnzAUJWnDmhgizN8mcqZUmpxaIfsY3On9+/P+wjNQ7AerJoX6fFgh2z+l2iGSaW5fPls3FkQbr1AgjRPkqmerX0+8RFdLw1bmWTpzYtT/gnLkfTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894500; c=relaxed/simple;
	bh=nnIKMHwZCVnhmpyPc+cxLCcbBBDKni1qbHKymLGyy3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nu4d7F1Dcxa5Rqs3V3ZSPvmtFoP7eYHhTJrd8UVIVzRJPMy6CfaxKhK5kcdWRYg7ISbW3TgDaQYo2RTmqWNoTsVixFG2nCXZ5NrpW7CLjS9qq0UNvs+YycuLsp6B4wSO7cAVDcLqlnzIdAmnOOwRZE70ZpavhyZqF50llID9toY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lY1yQmsM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lY1yQmsM"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so411180a12.3
        for <linux-serial@vger.kernel.org>; Wed, 06 Nov 2024 04:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730894497; x=1731499297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuF+HQqDfNrvN/hR/B+TpLxJCm1YVPLvTielS6yXYjw=;
        b=lY1yQmsMAB0D53Zc/WIJDvWSSrmopO7Lv+V7lXtTklOoYD83hJrB05lP+vHlA3lbdn
         7v5kVPVIAhInFPvVxn4CKCMRcxdgAk7Cortq+l7N4VQUA+Xn9zkqzUxXe22GVQ1eMQyC
         cCfSS7tFi4odDVidkZYIkmGi5yDZuZ/NOO1iJ+erExkroaeFhnhBVKCy/QINPDetUvbw
         kAJjt7p81UWg77VjyJpcL4O8Bwnzj8zP5Pwwj55bbcFXUtRxWaRvtQ8woQb7QnP/dnNU
         Kl00QJuyJZy+Fv2ScZ+dguY6/crdmpaDS2TMzF8yyBHmOGk8IS+hoV6rIWtUasagBnVJ
         U80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894497; x=1731499297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuF+HQqDfNrvN/hR/B+TpLxJCm1YVPLvTielS6yXYjw=;
        b=fGbsp7P/mk+d0eZIaHAz30+dSgKfl9PAp2YYPrtMmPbCEa11DEb+l0AbvF6T2gczNj
         sRGSAtxTXH2Z8U31QS0k8OK9+/rsduDxbZTcMo0MYS5FOxgx1TKeaVn6SRSmml2kBRu2
         FXcyECwr7lBJdclWXczOeuYQ92ghPOQ4xJgROEFY+2vC4f25GTSO97MxUn31y64OxgN8
         7/JmFXRw5dIoBHltFp5LG3MsDnef9YANtH/zVcIkya67msFl7niQV2nPFpVoDmbq330+
         mUbOzHXumFhSMueKlTzyqmT8oddPzeK3fGmkY7de3fNFU5OuxYHzGQSF8irRKL4HPRVL
         S2JA==
X-Forwarded-Encrypted: i=1; AJvYcCUikRY6JWhuBJ2V9FU4VwSP6vQj0wQfa41utBZOn3AvgRHtA8l0Sqei+6eIyHG9xSsCTj/ikNKSG7nHKFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+h5iEkLrYFrMZerdwaZVSyQgkh00dpVg/Keyh+5eYBpYb/HW
	6d6pXNeMRv9ZpdC70YetbeB4EJ2LPu4K0J1gMe5mWUFSNa5sqrmNdxYi/Qil6MA=
X-Google-Smtp-Source: AGHT+IGOKdOCav6rBMLw0KkGMzDYbQNM2pA4wEc6Kqrkqnjh7CeppixXiGNwvtEFO5/5/sy+9d87Xw==
X-Received: by 2002:a05:6402:2753:b0:5c9:62c3:e7fd with SMTP id 4fb4d7f45d1cf-5cbbf8b1d2emr33677935a12.16.1730894497360;
        Wed, 06 Nov 2024 04:01:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe528sm2697984a12.55.2024.11.06.04.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:01:36 -0800 (PST)
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
	g.liakhovetski@gmx.de,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 4/9] serial: sh-sci: Update the suspend/resume support
Date: Wed,  6 Nov 2024 14:01:13 +0200
Message-Id: <20241106120118.1719888-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
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
 drivers/tty/serial/sh-sci.c | 53 ++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 2f8188bdb251..9548b8e97b8f 100644
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
@@ -154,6 +156,7 @@ struct sci_port {
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
 	atomic_t			first_time_tx;
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
@@ -3365,6 +3368,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 
 	sp = &sci_ports[id];
+	sp->rstc = rstc;
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(data);
@@ -3492,13 +3496,34 @@ static int sci_probe(struct platform_device *dev)
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
 
@@ -3506,8 +3531,18 @@ static __maybe_unused int sci_resume(struct device *dev)
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

