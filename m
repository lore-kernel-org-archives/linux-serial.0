Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D8329C6D;
	Thu, 23 Apr 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975318; cv=none; b=Nx4aHSpmM+t+cjIbDzZi8//TpMXFojD33XFq4TVIppVWpEOnhB9YZG00fVZaaQb8AP0PGrhMSpzVwCtUFpzBC8s7PWzaYJTAD+i3byPNPuGYPflloAAPQ0pBA99DqRV/QT0rcEApPkZAm4EjMEBBWoSjCScQmx3nbMEFe0aSJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975318; c=relaxed/simple;
	bh=wWkMJWIt0ExRFLiKWzv1z0v7Lu1/jhfaN7tLbfJTw1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNTPIRT7JLm2KPElbAFGyiLfZvHrHobqC2i+0mOnUMz92y5cOwra/yzyAb1G8z8btWLg2LQKdnatv714RJgyM1YF1rhicw0Z5HvmRVrgnXIhn+LOHQXiSLJBfDDt1h2LTe9Yd8HOo2m6aZGh9QTYJkS/huAGf5OWh97Gpb3DYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=euqFzGhs; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="euqFzGhs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=5K0LF2cYsT8/QNb5H9rVhaoZksrMaH8jYl8JUmn2GeY=; b=euqFzGhsvrSt3R56wVHH4VOl0v
	/GEaG5HhrWzVmkGjD56ABvkkdEO6g0bQaM5Z7qREfA8GqMDGImZDJUnNE1TLoRzJK+aXfS7DL0BNf
	Uclv0yC5P4AuYjB2qF8nXN3OFwUicwCOJgNBVLzWs0xVZ+tnMIOi2NAPOg/U6MSv0r/Q=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S4-000000002qN-3DTV;
	Thu, 23 Apr 2026 16:15:08 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 23 Apr 2026 16:15:03 -0400
Subject: [PATCH 3/9] serial: 8250: use uart_iotype_*() to simplify code
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-tty-upio-v1-3-baf82d3b86d1@dimonoff.com>
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

Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
to simplify and improve code readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/8250/8250_port.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index af78cc02f38e719573becd0aea226f7790555a3e..48ff4cad028ff0b6a9c7167ea8d793b3cb0f32da 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2863,13 +2863,7 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
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
 
@@ -2883,14 +2877,9 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
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
@@ -2901,15 +2890,9 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
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
@@ -2917,14 +2900,8 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
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

