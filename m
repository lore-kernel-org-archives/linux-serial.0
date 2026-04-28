Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F145BD4E;
	Tue, 28 Apr 2026 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398879; cv=none; b=eucj4div0KIyetzFmGzM510egdjExn/PkqFYc9zGrC2uFJq2WMKCRUNH69EcNxFCwAcP4j+I3zqQ6U8f8+SiII/lC8GCGB7JE7v9g+9+vtVoTQvuaonsihtP8HrQrqAg6aGkjDsMTAP7IEbf57pxEk/QRtvC5sWAxJDafz4zVeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398879; c=relaxed/simple;
	bh=ebCdWMYWlez7UfIVV2TE4pe+AYW+8zJDAGyWak9OG2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjWzCFtnzBB2cNfAAlSmGmOt4bOkefo18ctjI+N1NuXRzsdZJJNGGLJ+pjtqpCv4eE8qngWWeCaUMFyvSoDfnmimbvNegRhMv95A+IZ3abaeT5IO0ngyxR/9sr9Nu0p1tYYse90hFjknOZNh0Uu/rh8FsJrXNETgF+RL81x7IGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=nPoaeDXo; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="nPoaeDXo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=WS5V+EdKE+IibOat+j1aDaCma+9TS5kYykyDoF5k13s=; b=nPoaeDXoNEIOpPX+c4yEiJAmiZ
	Tpo7ux8gmwOvH2SIzmOYpE83vsbd1gEHvv67xi8V7cZhAM/XcQ8MTzic4xodRh08M98CZPNcMyHw9
	TCCLQedBAVjyTFLOswHVmTjWagvF7rSRhu5YZU9v2E7utdjVbTuL9/EvrwNMB4Vjut8c=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdj-000000004cz-33JM;
	Tue, 28 Apr 2026 13:54:31 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:55 -0400
Subject: [PATCH v2 09/15] serial: 8250: use uart_iotype_*() to simplify
 code
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-9-01c1857cf761@dimonoff.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
In-Reply-To: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
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
index af78cc02f38e719573becd0aea226f7790555a3e..20b7de120b1bab596de22d09fdeff8361afd8b17 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -472,16 +472,10 @@ static void set_io_from_upio(struct uart_port *p)
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
@@ -2863,13 +2857,7 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
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
 
@@ -2883,14 +2871,9 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 				return -ENOMEM;
 			}
 		}
-		return 0;
-	case UPIO_HUB6:
-	case UPIO_PORT:
+	} else if (uart_iotype_legacy_io(port->iotype)) {
 		if (!request_region(port->iobase, size, "serial"))
 			return -EBUSY;
-		return 0;
-	case UPIO_UNKNOWN:
-		break;
 	}
 
 	return 0;
@@ -2901,15 +2884,9 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
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
@@ -2917,14 +2894,8 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 		}
 
 		release_mem_region(port->mapbase, size);
-		break;
-
-	case UPIO_HUB6:
-	case UPIO_PORT:
+	} else if (uart_iotype_legacy_io(port->iotype)) {
 		release_region(port->iobase, size);
-		break;
-	case UPIO_UNKNOWN:
-		break;
 	}
 }
 

-- 
2.47.3

