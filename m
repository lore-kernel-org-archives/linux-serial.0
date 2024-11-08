Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8E1E32B1
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060335; cv=none; b=L3qOZG2AO1/WYK6kyz8PKIucbpmeok6Cnmlwi8LT2iT2Y6sxsndy6AgomR6VL+BAo+XO3pcuAxbqUvLAbswd0LeBBHbMtnF3zSefjtY2IynQdthBOycB/MypW7WYGH4SdJNnR/3gCQ06N0OY7sMLLGMqArg5YjVzGiJu8E8leeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060335; c=relaxed/simple;
	bh=lcygwh3550pPn64SykAxI6BIRpZfeGHnBRvuudqjPH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3oguUIeehpFJdCVu6WtAPde3GRuev4Aq2alqjrTa5R28DcqtAX/6rm3xXGT8UpQE6wRahpzKQTHyKZOB1KW4gnA55lwbc3iKnDup5GmkfSoCcMxWiJVy2eEyu+J73mRdU5JKC/Pd79BzUNBR4fh9RV3uZEU8SanQaydu8CunJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bbXM2JCt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bbXM2JCt"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso2145390a12.3
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 02:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731060331; x=1731665131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UgVcphiVOuFJ6tnSyNPwX0ATDeT+8R4Pfh6Dj6lnCM=;
        b=bbXM2JCtwbNQeHMcEo2yj5RrYl5nbaXaahDvhPzHGfyHt+HpgeEZirksMR75assJd0
         x54lLQwfNJQ2aq3SCN+Hd9Xt1U+skR9OZCOxT4MpEgcEEogI2IGGM1FM3Zv9cad2hCq+
         x7GT2qjLZ1wRTLGMdgaWPc3tCu1xyo+yS6GMcezn7FdiUMwAqLziIsJumb1sQNIngOmP
         VIQOZRjniledbUU46NyzO5+of7MUe7sHzvSbRV+4V3PxIybs1V1qDoyisMlAe/74UuNl
         z69gnhNiMTKO4l7aYwqFbchCZe4TU40LXDxoCVGDr0CgPelESgUVxDyT1h/7BC3PbMsJ
         ZmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060331; x=1731665131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UgVcphiVOuFJ6tnSyNPwX0ATDeT+8R4Pfh6Dj6lnCM=;
        b=hF0JgwJYBCnoIsn/O6hkqm6pBnIZsB/52fBcFc52DI8K9WzwiwXcaA5Kw9YfvgeWbx
         kMf4xJ8VzV7Z8Tmf3k+XKh8NMdnKZ2JoQBzvPDI/PG0VWTnPw8IHgZzAAljWdUAb/ehc
         ue3VYV0nr4YiI1IxKENSaIw9QOWKFOSddQ1i075G8KNZwJvp1pnWT3kkdrJQqqHGhKEi
         o2sxWeGW7fP4nCWWawG2l1sjJpJs1OVRdKJ+9N9345BqquwZ00dJxpqCldLk0huODj3u
         14mbrcnAvQow/OlIZ3Qm6amBDrwWB7TluvXHTOZz9qtT06YWsFdKQcsNkV5V37SdH6Li
         p+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4mOp7VCRIJXYtT2bom4CKwMGqb6+7hAZDF9yB0HG62Hb3FQZXzAdKf59oXImRGkTk58D5WGDrhfk4qZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHVOf8YHbnnFOz8PHMHJ+8w4r9DPcQgk2htQnssjYj7Nutnrs
	EMXjWC1cgxiDwWAuAfvtNgzrBhITOpsZjGyEZGl69eqEq7KWhLspewuFrkCG1io=
X-Google-Smtp-Source: AGHT+IEIbaNJ/2qJlKbRq2+UYAJQotJwd3ym5vPjWrZ7SU0hZA/MKtPGKhh1Q+c1ptQ9q0UD3XH4mA==
X-Received: by 2002:a05:6402:4416:b0:5c8:9615:3e32 with SMTP id 4fb4d7f45d1cf-5cf0a325cf9mr1507654a12.18.1731060331122;
        Fri, 08 Nov 2024 02:05:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4f0bdsm1775959a12.56.2024.11.08.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:05:30 -0800 (PST)
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
	g.liakhovetski@gmx.de,
	lethal@linux-sh.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 3/8] serial: sh-sci: Update the suspend/resume support
Date: Fri,  8 Nov 2024 12:05:08 +0200
Message-Id: <20241108100513.2814957-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v2:
- rebased on top of the update version of patch 2/8 from
  this series

 drivers/tty/serial/sh-sci.c | 53 ++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 65514d37bfe2..efac65bb8809 100644
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

