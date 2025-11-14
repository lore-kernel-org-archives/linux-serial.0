Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FB315D2B
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117538; cv=none; b=E1szYYmgoBIwYnsdnjvNss1h/ZQJzA9fc5lI1VwqZhyRb5R4LKuaJEpxN/bmVAARzEwsqtYOcoQlL8mq3uIH4O0+WHL61PRe0NWh8HfvZylaVxp3yTMBTlIcZg7+WKspBlq5LwXV45wEHWjvxcgNJSc5iScHr0GD1pD9iVJyFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117538; c=relaxed/simple;
	bh=6O3doIFr9IR4S2kx1M6uldVyjIjXurTG0Y9yc4WTdAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0vq7Wa59y4WH1faBcVnK/NplrNcZKNPeS8V+R5CmBbFSSMfqMfpBwsTi0bb1QvwRqbwes+uqtbGpuZ6Lxtps/L6hGn7DfoCeLaakVBCAvp7oK8pyLUd4K9w4S129B6ZivpKSms0bYQEXA1AqruJv9jDe5hVJCzauuY5G2gpcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbag8zqM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbag8zqM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so20485285e9.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117533; x=1763722333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATfnSc/33FwJ+wue2neEbqFM/q6MAl95n5pgQFg9uxw=;
        b=Dbag8zqM2hgs798YIf3xt4zw2mUO89SFiIfrZCt9vxg0SiCO9RS1nR0zSSvsp0HV+k
         L7UxiYdRZfLNmvRkcbn/IQllDk881c33Qvl3PH4Gwj46KLJMYiP+e4s5hO4dCmLJlY92
         +XapvLSUXUjtK9ld6DWLtEDRB+vrqqjSiwRqnoOvuqij3iRrxnHBXpbNTukixvafjqH5
         RWqTFW62agAXZlgV8hN1lGoobBjwguONcRCVw5W+lUpH1WzRx3Irvc+wFWPgjdsTW7rZ
         hclU3+PbROovElufxqfX7w/1j7mHDQEmLso7vpjsdjuJOqO4Z+JX7UXoUoDs2nJXMHt7
         zRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117533; x=1763722333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ATfnSc/33FwJ+wue2neEbqFM/q6MAl95n5pgQFg9uxw=;
        b=mTfckQOEAie77tlk4XDvo33xv47U197cj8leHgIOiPJox/Z7vDrG89vh5kQQEdI5Fs
         7Yvz/8JrM4nflevlaL51hzO0WC0IW/FC1hPJx3fl8A5sggsbqpxdMzYvVe5hAdFedPCD
         M7TZjBB90L04Gh7FGsGD41Uo32McP32+ieYSmAdRDxHoTVuPeAcfBtpH3tnkfr26LPVZ
         8Qil9NHPhmiitcb/LqdghSZPIVAkjQWp4qPY9MQqpUascmAGhPIAZnMo0uMRFKDuMgDX
         MZpnP/laQSbheOzrThnbSHd+DNh0Eli4FrAiuR7X2NuQ8BA6eqb3Wx7S6OFBu3wuWRiw
         gnlg==
X-Forwarded-Encrypted: i=1; AJvYcCX/N6xQmuhVbxwFtVjG/L37int64XrkI0SBqLFb54XwkOTL3Bv5jkcwNhLFcsmVEv7y8eRmOIYTOsuda8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuSsioaIrKN+zEnNesdsFqsgnqeHwLhFIEzQZzL/j007OY28V
	R1Qm+/dFYNgTDMUwh3akJHK3ZWBcp3idLVJi6o8DHd94BUhHOnUM2b4G
X-Gm-Gg: ASbGncvx1dQoRgl4W5cS23G0yhHiq2iIjlWpBUwRBZy64p9gYI28zetkz1TlwcOHtvw
	g6QWozrb6kZEOy7458Ozon9sKj+x5jBjw7BtajLQ9XuW8RlYUS+MK/umnPqfGmD355p+sDmH8bm
	4hqzh8u7HK7tgEXXIhb7SfNYoKI9EEysbJ61mxeTvZVbyHM6v5HRrWbP7Fb/3EROXlWsbuI64Hv
	y52J0sRBSVA95tGBS2i1bj5t+phdK14Oy5FCgkYzqJo1BlLFNDEdS2DzwNWOGe7+edTnPea+cm3
	aLvHOixIRThjUDokHeHP1xrUXq8iu+HVrULZThlpf944DqEpv0+kq0JlX7vOlaiRsGa0+I9Y++m
	IYVXDbj5TW9LL9H1cH4tlTBfqAh8PEpO4DFIlJ8WT/Y7u1ptNvQ63MsoBIy+jWjHtyjHOqCfoY3
	7Ymd0GgQPTkHbTtZi9pziWLbzy1cyofM+jlELFLj3xKkUKWQY+rDMWIcDy16yJgqlkDjVhJOVQ/
	2YUo1YxgFg/2FTv
X-Google-Smtp-Source: AGHT+IEl0rijUjBj5KTVPuwgJ52eLtySyACZ+02OvsE0VUgnXG69c8DNIvntukmMZa1vwSgobwIWIg==
X-Received: by 2002:a05:600c:8b22:b0:475:dd89:abc with SMTP id 5b1f17b1804b1-4778fe583f0mr22856285e9.11.1763117532866;
        Fri, 14 Nov 2025 02:52:12 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:12 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 13/13] serial: sh-sci: Add support for RZ/G3E RSCI SCI
Date: Fri, 14 Nov 2025 10:51:22 +0000
Message-ID: <20251114105201.107406-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
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
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c   | 138 +++++++++++++++++++++++++-----------
 drivers/tty/serial/rsci.h   |   1 +
 drivers/tty/serial/sh-sci.c |   4 ++
 3 files changed, 103 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 43b2e5588d4d..39960e7c60ac 100644
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
@@ -649,6 +682,17 @@ static const struct sci_port_params rsci_port_params = {
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
@@ -700,6 +744,13 @@ struct sci_of_data of_sci_rsci_data = {
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
@@ -715,12 +766,19 @@ static int __init rsci_early_console_setup(struct earlycon_device *device,
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
index 7c3d25a6138c..82e472957913 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3674,6 +3674,10 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
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

