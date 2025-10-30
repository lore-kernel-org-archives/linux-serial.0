Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C638374AC2
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847103; cv=none; b=O/NViFyVy8XnRQvonkk5JS2s5FCPN5Rt3Lu8bq6N6uUds1Ixtu11ZdcDVlg+CLwRGhzorLbHVyIDDHv9TkMAro/W9HRUbCs5i9QJ6T1KWy5q+X8dW0mW976v+lkRnOaVcvIyUZbx1MLRhQNvaVfSsmD/TABKycGcTlkACM+kXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847103; c=relaxed/simple;
	bh=vO9lAruIFRWwmcjhkElTrINqAF4ZFqyjtlRL6JeFb7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7yTMjQ9RjGdNcFjJW3SNP7AtG1H94G0D1P5mOFa2MVFBEzV5Gl6OgRxARjYfwnUyQburqXbOz2sufJpurz42WdbJbgHaIBpagvpxiUg5AJi8gXOvCNF+og0Ii6mG0eyt4mj16FHlWPpHhAYAZ4bwrBV0STGDQYATO0m+iReC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+3fxuz1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+3fxuz1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so13289585e9.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847098; x=1762451898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWj+7xNpysOeYb6zB5ArYmBB0QA2bqcJvV4UM5jfotc=;
        b=G+3fxuz1w6dLvNdBnSclQjsuzXUS/OCeDEFOcc66qghMNxL7Iy/2o143MmZRVvXZz1
         1spVp0vONa50xG30/qk5WeBwq9kGdXvP7Mx5klSK5nboaWcbytszB0J9hXp8Uo2KuHIm
         +2fS4Q/Cy7wLHIpblWV5dkIYSZtBPnqR6nIuQtLg9Nex2QVICZ3D5Yv8kRY0oTr9i7g2
         n/L5QbLcPuZqZ/Kz9vaIHMpMskZF4oKZVHNObkHIKd1WEC8dBcZQTGA8HeaULMYIZpPJ
         XWjCxt/f7GW3U3sc+qO9Hpeqyd0NGZ1q1+U/2vZ3S/5DeAt38in3bx/HZHJQUQOH7doI
         DUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847098; x=1762451898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWj+7xNpysOeYb6zB5ArYmBB0QA2bqcJvV4UM5jfotc=;
        b=LTd6Bx9WGMrovQPqyvnXHqCmVm9hUhZv8wd7tZZB8pN/opiRtkfoDzFweEN/8qS9pz
         DMDvfFMHQAGgY3pfaUe/CWi7C2rcRC8vpUEc2H0J5Lv7KnG6iaUiAp0qbXvW7Ttp6l7U
         Ml5qXGV9Z4geiqJ6MSHYtFAvZiERusKVF42PX3qsGTLsV/aHA5zJXRBoqLUK/MB3V/ir
         Eb0bRQEz/sVjc4iKrxh7pvU/TrZwbSNuWYTKNOJckZVTmDc7oqqDEK7hhllWgBhrdJyt
         ngl8wYBvaf7dkF4/iZBWrivQYlWda8ZYXcQ35QV6KV0Y9pF9jt6tHrKJVOu6cXgoXzdT
         2TrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiaURHOhPGoE7kXnk8SOE7FRXbttgc80YYEnA8CKweTiic+eojHiCowdtc3gJbLNTJGA4sEciBeTXyxTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4Sj95ut8Kk1G7GT1fUCWxwLuyoFNk8Ms4yUyC2gThFUpzkee
	9zabo435sRLSVo0VPS0zdcw+WuLN/tOgRL6gXGGO8C1h4YVhQEgiPxKO
X-Gm-Gg: ASbGnctFdImNgjz72wm6x4pI4wc8DoRZ1QN7ihXzuHVnZ22IpOz+TXOb/ZjAMAcsKDb
	rN8g0omXK8WVUp1DjENhsN9KbBGrxk2cqc+YV9D0TuruIH4rd2zkVdIGpIcMUzDADr+vm7n7qfG
	kHoh8BiGgR4Nbi6AHy5PhwAarUh6bBOfkGCh+sBngM6Ae+tXs1tIhSRtZDgQ39TiXdk6pCJBNJK
	P1R2j9Z+kINJ6P1VGURvt5gUW+kASVecdL0nT8pEu+neNXLDGwKHaBYl1bNbGaY1dau+R5jGYAn
	4gy7XNevkftoSh2//gLjRnK8xmk3Rd9gE8NbPSfgcW6QLtEjX9j7ba+rPSa0uatIqJgr20ggCbT
	WAUBAh3dQjymu3WHZ7sLhQwMUE/chPrxl1NQ/2LVLPmdRJrhXqssF8HctN1TGyjQeNqYfrKDmdu
	FeumLSh3QZX5DaimfNevPem/d5lHKum1FhDN/cFLu27C+7LC1DbWiFX84+l4Pr2yJ1ABKxHR0=
X-Google-Smtp-Source: AGHT+IHSLeHPyg7IKsaNF1Z5dRMW0XOJfQJfZIjvZOv3DXHqMuCpNkr1OVMVg0G9x3tsIeUBwjGQJA==
X-Received: by 2002:a05:600c:1e11:b0:475:faaa:8620 with SMTP id 5b1f17b1804b1-47730871febmr4732345e9.20.1761847098425;
        Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:57:56 +0000
Message-ID: <20251030175811.607137-9-biju.das.jz@bp.renesas.com>
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

