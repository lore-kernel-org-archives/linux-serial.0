Received: from va-2-43.ptr.blmpb.com (va-2-43.ptr.blmpb.com [209.127.231.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522453BED5C
	for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719728; cv=none; b=msMy8RBXF0axY/5fcpUYGswlmVZ/uGKTMd9TwL6C3iCRyeh/mfdVdhRYEBQz6bBbu75omfNpCVnP968dv8A0y8ml6nqNjxBxa1plvjSGdCOJKGvsTTXXBRW8QmhhnvPEIQyV6s4p9OKN19nQKJL096Nhp7ZrlYfzjHQtW359Ffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719728; c=relaxed/simple;
	bh=boR/JvTkE5LGgsrIR++1r01ZXUbqV9YoBfloThC6LiA=;
	h=Content-Type:Cc:From:Date:To:Message-Id:Mime-Version:Subject; b=sgI48VN1r7iVxeZrXjFM2WK+NxH/M2hNBKceDbt4oNzNudC/+tJVUoJTREekHoSJ7tsHyCbmTBpUVGDWlbBQizGCqQ1E9P6prSpcwaCp7b7IhQ3G42dOaBQ6WP2p8s9peo2ojIIGQWpRWRnketS+cq75Pnu7OVYUE7dI+QrXe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=Qb1U4o3j; arc=none smtp.client-ip=209.127.231.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="Qb1U4o3j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782719715; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TfieDjdZ8KlO85OrSoRgsZ7yXEeGZWpBbeqmUypvoIE=;
 b=Qb1U4o3js0gpStkZt39FqwKQYPDRmPgWXMoQdcQmq4zo5liU4acn5Q+wlkbz8yvMLB+nMn
 tRVRfy4Uuxc1Cl4MnHLNDqKHXp438w3m8IAx2znOPc15C6o/W6vWfBEP4zs+3sD4FAw0O6
 8tg5LAa4bSM6sR5apltwGAlavBcpP4Vb56UcmYzxq66ffBlVUIzms4rChJUDmVbSyffwWQ
 y59VQmVWacS8BVP43uwFXl4Re5ZDnSvP20NVpeomlHLAA9/R0RLc/unVhAfqyDJ3WLCpup
 Qh8O6fxU3Ffkk3gJW9Lt4JekKO3Uf3/cGjLMtX6MVro/ubRcyEaC5g3kdDePDA==
Content-Type: text/plain; charset=UTF-8
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, 
	<geshijian@picoheart.com>, <yangyang.8776@picoheart.com>, 
	<yanligen@picoheart.com>, <yang.yicong@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Date: Mon, 29 Jun 2026 15:55:10 +0800
Content-Transfer-Encoding: 7bit
Received: from G9WYR9K0VW.bytedance.net ([58.250.106.116]) by smtp.feishu.cn with ESMTPS; Mon, 29 Jun 2026 15:55:12 +0800
To: <ilpo.jarvinen@linux.intel.com>, <andriy.shevchenko@linux.intel.com>, 
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20260629075510.32854-1-yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
X-Lms-Return-Path: <lba+26a4224e1+716de7+vger.kernel.org+yang.yicong@picoheart.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available

The DW uart could get into the cases where a bogus RX timeout
interrupt is asserted but no available data. This could be
workaround by doing a bogus read.

Currently the driver's using the standard RBR (receive buffer
register) for this bogus read. However the reading of RBR
in this case is allowed to raise a hardware error if vendor
choose to implement in this way (our platform). It's also
allowed to do the bogus read using SRBR (shadow RBR) for
workaround which won't raise the hardware error. So change
to use the SRBR to workaround the issue if it's available.

Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 15 +++++++++++++--
 drivers/tty/serial/8250/8250_dwlib.c |  3 +++
 drivers/tty/serial/8250/8250_dwlib.h |  4 ++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 84ffba045ffa..fea7dfa30e78 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -440,8 +440,19 @@ static int dw8250_handle_irq(struct uart_port *p)
 	if (!up->dma && rx_timeout) {
 		status = serial_lsr_in(up);
 
-		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
-			serial_port_in(p, UART_RX);
+		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
+			/*
+			 * Do the bogus read from Shadow RBR (SRBR) if provided.
+			 * Both RBR and SRBR are supported ways to workaround
+			 * this problem. But read RBR can cause hardware error
+			 * (PSLVERR) if hardware choose to implement in this way
+			 * (implement REG_TIMEOUT_WIDTH to 0), whereas SRBR won't.
+			 */
+			if (d->data.shadow_support)
+				serial_port_in(p, DW_UART_SRBR_0);
+			else
+				serial_port_in(p, UART_RX);
+		}
 	}
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 8859e66d2d71..19d997a59541 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -247,5 +247,8 @@ void dw8250_setup_port(struct uart_port *p)
 
 	if (reg & DW_UART_CPR_SIR_MODE)
 		up->capabilities |= UART_CAP_IRDA;
+
+	if (reg & DW_UART_CPR_SHADOW)
+		pd->shadow_support = true;
 }
 EXPORT_SYMBOL_GPL(dw8250_setup_port);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 1fe52332e774..3ad412d984ed 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -13,6 +13,7 @@
 #include "8250.h"
 
 /* Offsets for the DesignWare specific registers */
+#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
 #define DW_UART_USR	0x1f /* UART Status Register */
 #define DW_UART_DMASA	0xa8 /* DMA Software Ack */
 #define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
@@ -90,6 +91,9 @@ struct dw8250_port_data {
 
 	/* RS485 variables */
 	bool			hw_rs485_support;
+
+	/* Support Shadow registers */
+	bool			shadow_support;
 };
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
-- 
2.50.1 (Apple Git-155)
