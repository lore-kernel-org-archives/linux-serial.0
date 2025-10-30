Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B437EE00
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847106; cv=none; b=FMn40nSzQzYO5j4BwQwkQBfIVjCWz4eWOBCHWe3IRnH3dihJHqBpTcCcH6UtUI6rgNsByKzlUXOjJ/H80xL1iG77uXsRESpjQlgKk6g5dz2oBR20SW23mPtUHrlTYx7pW9rZLJpWL1/In5S3s6h9FQtnM2iaASG2QeDafk4Fuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847106; c=relaxed/simple;
	bh=l69I5xmyhHro4KhUO/PVpo4RcLcYevtDC9A8q7K0wyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOWXRM/YOr0mBmo2zlOvoGib9wAx2nRz3wEOSDgf0a6q4MBkRI0WekIfT+cZmkGupptZ/TRC/AwADGjh0v7Y+z6vJOIMxMa2mmW9JW2ofR0EPSBrjt8XciEqvWZ6RCMCCOoU+VIRzIvkVYVrIrH7jkgG+l1yIz/81BCFrvuQ1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EypW9XRP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EypW9XRP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471b80b994bso17424125e9.3
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847101; x=1762451901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edvdlqy9JPFDf6Wc3Jobmq+A9++TT7Am/KBqXa8adZg=;
        b=EypW9XRPOjXY/BwTMmufm01QyPpSWGmXwGJociTQ25Jl/FZTsXefmtvkwsACw/UEqA
         DLTcqoHNxeYGj1Y2MtDb4aQM3U/aJ03+UTHP1a+fQrcBeAqOrAT6UNfYv3m2aEc9UwxQ
         nVDvkSC9OxQmrE3oq3DfgGJLJZ8hG7udOrdqY9qgvD9Dp6PbCssOe340m3fp+kmDNDU8
         RzGCyGNhAcLQo0Jk+Hz/9nmdbvbeZqWqeFOknFWr2DyrmhuLkBF6dwGksXMJPLOIw71e
         iBpK9vHi7waQi9M17Mx5FCEco3yDYa4jvTLppDWF5UOdEyY7C2M38RJA0/E0TZHW2jI6
         33uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847101; x=1762451901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edvdlqy9JPFDf6Wc3Jobmq+A9++TT7Am/KBqXa8adZg=;
        b=UJIsA7UEZtHRrkRRKR4CyYEx4bc1rpZvw9eEJpGgVqxS6JxsACAMr1iroXHWstI0/w
         Z6ZT0JU+dRqo8uVrRLj69nkDJJSPSErTDOKSQ8+/iShPsp0jxd7OtbywhD+QH3cpUN7J
         oAu/hfS2t7HusBlosHvHumkYA6xumE188tXky0Y7AxUNqTQlQWnDv1mlonHJPhppZQyZ
         Zb6h7fTDq1hdWsxxEPwEU+74TwoP6AGVidJrU+iWyEoDMky76nzmIbnpyjcBx4UyUIP4
         06xfFfhFBGpbtHHlGh+BYO36j1JUGNcfuq2YnsuHUVAigVDuk2TtsvIpLQdqJDlxitDn
         kKvg==
X-Forwarded-Encrypted: i=1; AJvYcCVodkYa6AmqcFUcPAXXZN4WRmzKZRERfPks+ktVKvsKucr7MPPopPfGu1QKypbjYF6l/80drEU9nMRQIW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Bv+6FCufAExwueW/RSAT+gDqCOjBxFfAtK7mvKN/A5pskDCT
	I6P3qLBNYFGck2Y2EUEWgLv7DmBEFqYwgWNvgJy0BQZxTrqv3o6eN+JHZioNDtyL
X-Gm-Gg: ASbGncut0A5M9+ztMvDu/T8GO4NuDdzUZhAn+ZVwH219DrJEU0p0WP2FuxTJbpgNWnT
	6zRDSSVNg6lwo8kTJVbWDoTXGjPEHNncH/sY3hH1vlL7ghG/R/8eGzoCZyIeyejq+1mo6bc97gf
	MooXhvxeehiWMsKZ67xdPXZEI7YG1MMxU5b+ATLJTYHmt5ooiClJ1D/ViI/ywJFvrcwkWlG+vPo
	H4dHGmAOY1tl51LFrmBO+KZK8xar94gJ8DQ0tXU8IG5HA0+eLjqAsFl5j/6xAhFwQzrfOT6MPVG
	S1w4wLMYFAvKp2Z0TpicLPLM7tT7gCX7SGv/2d9QZ3RV3e507dgqooSrvfz6DZ5Sw1E0wsVOYV5
	9qaZ5Tnwj6+1M48QNwNANmE7p3p5CH1tOETgPqF+YwX3Xt0o6kX2G2JAY4bvpVf/6djn1As+qrL
	xtoGGKqAodOl7bVcVVW9fXyLgvdd6nImKbw6ZrSSSdawhsSyrdlkahEp/+FMLyh8LS7utdk84=
X-Google-Smtp-Source: AGHT+IFqbrKQ5/jJ201fuWsP+20Nw8T/bQElSs8vE0JryTvXYNgKbYIgvVDd+hZC3bnGBXBweaE/kA==
X-Received: by 2002:a05:600c:3548:b0:477:171f:65f with SMTP id 5b1f17b1804b1-477308aa6a1mr5784485e9.38.1761847100893;
        Thu, 30 Oct 2025 10:58:20 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:20 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 13/13] serial: sh-sci: Add support for RZ/G3E RSCI SCI
Date: Thu, 30 Oct 2025 17:58:01 +0000
Message-ID: <20251030175811.607137-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for RZ/G3E RSCI SCI(a.k.a non FIFO mode).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c   | 138 +++++++++++++++++++++++++-----------
 drivers/tty/serial/rsci.h   |   1 +
 drivers/tty/serial/sh-sci.c |   4 ++
 3 files changed, 103 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index a3e216c05b76..43a381e5eace 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -161,8 +161,11 @@ static void rsci_serial_out(struct uart_port *p, int offset, int value)
 
 static void rsci_clear_DRxC(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
+
 	rsci_serial_out(port, CFCLR, CFCLR_RDRFC);
-	rsci_serial_out(port, FFCLR, FFCLR_DRC);
+	if (s->type != RSCI_PORT_SCI)
+		rsci_serial_out(port, FFCLR, FFCLR_DRC);
 }
 
 static void rsci_clear_SCxSR(struct uart_port *port, unsigned int mask)
@@ -229,7 +232,6 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long max_freq = 0;
 	unsigned int baud, i;
 	unsigned long flags;
-	unsigned int ctrl;
 	int best_clk = -1;
 
 	if ((termios->c_cflag & CSIZE) == CS7) {
@@ -294,7 +296,11 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	rsci_serial_out(port, CCR0, ccr0_val);
 
-	ccr3_val |= CCR3_FM;
+	if (s->type == RSCI_PORT_SCI)
+		ccr3_val |= CCR3_RXDESEL;
+	else
+		ccr3_val |= CCR3_FM;
+
 	rsci_serial_out(port, CCR3, ccr3_val);
 
 	ccr2_val |= (cks << 20) | (brr << 8);
@@ -303,12 +309,16 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	rsci_serial_out(port, CCR1, ccr1_val);
 	rsci_serial_out(port, CCR4, ccr4_val);
 
-	ctrl = rsci_serial_in(port, FCR);
-	ctrl |= (FCR_RFRST | FCR_TFRST);
-	rsci_serial_out(port, FCR, ctrl);
+	if (s->type != RSCI_PORT_SCI) {
+		unsigned int ctrl;
 
-	if (s->rx_trigger > 1)
-		rsci_scif_set_rtrg(port, s->rx_trigger);
+		ctrl = rsci_serial_in(port, FCR);
+		ctrl |= (FCR_RFRST | FCR_TFRST);
+		rsci_serial_out(port, FCR, ctrl);
+
+		if (s->rx_trigger > 1)
+			rsci_scif_set_rtrg(port, s->rx_trigger);
+	}
 
 	port->status &= ~UPSTAT_AUTOCTS;
 	s->autorts = false;
@@ -320,7 +330,8 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	rsci_init_pins(port, termios->c_cflag);
 	rsci_serial_out(port, CFCLR, CFCLR_CLRFLAG);
-	rsci_serial_out(port, FFCLR, FFCLR_DRC);
+	if (s->type != RSCI_PORT_SCI)
+		rsci_serial_out(port, FFCLR, FFCLR_DRC);
 
 	ccr0_val |= CCR0_RE;
 	rsci_serial_out(port, CCR0, ccr0_val);
@@ -337,12 +348,23 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 static int rsci_txfill(struct uart_port *port)
 {
-	return rsci_serial_in(port, FTSR);
+	struct sci_port *s = to_sci_port(port);
+
+	if (s->type == RSCI_PORT_SCI)
+		return !(rsci_serial_in(port, CSR) & CSR_TDRE);
+	else
+		return rsci_serial_in(port, FTSR);
 }
 
 static int rsci_rxfill(struct uart_port *port)
 {
-	u32 val = rsci_serial_in(port, FRSR);
+	struct sci_port *s = to_sci_port(port);
+	u32 val;
+
+	if (s->type == RSCI_PORT_SCI)
+		return (rsci_serial_in(port, CSR) & CSR_RDRF) != 0;
+
+	val = rsci_serial_in(port, FRSR);
 
 	return FIELD_GET(FRSR_R5_0, val);
 }
@@ -357,7 +379,9 @@ static unsigned int rsci_tx_empty(struct uart_port *port)
 
 static void rsci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	if (mctrl & TIOCM_LOOP) {
+	struct sci_port *s = to_sci_port(port);
+
+	if ((mctrl & TIOCM_LOOP) && s->type != RSCI_PORT_SCI) {
 		/* Standard loopback mode */
 		rsci_serial_out(port, CCR1, rsci_serial_in(port, CCR1) | CCR1_SPLP);
 	}
@@ -478,12 +502,13 @@ static void rsci_transmit_chars(struct uart_port *port)
 static void rsci_receive_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
+	struct sci_port *s = to_sci_port(port);
 	u32 rdat, status, frsr_status = 0;
 	int i, count, copied = 0;
 	unsigned char flag;
 
 	status = rsci_serial_in(port, CSR);
-	frsr_status = rsci_serial_in(port, FRSR);
+	frsr_status = (s->type == RSCI_PORT_SCI) ? 0 : rsci_serial_in(port, FRSR);
 
 	if (!(status & CSR_RDRF) && !(frsr_status & FRSR_DR))
 		return;
@@ -496,34 +521,40 @@ static void rsci_receive_chars(struct uart_port *port)
 		if (count == 0)
 			break;
 
-		for (i = 0; i < count; i++) {
-			char c;
-
-			rdat = rsci_serial_in(port, RDR);
-			/* 9-bits data is not supported yet */
-			c = rdat & RDR_RDAT_MSK;
-
-			if (uart_handle_sysrq_char(port, c)) {
-				count--;
-				i--;
-				continue;
-			}
-
-			/*
-			 * Store data and status.
-			 * Non FIFO mode is not supported
-			 */
-			if (rdat & RDR_FFER) {
-				flag = TTY_FRAME;
-				port->icount.frame++;
-			} else if (rdat & RDR_FPER) {
-				flag = TTY_PARITY;
-				port->icount.parity++;
-			} else {
-				flag = TTY_NORMAL;
+		if (s->type == RSCI_PORT_SCI) {
+			char c = rsci_serial_in(port, RDR) & RDR_RDAT_MSK;
+
+			if (uart_handle_sysrq_char(port, c))
+				count = 0;
+			else
+				tty_insert_flip_char(tport, c, TTY_NORMAL);
+		} else {
+			for (i = 0; i < count; i++) {
+				char c;
+
+				rdat = rsci_serial_in(port, RDR);
+				/* 9-bits data is not supported yet */
+				c = rdat & RDR_RDAT_MSK;
+
+				if (uart_handle_sysrq_char(port, c)) {
+					count--;
+					i--;
+					continue;
+				}
+
+				/* Store data and status */
+				if (rdat & RDR_FFER) {
+					flag = TTY_FRAME;
+					port->icount.frame++;
+				} else if (rdat & RDR_FPER) {
+					flag = TTY_PARITY;
+					port->icount.parity++;
+				} else {
+					flag = TTY_NORMAL;
+				}
+
+				tty_insert_flip_char(tport, c, flag);
 			}
-
-			tty_insert_flip_char(tport, c, flag);
 		}
 
 		rsci_serial_in(port, CSR); /* dummy read */
@@ -607,6 +638,8 @@ static const char *rsci_type(struct uart_port *port)
 	struct sci_port *s = to_sci_port(port);
 
 	switch (s->type) {
+	case RSCI_PORT_SCI:
+		return "sci";
 	case RSCI_PORT_SCIF:
 		return "scif";
 	}
@@ -650,6 +683,17 @@ static const struct sci_port_params rsci_port_params = {
 	.common_regs = &rsci_common_regs,
 };
 
+static const struct sci_port_params rsci_rzg3e_sci_port_params = {
+	.fifosize = 1,
+	.overrun_reg = CSR,
+	.overrun_mask = CSR_ORER,
+	.sampling_rate_mask = SCI_SR(32),
+	.error_mask = RSCI_DEFAULT_ERROR_MASK,
+	.error_clear = RSCI_ERROR_CLEAR,
+	.param_bits = &rsci_port_param_bits,
+	.common_regs = &rsci_common_regs,
+};
+
 static const struct sci_port_params rsci_rzg3e_scif_port_params = {
 	.fifosize = 32,
 	.overrun_reg = CSR,
@@ -701,6 +745,13 @@ struct sci_of_data of_sci_rsci_data = {
 	.params = &rsci_port_params,
 };
 
+struct sci_of_data of_rsci_sci_data = {
+	.type = RSCI_PORT_SCI,
+	.ops = &rsci_port_ops,
+	.uart_ops = &rsci_uart_ops,
+	.params = &rsci_rzg3e_sci_port_params,
+};
+
 struct sci_of_data of_rsci_scif_data = {
 	.type = RSCI_PORT_SCIF,
 	.ops = &rsci_port_ops,
@@ -716,12 +767,19 @@ static int __init rsci_early_console_setup(struct earlycon_device *device,
 	return scix_early_console_setup(device, &of_sci_rsci_data);
 }
 
+static int __init rsci_rzg3e_sci_early_console_setup(struct earlycon_device *device,
+						     const char *opt)
+{
+	return scix_early_console_setup(device, &of_rsci_sci_data);
+}
+
 static int __init rsci_rzg3e_scif_early_console_setup(struct earlycon_device *device,
 						      const char *opt)
 {
 	return scix_early_console_setup(device, &of_rsci_scif_data);
 }
 
+OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g047-rsci", rsci_rzg3e_sci_early_console_setup);
 OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g047-rscif", rsci_rzg3e_scif_early_console_setup);
 OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g077-rsci", rsci_early_console_setup);
 
diff --git a/drivers/tty/serial/rsci.h b/drivers/tty/serial/rsci.h
index ba255f58c088..df7a7edad7d4 100644
--- a/drivers/tty/serial/rsci.h
+++ b/drivers/tty/serial/rsci.h
@@ -6,6 +6,7 @@
 #include "sh-sci-common.h"
 
 extern struct sci_of_data of_sci_rsci_data;
+extern struct sci_of_data of_rsci_sci_data;
 extern struct sci_of_data of_rsci_scif_data;
 
 #endif /* __RSCI_H__ */
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 85b89c1ebf15..b7d9ea4091d2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3492,6 +3492,10 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
 		.data = &of_sci_scif_rzv2h,
 	},
 #ifdef CONFIG_SERIAL_RSCI
+	{
+		.compatible = "renesas,r9a09g047-rsci",
+		.data = &of_rsci_sci_data,
+	},
 	{
 		.compatible = "renesas,r9a09g047-rscif",
 		.data = &of_rsci_scif_data,
-- 
2.43.0

