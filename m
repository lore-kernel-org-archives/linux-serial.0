Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598B36CDFC
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846939; cv=none; b=siTv5gmbpBCHIbU8Izh70wEnvYf+zQTDzYHfS9laF75dPFymcHR++JTrlbaqnrakdPcukq9OnQuYwZgfX3fmw5w9U39JHBXmZOXHtgc0yugjWzo3K4tYcMVRYLvyZnzefiyLY1HjlS/VFlU77P7+JqfJFARmPSJWk2eExlba08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846939; c=relaxed/simple;
	bh=vO9lAruIFRWwmcjhkElTrINqAF4ZFqyjtlRL6JeFb7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsE8Rrg+j4b5Z4GB5m4Z6CGzsiA2U6h22loA8EXzev+JtIdEvqcp1pktXT38OJB1ZlCnthv3nZrYQpV8uGUQ/PdIt8xxef4dAAkwsjWXrcxATl0CcM4bYOVUBmmVPBCTy07lWyfdYLPAkKOPPSovnAiGkKW9kLKratB+pCz9i3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfWj3pH6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfWj3pH6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429bb95a238so497691f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846933; x=1762451733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWj+7xNpysOeYb6zB5ArYmBB0QA2bqcJvV4UM5jfotc=;
        b=DfWj3pH6gJatdsT5V21tGVLpmbkoptpWV8J5GgmVMAKaP7SV3J7Z4HSS+ma+ayDxwm
         YM/s8zT09gC0IxSmbuR71sx2udzUzAWWaqQS4PSsa8F+w9rEGXr8U8np1W3jCtVQfGx7
         sSdSIrngsl9r4I2XYMvk6HqrzQCGDFgmeOvDlWUC6mgM20+noF3bKvcehFxFWFjy1eZI
         sr6pDNrhj8xC51nbBUCOjNnI3GRNTfA12IgPl6s/5YVPl0Ta2hWD2k6uAPaDMVl2zigC
         Iwx1aR0011i5mZ1G8qklIkuUQjFQmBC7TokydxDBDyoT2Hrfeqke7rgxmFtk45q23x3x
         N7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846933; x=1762451733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWj+7xNpysOeYb6zB5ArYmBB0QA2bqcJvV4UM5jfotc=;
        b=wiKsonA9Amusw0F93OIEn/Qak5o0QIy6rLbwL8RPdMEdN2uLsNWm1VRA86Id/Vk1vR
         FwWgEdgKUSJkUV7vaw4SEQfuBFoJ+2ho0YwNtB9aG3y0+9EwtpCl/wT5GGG1UyC36BQz
         PMbzuq1/yZFyR2S2mJLB3UjN23iY04yo/1JgsBvYDqhzD8FfxXEUDWBP5Dvw4SA9+7/m
         4GMqVdNCPwA+gdrKJdXZvcv3OQPixKS0o/dr/45DgwbeRoO0RsKW6p1bY4ZcHZUbb7+I
         L59VGYz3utl9M3/xhViy9qmlcsLByror2iFU19lKMZkEUnTn4ZcPI3GkskHdudd2mAhG
         nY1g==
X-Forwarded-Encrypted: i=1; AJvYcCVdkqd5QDj82XEs9uVpj+QXdjm0RiOlwV29BiY+C/bHl43OTRi8+/PM4HpJ0l4Jie48b/xbI4qsT6iZJJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7XsLh+u+E8oxo3BBZj8XBA0RsrEYyOVeH6TJ7qg0QbQAozmv
	jbG3D6Tj2qcb3vn6/YxL/EPx9yt5c8aR5dwFyDTf6+4TFqLreSL6X2LD
X-Gm-Gg: ASbGnctkMjVJr6Cb6V/P1773/H2pG/rtD4u5jRU1y68/joZwdpYMcWmbv3PE4+fKaH0
	XMUIUSoO7jEMdHe3sIMdIzDY2Vc/ny476LCETv3IK3R5CcaR2f4A5Ivf90u5rhKypTK7uY0SbTT
	s3xZpNjGYTuUGFbPd4o/60afVmcNJaU76CH4t67IdAn1AgmtvbnkEBGZCgOjEJe7RxChWHWOwrP
	IwsAuh1PHl7xuh09tEQ/BAAKgmSKSxH8tZnEJGug29TL8qJLw4oJXNaUXHQq0gPNgO4kHX9n5St
	9E3Ho74JZfskH02CAZqv4t/2gMwjTUAzikNKV4iM0GovQR5m7hiveScHIeMKtSUpa+O7PXlZ1CY
	CILe1lTEnV6UzgOH0BEbwo6zv8jHSqGeznA4WvP8q5hMC4cu4fAqftOHQkzeWxUQWgr5vPY7+k5
	YONo2BZPaRWJqI/YjvMliXEsgqGV/rD5VZmVMLG416OVZgfk2jek3tcIx7Vo26OwYDZpOivXI=
X-Google-Smtp-Source: AGHT+IHQFsWv2WZtyuikDXDSZcQC16eMKnf/MSqZRjYeCi+/xS7a8yMFYJt3MbTFP4GQ55NBuKaNJQ==
X-Received: by 2002:a5d:5d11:0:b0:427:7ad:cdac with SMTP id ffacd0b85a97d-429bd682c6dmr534666f8f.20.1761846932711;
        Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
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
Subject: [PATCH v2 08/13] serial: sh-sci: Add sci_is_rsci_type()
Date: Thu, 30 Oct 2025 17:55:12 +0000
Message-ID: <20251030175526.607006-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add sci_is_rsci_type() for RSCI port type. This will simplify the code
when the support added for RSCI_PORT_{SCI,SCIF} private PORT type.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6f396e1151d8..7cc2b622e270 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1008,6 +1008,11 @@ static int sci_handle_errors(struct uart_port *port)
 	return copied;
 }
 
+static bool sci_is_rsci_type(u8 type)
+{
+	return (type == SCI_PORT_RSCI || type == RSCI_PORT_SCI || type == RSCI_PORT_SCIF);
+}
+
 static int sci_handle_fifo_overrun(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
@@ -1016,7 +1021,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	int copied = 0;
 	u32 status;
 
-	if (s->type != SCI_PORT_RSCI) {
+	if (!sci_is_rsci_type(s->type)) {
 		reg = sci_getreg(port, s->params->overrun_reg);
 		if (!reg->size)
 			return 0;
@@ -1024,7 +1029,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		if (s->type == SCI_PORT_RSCI) {
+		if (sci_is_rsci_type(s->type)) {
 			s->ops->clear_SCxSR(port, s->params->param_bits->overrun_clr);
 		} else {
 			status &= ~s->params->overrun_mask;
@@ -1837,7 +1842,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 	unsigned long flags;
 	u32 ctrl;
 
-	if (s->type != PORT_SCI && s->type != SCI_PORT_RSCI)
+	if (s->type != PORT_SCI && !sci_is_rsci_type(s->type))
 		return sci_tx_interrupt(irq, ptr);
 
 	uart_port_lock_irqsave(port, &flags);
@@ -3112,7 +3117,7 @@ static int sci_init_single(struct platform_device *dev,
 	 * The fourth interrupt on SCI and RSCI port is transmit end interrupt, so
 	 * shuffle the interrupts.
 	 */
-	if (p->type == PORT_SCI || p->type == SCI_PORT_RSCI)
+	if (p->type == PORT_SCI || sci_is_rsci_type(p->type))
 		swap(sci_port->irqs[SCIx_BRI_IRQ], sci_port->irqs[SCIx_TEI_IRQ]);
 
 	/* The SCI generates several interrupts. They can be muxed together or
-- 
2.43.0

