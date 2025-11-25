Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E9329C43
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083209; cv=none; b=WKi9adzm2gN//wv5pc0a7rBL5fkcUZS+hnl9Iys2aPxAp9NThCFvpf9X+T++gCVThgBByCKYOvVlhsF0FqTta2ezr1lXGM8rLFhYYG1em3dAz0HYHbYO500EeLS+yyeHbOGlkH7HvzhshMQE0sR7B0IrfmIZ4+r5uU0Mbf9hS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083209; c=relaxed/simple;
	bh=RqWNr+J2yXgOsuO0923Xd+N0rvDeRRxq1yU1YzPrTew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPcugqWYCzG7qU36+whINong7VEZq1GBGLA0hMVaPZWEkKnx7bvhVYxncIrPpRnSYxHsVUBi80D7vdks9LUtmjt6nF1VAP0UI+ae8pEffXZG/FYPdMD1/V1L1Mz6PjIo/9LlRw//FiB2UK4aOzFkGdPBelBCvGAFZjiDBu+JwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyiXADg1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyiXADg1"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b39d51dcfso3398466f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083202; x=1764688002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jX3LIbgY2Qs2rnCAEJyiR5LJ9WWfAcTghJovwqWhk0=;
        b=NyiXADg1wq59/Lan29YX1N8/NiYv3ArDTmDW/KlGMkWdJ823QpatOmkCrifAUpZUNv
         RrLjXJeWRiQAQRmvN9dbkE3jJTuqp8IxxmGQXgaDRxEodApiUNfwCKF0jHtPI4X5kMWG
         ejTG9/Ufl6zNYw4LluBWjmj86nJaQvqXoWszyJmMQmpEK9P77n5CHazyO0OBAUspGdlX
         1SdwmXcxybU5hBMjS96XhSXHWiqqHfuuTsMGHVGYrXOpbNkJ8rFzbS38hjco7GhY3tfs
         W85keXXDRKB2EGTZa3ulvg99GnZOwI8UkkgIYP38SIibhracFA7eNaYWLueRLVEMR6CK
         +Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083202; x=1764688002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jX3LIbgY2Qs2rnCAEJyiR5LJ9WWfAcTghJovwqWhk0=;
        b=tQcVK3e+L1uTr3hdr1Fpy3+sGR944MPfbiJ6BgYzPbF58hUjh+aGKlgrhYdqivjpQy
         XeQK20WDxzVS7+Mehf1sJkV9LieDMNU+MrMN+cV1FP/IdWUqjAISnwaPdZgnJvGVYijl
         iOsokgmuOOVw4Q0bISEW1C0j14JkL8Pv34y72AaKTWufo8ZhRJUSo+ogvbRZbZbOu/ms
         788tTT6R2slvMQxoi0Z3F8odMpWBlGt+/Wgy0I1s7EaGUZql+SCfKcqE3eKg4Yb1BcOb
         vldtUL/bScsKVdfkNrqFt/7zMe1dRMB2vcPYWcGN4LLQpOgiqut2mpcE6eT9a2vXyCD1
         SyOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3VrEaxcOAoyiwqBuysQVEgwDioBw05rPNWpL2TlUvg+ITFKcMLHuvzouOv66uupUfTz9F0VX7kN1xGPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0F+LFx4IpN6hZCSEddSgN5Ar3MWfZI2b1hiDZ/+3EvGjcp63
	83Q+1bmT8zDtv5yucU2mhoiLOGMse4QYYDxp0/zmw7Xdf3NRcqSWB+s1
X-Gm-Gg: ASbGncs9SzTGgUuNOSRJPl9i2cEmvwMzUTFmgKrnK7YiOHgPrGhAXSHFy3cwpkodXY5
	JHD7r78EBGn/v/4MWdMM52Vsq+ZFUbE35w84wkty2qcqtYZWM4iDc7eZ72QFgB2fi/kS2eyxETH
	mEHSN+Z9MWNeCH8jmWPAq8PINxvAr10it+w1lQJYj/IO2xaiDx08IOW/aKNn9dXGqFmXrd4MiXM
	XnE3p8oxxUZP76lBS7b3ePzL3WkbE9vy7keWRyhSHGCwRxss3In3Vipe87XyZQijsqKFq4lM3gz
	LvWunsJxyLjheT/X0bSMRJ1fR9zvWhD93HRv+H3H+ZmA6MLZdyNbbslRhvssllfSNSJHUcr6AGQ
	t27sLEuMF/IcrgdD3pxwZ0vsN/BfnANTDTr3voWU5GbOtIwiK/n33TVDOVV4nb2f+levbLH//F5
	eGj+HUlPk1OVLOxLiZh3kTEjwOooWpCPPZClCvtBupQcK8IkpX4zs74GmYvEJcV3h/spKyAo2ZD
	Q==
X-Google-Smtp-Source: AGHT+IHJ3f6R4O0T6ProSqd6CgB0eBY01jmedSgsJF/qjxeGwfodfwrWbqyZIRq1uJuQdty6QtAvRg==
X-Received: by 2002:a5d:64c9:0:b0:42b:47da:c313 with SMTP id ffacd0b85a97d-42cc1abdefdmr18028213f8f.3.1764083202442;
        Tue, 25 Nov 2025 07:06:42 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:42 -0800 (PST)
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
Subject: [PATCH v4 09/16] serial: sh-sci: Add sci_is_rsci_type()
Date: Tue, 25 Nov 2025 15:06:11 +0000
Message-ID: <20251125150632.299890-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add sci_is_rsci_type() for RSCI port type. This will simplify the code
when the support added for RSCI_PORT_SCIF32 private PORT type.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Collected tag.
 * Updated commit description.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ae76705baba9..914bdb41ccc6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1182,6 +1182,11 @@ static int sci_handle_errors(struct uart_port *port)
 	return copied;
 }
 
+static bool sci_is_rsci_type(u8 type)
+{
+	return (type == SCI_PORT_RSCI);
+}
+
 static int sci_handle_fifo_overrun(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
@@ -1190,7 +1195,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	int copied = 0;
 	u32 status;
 
-	if (s->type != SCI_PORT_RSCI) {
+	if (!sci_is_rsci_type(s->type)) {
 		reg = sci_getreg(port, s->params->overrun_reg);
 		if (!reg->size)
 			return 0;
@@ -1198,7 +1203,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		if (s->type == SCI_PORT_RSCI) {
+		if (sci_is_rsci_type(s->type)) {
 			/*
 			 * All of the CFCLR_*C clearing bits match the corresponding
 			 * CSR_*status bits. So, reuse the overrun mask for clearing.
@@ -2015,7 +2020,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 	unsigned long flags;
 	u32 ctrl;
 
-	if (s->type != PORT_SCI && s->type != SCI_PORT_RSCI)
+	if (s->type != PORT_SCI && !sci_is_rsci_type(s->type))
 		return sci_tx_interrupt(irq, ptr);
 
 	uart_port_lock_irqsave(port, &flags);
@@ -3289,7 +3294,7 @@ static int sci_init_single(struct platform_device *dev,
 	 * The fourth interrupt on SCI and RSCI port is transmit end interrupt, so
 	 * shuffle the interrupts.
 	 */
-	if (p->type == PORT_SCI || p->type == SCI_PORT_RSCI)
+	if (p->type == PORT_SCI || sci_is_rsci_type(p->type))
 		swap(sci_port->irqs[SCIx_BRI_IRQ], sci_port->irqs[SCIx_TEI_IRQ]);
 
 	/* The SCI generates several interrupts. They can be muxed together or
-- 
2.43.0

