Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC983A3E88
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766852; cv=none; b=NQVu5YFR2uj9T3VfF/d5AopTNULMzZxbdIgkXYtLcgtv8MyQ5YX8SylVItetx18eUqOHO/1Z2aRMYw4hp+aL4gehxClmXNzfQtXXeR0lTxAx1qxxQ2/91fj079ANyjBQFiI6oCHUCFo8ecEclh6V5XXWK309L2BLw/eMo9z7oJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766852; c=relaxed/simple;
	bh=vQ4HR0rS9VV1xECuv/0Ij1hTnV4N+v5NovMySYZ+8o4=;
	h=Date:To:Cc:Subject:Message-Id:From:Mime-Version:Content-Type; b=PE84+1v630Uj5+sP0S7ZoxYBoo5d8YE1O0g39w2Y0xkZkA3+KBjqS8miiaDzTT6/YE/kvlVg85SVFR/fLTYmUz8eACoxHGbT5WNxHiqYDyPGqXwaKGvuqw3MU9TSdQcWiGsq5CXVq4CZ4ZQy+bCWnircro+VvstqMwTt9Mqcgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=sOnONi/d; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="sOnONi/d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1788766842; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=i7yENuuhi6IpdRLlbRIkk6mj1PRrMmAahZjXGiRuTao=;
 b=sOnONi/dCHhAxy/j9RY2+WkrwpBKShSHgcYY/McpCvcALkiuo/KtLhe2gbO2O4JBXlMVwB
 w+ZxsUE4s2JIhWECpkwqeQffP66HZkq2AQQabH9Nu9ScEGyIlJe9HdCRedavAQfx85fOIk
 f5vc2JMDX18XKDGAE16/Cbe827Shv0yy1oWICKu1v7slo4SBBvLGoYjR9r1oVRRKkIAxZ9
 KQOtRmk8M1yyut6YMCfYWvUXcm2rBP+T7TOEVWI3vy5hSOXKUrE9ZIXFQtPQQSU+KrHLzm
 7WwJYpEpNDr4G6ITws/n3YAxnwPupIUZZTrBE77WHJYzTNr3dnkmCB2nNUDhLg==
Date: Mon,  7 Sep 2026 15:40:35 +0800
X-Lms-Return-Path: <lba+26a9e6a78+7023ff+vger.kernel.org+yang.yicong@picoheart.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 7bit
To: <ilpo.jarvinen@linux.intel.com>, <andriy.shevchenko@linux.intel.com>, 
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, 
	<geshijian@picoheart.com>, <yangyang.8776@picoheart.com>, 
	<yanligen@picoheart.com>, <yang.yicong@picoheart.com>
Subject: [PATCH v2] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available
Message-Id: <20260907074035.77796-1-yang.yicong@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Received: from G9WYR9K0VW ([120.234.49.250]) by smtp.feishu.cn with ESMTPS; Mon, 07 Sep 2026 15:40:39 +0800

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
Change since v2:
- simply the workaround path per Ilpo and Andy
- run ~48k reboot tests and didn't reproduce the issue
Link: https://lore.kernel.org/linux-serial/20260629075510.32854-1-yang.yicong@picoheart.com/

 drivers/tty/serial/8250/8250_dw.c    | 9 ++++++++-
 drivers/tty/serial/8250/8250_dwlib.c | 5 +++++
 drivers/tty/serial/8250/8250_dwlib.h | 4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 51d026f20825..b8a0bca8b536 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -439,8 +439,15 @@ static int dw8250_handle_irq(struct uart_port *p)
 	if (!up->dma && rx_timeout) {
 		status = serial_lsr_in(up);
 
+		/*
+		 * Do the bogus read from Shadow RBR (SRBR) if provided.
+		 * Both RBR and SRBR are supported ways to workaround
+		 * this problem. But read RBR can cause hardware error
+		 * (PSLVERR) if hardware choose to implement in this way
+		 * (implement REG_TIMEOUT_WIDTH to 0), whereas SRBR won't.
+		 */
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
-			serial_port_in(p, UART_RX);
+			serial_port_in(p, d->data.srbr);
 	}
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 8859e66d2d71..9bb02a4ab11f 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -247,5 +247,10 @@ void dw8250_setup_port(struct uart_port *p)
 
 	if (reg & DW_UART_CPR_SIR_MODE)
 		up->capabilities |= UART_CAP_IRDA;
+
+	if (reg & DW_UART_CPR_SHADOW)
+		pd->srbr = DW_UART_SRBR_0;
+	else
+		pd->srbr = UART_RX;
 }
 EXPORT_SYMBOL_GPL(dw8250_setup_port);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 1fe52332e774..6cfe2ab2e2a0 100644
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
+	/* Shadow RBR offset, fallback to RBR if no shadow register support */
+	unsigned int		srbr;
 };
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
-- 
2.50.1 (Apple Git-155)
