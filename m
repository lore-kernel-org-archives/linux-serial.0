Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9E327BF8;
	Thu, 23 Apr 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975319; cv=none; b=ioPIhddrfjtZMonf/0XP1Gw8nyMPfHpyuwTLfq48BPUPPQWvY42rKmkIH6tsIeiPtQEsKasHMdTPKQBRwUQsW01NUtSRRBp8HwongjDDDU1TghVwbIwmi0OZ2LzYT6/KIhi1mVBI8IMrxQsKpKgB0s5vbP9yyYYUsqUDHtHksE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975319; c=relaxed/simple;
	bh=6P4gjQeUyqkZF97RqGEygM/6K9ULdzSESt0MtGmufco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1TzZnp3Ka5eecXLdxkd9/sxlr+Fz4ITshypwhPy6LCZigXo2B1xwbv5SwSYUszRDqsS8awYcnn4i8X8CMUFuNlLAwAn6YoyTVZq46QRNv8GM2q9/ga5FxQE1BTfdjFSdpvOmewUi7BQxd5j6sinzkWzZ4+L7uLTnY8rn00s8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=UrxzoXvr; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="UrxzoXvr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=quJn6qAWbfnZA21v7/MH0nq0k/2d9IRwFrcWpCuqHkk=; b=UrxzoXvrAktC/NAQM/8ITqXkUd
	nLosFiohbHVlGxPWLZpNwKtawvFbqqmCwnmKA0el8Hp+kaXWCENoxA0S8jN/WhUvcqTu+7FWwVXBZ
	wxgSc0V7ZkGPCOB1Z3DqX/FTLXsS1Rx/UX1I7HpbufiBQnZz0jaVcT92Mz/zAu8F+zoc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S6-000000002qN-1gPK;
	Thu, 23 Apr 2026 16:15:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 23 Apr 2026 16:15:06 -0400
Subject: [PATCH 6/9] serial: core: prevent irrelevant I/O infos display for
 UPIO_BUS
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-tty-upio-v1-6-baf82d3b86d1@dimonoff.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
In-Reply-To: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

It doesn't make sense to display irrelevant MMIO or legacy I/O information
for serial devices on I2C or SPI busses. Now that we have a separate I/O
type for these types of devices, prevent display of I/O information for
them. Using uart_iotype_*() functions to do so also addresses the now
invalid check for "iotype >= UPIO_MEM".

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 50 ++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0bfdb69817e4259681fbc4658c9a68200aa2b65f..42559eda6fc134de77c3a7b850d565ebdc89e216 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2011,13 +2011,18 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
 	if (!uport)
 		return;
 
-	mmio = uport->iotype >= UPIO_MEM;
-	seq_printf(m, "%u: uart:%s %s%08llX irq:%u",
-			uport->line, uart_type(uport),
-			mmio ? "mmio:0x" : "port:",
-			mmio ? (unsigned long long)uport->mapbase
-			     : (unsigned long long)uport->iobase,
-			uport->irq);
+	seq_printf(m, "%u: uart:%s", uport->line, uart_type(uport));
+
+	mmio = uart_iotype_mmio(uport->iotype);
+
+	if (mmio || uart_iotype_legacy_io(uport->iotype)) {
+		seq_printf(m, " %s%08llX",
+			   mmio ? "mmio:0x" : "port:",
+			   mmio ? (unsigned long long)uport->mapbase
+			   : (unsigned long long)uport->iobase);
+	}
+
+	seq_printf(m, "irq:%u", uport->irq);
 
 	if (uport->type == PORT_UNKNOWN) {
 		seq_putc(m, '\n');
@@ -2482,31 +2487,20 @@ EXPORT_SYMBOL(uart_resume_port);
 static inline void
 uart_report_port(struct uart_driver *drv, struct uart_port *port)
 {
-	char address[64];
+	char address[64] = "";
 
-	switch (port->iotype) {
-	case UPIO_PORT:
-		snprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
-		break;
-	case UPIO_HUB6:
+	if (uart_iotype_mmio(port->iotype))
 		snprintf(address, sizeof(address),
-			 "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
-		break;
-	case UPIO_MEM:
-	case UPIO_MEM16:
-	case UPIO_MEM32:
-	case UPIO_MEM32BE:
-	case UPIO_AU:
-	case UPIO_TSI:
-		snprintf(address, sizeof(address),
-			 "MMIO 0x%llx", (unsigned long long)port->mapbase);
-		break;
-	default:
-		strscpy(address, "*unknown*", sizeof(address));
-		break;
+			 " at MMIO 0x%llx", (unsigned long long)port->mapbase);
+	else if (uart_iotype_legacy_io(port->iotype)) {
+		if (port->iotype == UPIO_PORT)
+			snprintf(address, sizeof(address), " at I/O 0x%lx", port->iobase);
+		else if (port->iotype == UPIO_HUB6)
+			snprintf(address, sizeof(address),
+				 " at I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
 	}
 
-	pr_info("%s%s%s at %s (irq = %u, base_baud = %u) is a %s\n",
+	pr_info("%s%s%s%s (irq = %u, base_baud = %u) is a %s\n",
 		port->dev ? dev_name(port->dev) : "",
 		port->dev ? ": " : "",
 		port->name,

-- 
2.47.3

