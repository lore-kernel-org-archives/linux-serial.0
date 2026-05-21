Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C43911D6;
	Thu, 21 May 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387429; cv=none; b=sibOCbuYltULh29VGNHXa20EwI79R3C4kHLOAmFWCJqmJY0Xspn2Fl96tOheM0vaGXRBtsYW2XLBgWFxrbn49VwGO6diSZmVdMuyiTqCpAk+ViBjMYCqsVRYH/bnEYJszHgAg7ms61kgEiKdeT74CXAF6e3IcucMzojlNvqgfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387429; c=relaxed/simple;
	bh=iLToBsHpSohULFc0EP+qWYer9ijRiHwJ3pqwmHWsAZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KD9pwZoFpbmIPgFacioc33XFmqePvr6uW1DiJm/H6hSg5tx8hni9kzy54yFs2/5np6MSx3D3d/kQvclaL+dM/Y1gt2fEm1lfVXw+v/hG827x+upJpF4GlZABT7oWcWPV3DxdE+tdfFlk7ZOl3//hw7szVgym0VvG2iGolNx91BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=j8LOtY+j; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="j8LOtY+j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=HDad8tre8cgLM6lKAS7gv2w3ffbeq2s30zMYuiKT/gM=; b=j8LOtY+j3BdxUyRw+a8xmzZ4Up
	lvYy9vDabmgHWdoK4cLbiCXAGKs1VKArOI/zGOCFq+J3qFYR74zP8HeD1sOPAkt3IgfFY2JyQa3Il
	dmDtPsoBr7CNGQHzEC0DhW0ovYkchGzo/w30Qaj+K9roensbDBpN+K/+aEC9c/L5Pjf0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ7x6-000000001yA-49S1;
	Thu, 21 May 2026 14:17:01 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 21 May 2026 14:16:51 -0400
Subject: [PATCH v3 05/10] serial: 8250: use uart_iotype_*() to simplify
 code
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-tty-upio-v3-5-bf74567994a0@dimonoff.com>
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
In-Reply-To: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
to simplify and improve code readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/8250/8250_port.c | 43 ++++++-------------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e4e6a53ebea39c376162690219347c1d2729c349..b36341c53f29025fec8787d3446ca95b27d60fea 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -474,16 +474,10 @@ static void set_io_from_upio(struct uart_port *p)
 static void
 serial_port_out_sync(struct uart_port *p, int offset, int value)
 {
-	switch (p->iotype) {
-	case UPIO_MEM:
-	case UPIO_MEM16:
-	case UPIO_MEM32:
-	case UPIO_MEM32BE:
-	case UPIO_AU:
+	if (uart_iotype_mmio(p->iotype)) {
 		p->serial_out(p, offset, value);
 		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
-		break;
-	default:
+	} else {
 		p->serial_out(p, offset, value);
 	}
 }
@@ -2865,13 +2859,7 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	unsigned int size = serial8250_port_size(up);
 	struct uart_port *port = &up->port;
 
-	switch (port->iotype) {
-	case UPIO_AU:
-	case UPIO_TSI:
-	case UPIO_MEM32:
-	case UPIO_MEM32BE:
-	case UPIO_MEM16:
-	case UPIO_MEM:
+	if (uart_iotype_mmio(port->iotype)) {
 		if (!port->mapbase)
 			return -EINVAL;
 
@@ -2885,14 +2873,9 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 				return -ENOMEM;
 			}
 		}
-		return 0;
-	case UPIO_HUB6:
-	case UPIO_PORT:
+	} else if (uart_iotype_io(port->iotype)) {
 		if (!request_region(port->iobase, size, "serial"))
 			return -EBUSY;
-		return 0;
-	case UPIO_UNKNOWN:
-		break;
 	}
 
 	return 0;
@@ -2903,15 +2886,9 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 	unsigned int size = serial8250_port_size(up);
 	struct uart_port *port = &up->port;
 
-	switch (port->iotype) {
-	case UPIO_AU:
-	case UPIO_TSI:
-	case UPIO_MEM32:
-	case UPIO_MEM32BE:
-	case UPIO_MEM16:
-	case UPIO_MEM:
+	if (uart_iotype_mmio(port->iotype)) {
 		if (!port->mapbase)
-			break;
+			return;
 
 		if (port->flags & UPF_IOREMAP) {
 			iounmap(port->membase);
@@ -2919,14 +2896,8 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 		}
 
 		release_mem_region(port->mapbase, size);
-		break;
-
-	case UPIO_HUB6:
-	case UPIO_PORT:
+	} else if (uart_iotype_io(port->iotype)) {
 		release_region(port->iobase, size);
-		break;
-	case UPIO_UNKNOWN:
-		break;
 	}
 }
 

-- 
2.47.3

