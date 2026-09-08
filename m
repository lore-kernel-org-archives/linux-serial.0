Received: from va-2-26.ptr.blmpb.com (va-2-26.ptr.blmpb.com [209.127.231.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A46556BBB
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876941; cv=none; b=EUtv+KKg7lXvqnzphZp7e8ckZUW7Rs3PZ1iWnbu/Y5mS5PD7FEtktsiqrsMJ6RMqnfL+3X2NKV0kgzSqfir42/hEHnnVtup2SOeWuDOOd+Or9d+KkgjLQ2lG+e12/lxKEEkIBTvWvbL0tb//rmPmFPGboJUoYkD0uWq+0xdxmY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876941; c=relaxed/simple;
	bh=WbRONzMQ/kwQsAeLtudKmzBlGmNDGSDc20uABv49DFI=;
	h=Date:Mime-Version:Content-Type:To:Cc:Subject:From:Message-Id; b=ndgbOI0oanwEtCc2baQ2OWwsG52eZUCzTah1Y8j4K1HbYE5CyPl8uIum2ViiXPP8NStHhPKUgjcBlFecvTPNCWtsUQ6g6Z0JxF/2dw9zEDAwKUZEyWcTCgfxs7Aii4nipsnfUE2hRTVvy8s7sPBnqEH1XRwWYWsQZQ4TBLBObpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=ChSTBG3K; arc=none smtp.client-ip=209.127.231.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="ChSTBG3K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1788876929; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=NykhdQB85wUFqWXBB887LtHXqWSwd719YTZAAMOLWjc=;
 b=ChSTBG3Kk2+JbCxDM4hqRHK7ZGUdfiEuJTjfzZshaLHRbbeIrp/yAjwoJWKJDLFSOISviq
 iIKfLlunFw09pVvk0UDMGB6H1V5hJBI6rkumuLbYHgosqRDT9Nu1EdPwkq35e/UpliitXS
 T0odLJ9atvDGeF+3rIPUYw+2w3WH9MZirIXCUyAH0c4P4DBINAyILJPsMDtIRVTxXHGyp2
 ALM+t/UfSpbpHJxxSLlq+r4QyOYtWWJpp7EpAdiXehHnRo00g82Vhzqqiqh4aSQeHPMdZH
 K91Q/6s75gOzHsHfpugaCxyPGvl0qN2bqCZgYlDT3JwhsS/h3P796XDW1I1gQA==
Date: Tue,  8 Sep 2026 22:15:24 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26aa0187f+53c00f+vger.kernel.org+yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
To: <ilpo.jarvinen@linux.intel.com>, <andriy.shevchenko@linux.intel.com>, 
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, 
	<geshijian@picoheart.com>, <yangyang.8776@picoheart.com>, 
	<yanligen@picoheart.com>, <yang.yicong@picoheart.com>
Subject: [PATCH v3] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available
X-Mailer: git-send-email 2.50.1
Received: from G9WYR9K0VW.bytedance.net ([61.141.241.110]) by smtp.feishu.cn with ESMTPS; Tue, 08 Sep 2026 22:15:26 +0800
From: "Yicong Yang" <yang.yicong@picoheart.com>
Message-Id: <20260908141524.20302-1-yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>

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
Change since v1:
- refine the comments and type per Andy
Link: https://lore.kernel.org/linux-serial/20260907074035.77796-1-yang.yicong@picoheart.com/

Change since v1:
- simply the workaround path per Ilpo and Andy
- run ~48k reboot tests and didn't reproduce the issue
Link: https://lore.kernel.org/linux-serial/20260629075510.32854-1-yang.yicong@picoheart.com/

 drivers/tty/serial/8250/8250_dw.c    | 9 ++++++++-
 drivers/tty/serial/8250/8250_dwlib.c | 5 +++++
 drivers/tty/serial/8250/8250_dwlib.h | 5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

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
index 1fe52332e774..ee7a07fac0f6 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -13,6 +13,7 @@
 #include "8250.h"
 
 /* Offsets for the DesignWare specific registers */
+#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
 #define DW_UART_USR	0x1f /* UART Status Register */
 #define DW_UART_DMASA	0xa8 /* DMA Software Ack */
 #define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
@@ -90,6 +91,10 @@ struct dw8250_port_data {
 
 	/* RS485 variables */
 	bool			hw_rs485_support;
+
+	/* Register offsets */
+	/* Shadow RBR (if not defined RBR will be used) */
+	int		srbr;
 };
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
-- 
2.50.1 (Apple Git-155)
