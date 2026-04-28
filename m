Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518B45BD57;
	Tue, 28 Apr 2026 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398879; cv=none; b=fcTDbptE6+BQkZSZVzg+TqTPLX6uP+1dKT0NCVwmy90NJKs0B4XSDQIydQkzSzngKsTm933gSHxZ640GBkfyyWhjffxcpBbhres4havDidVn7nsKD5vkoJ0os1YkaWHR4K816HcSgYEpWdzYhHsJKJWpPFuYh8PAcv0OPgwrHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398879; c=relaxed/simple;
	bh=iZPMGPt9wRMFYzKXfEfBzoq53zZoKlJ/IYKhZLS1dHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldpovO5gLTQNqGKwLKymnNHMWJ7HTLGzwq2pfw+8CylamIBI88AWWL5ls2GYhDMv2VrOT6A6dbCPSPN+7rcyb9YJYbEDiCm/A4OkqnJ3KG3RYkK4LYFNq802qfgo9P4vYBppDLmTwTG2quiCTlM4KJdwwOd8xZ5s8xLyD7Fsr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=vGoemfAD; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="vGoemfAD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=kSikfwMOTFC1nv1oE1sWrNsPzqXqxKIVOB637a3FBFM=; b=vGoemfAD3WAm5KGpYSzpL6gp7I
	5ynPab+Lwa8gvmxG4QzYEWdPpJSfLtZ1NbvacmEjcR7Xh3HeNm1lVDN3lZwSJnr21NbtwP9Borim5
	oShD8Qlavrsqx1txglqT1g6Se43iNeRmdVBy9oNlqDJkEU8WHY7QCpgyd6O92jrTaOhc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdi-000000004cz-3B2D;
	Tue, 28 Apr 2026 13:54:30 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:53 -0400
Subject: [PATCH v2 07/15] serial: core: use uart_iotype_*() to simplify
 uart_report_port()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-7-01c1857cf761@dimonoff.com>
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
to simplify and improve code readability. It will also prevent displaying
irrelevant I/O information for future IO types (ex: UPIO_BUS). Use %pa to
display the mapbase pointer, as it is done in earlycon_print_info().

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
On 32-bit cpu:
  no changes.
On 64-bit cpu:
  before:
    1004b800.serial: ttySC0 at MMIO 0x1004b800 (irq = 35, base_baud = 0) is a scif
    1004bc00.serial: ttySC1 at MMIO 0x1004bc00 (irq = 40, base_baud = 0) is a scif
  after:
    1004b800.serial: ttySC0 at MMIO 0x000000001004b800 (irq = 35, base_baud = 0) is a scif
    1004bc00.serial: ttySC1 at MMIO 0x000000001004bc00 (irq = 40, base_baud = 0) is a scif
---
 drivers/tty/serial/serial_core.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e9986f9221f946c9075a8eea7ac28d2ad818f095..d0d4dba41fb9ee43403391d9d599abc1d64b48ec 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2483,31 +2483,19 @@ EXPORT_SYMBOL(uart_resume_port);
 static inline void
 uart_report_port(struct uart_driver *drv, struct uart_port *port)
 {
-	char address[64];
+	char address[64] = "";
 
-	switch (port->iotype) {
-	case UPIO_PORT:
-		scnprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
-		break;
-	case UPIO_HUB6:
-		scnprintf(address, sizeof(address),
-			  "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
-		break;
-	case UPIO_MEM:
-	case UPIO_MEM16:
-	case UPIO_MEM32:
-	case UPIO_MEM32BE:
-	case UPIO_AU:
-	case UPIO_TSI:
-		scnprintf(address, sizeof(address),
-			  "MMIO 0x%llx", (unsigned long long)port->mapbase);
-		break;
-	default:
-		strscpy(address, "*unknown*", sizeof(address));
-		break;
+	if (uart_iotype_mmio(port->iotype))
+		scnprintf(address, sizeof(address), " at MMIO %pa", &port->mapbase);
+	else if (uart_iotype_legacy_io(port->iotype)) {
+		if (port->iotype == UPIO_PORT)
+			scnprintf(address, sizeof(address), " at I/O 0x%lx", port->iobase);
+		else if (port->iotype == UPIO_HUB6)
+			scnprintf(address, sizeof(address), " at I/O 0x%lx offset 0x%x",
+				  port->iobase, port->hub6);
 	}
 
-	pr_info("%s%s%s at %s (irq = %u, base_baud = %u) is a %s\n",
+	pr_info("%s%s%s%s (irq = %u, base_baud = %u) is a %s\n",
 		port->dev ? dev_name(port->dev) : "",
 		port->dev ? ": " : "",
 		port->name,

-- 
2.47.3

