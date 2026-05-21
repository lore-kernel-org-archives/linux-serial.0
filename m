Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2BD392C24;
	Thu, 21 May 2026 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387427; cv=none; b=oBT68j9W2syBEoyZDxakoeyQlFWeVqECmfchMx5Zdab2eFWe1z3sTbL7zmrKw1gvvNooo2RmLzdta8+jsEwIEYO9TJSv0vUkt6PcWE/fd2XEGmfGCH/ktK3p2aV7WOaXid5eUaBbHPM7r3/Q7gBOOgEN+jMU50X7BMdk+GEqlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387427; c=relaxed/simple;
	bh=xAfxlgIZOmXbsfxkWwWdKSvtGRKGkB/k3Yw4+WVTV+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojN4vDJKkXrCEsZZd8EKGQnZn3gm9gvm9sjFIzcZPpsvkXBYj/ohFa2oTD9DCVsIOFIzBqIcpS07DmY3PUUZVfnRpPBpTDTEVG21wVkybXbIW6rkPApULf5xLl+Vni7QSL65IPSe+VmBbEdtoKlUDUR0ICrIRZWC538OaZOv4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=P+RNspkt; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="P+RNspkt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=JSlVFx7yAh0ri4eqZWT3jRqu7SdSqmFuII1RYG3NWtI=; b=P+RNspkt7ovMcYHiNdp5x3b6A4
	JzsxRVTjtrK/0feHV72ZbntTxxmqpsy6mK4LcmZliHOUUglvNAD1F3JClN//W6lqlXjiPYWYeGpDI
	2Sg0s23lfgRV7zeCCcI2DK68PvYY9/8q9Xlr3M2oFx+8BIhh97gstDioA4mmZ43xszgA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ7x6-000000001yA-0b3U;
	Thu, 21 May 2026 14:17:00 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 21 May 2026 14:16:50 -0400
Subject: [PATCH v3 04/10] serial: uniformize serial port I/O infos display
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-tty-upio-v3-4-bf74567994a0@dimonoff.com>
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

Uniformize serial port I/O infos display from three different functions
that display mostly the same information, but with some variations, by
adding a common function.

This make use of new functions uart_iotype_mmio() and
uart_iotype_legacy_io() to simplify and improve code readability.
This will prevent displaying irrelevant information for future IO types
(ex: UPIO_BUS), while also addressing the (eventually) invalid check for
"iotype >= UPIO_MEM".

This also allows us to remove the confusing cast to (unsigned long long)
for iobase which is defined as an unsigned long, and use %pa to display the
mapbase pointer, as it is done in earlycon_print_info().

Replace snprintf with more robust scnprintf so we could perhaps one day get
rid of snprintf() entirely.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
On 32-bit cpu:
  no changes.
On 64-bit cpu:
  # cat /proc/tty/driver/sci
  before
    serinfo:1.0 driver revision:
    0: uart:scif mmio:0x1004B800 irq:35 tx:11192 rx:37 RTS|CTS|DTR|DSR|CD
  after:
    serinfo:1.0 driver revision:
    0: uart:scif mmio:0x000000001004b800 irq:35 tx:11339 rx:35 RTS|CTS|DTR|DSR|CD

Using uart_iotype_mmio() now includes the case for UPIO_TSI and UPIO_AU,
which fell before this patch in the else clause.
UPIO_TSI is no longer used by any driver, so not an issue.
UPIO_AU, if this is even possible for earlycon, falls into the "MMIO" category
in uart_line_info() and uart_report_port()...

Maybe the width information could be dropped entirely?
---
 drivers/tty/serial/earlycon.c    | 17 +++------
 drivers/tty/serial/serial_core.c | 76 ++++++++++++++++++++++------------------
 include/linux/serial_core.h      |  1 +
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index ab9af37f6cda35ea2e3ea966fdac8ba5c4475cb2..ce740cdc7cebffca0b4f6be98b8bca66540af72d 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -75,19 +75,12 @@ static void __init earlycon_print_info(struct earlycon_device *device)
 {
 	struct console *earlycon = device->con;
 	struct uart_port *port = &device->port;
+	char ioinfos[64];
 
-	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
-	    port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
-		pr_info("%s%d at MMIO%s %pa (options '%s')\n",
-			earlycon->name, earlycon->index,
-			(port->iotype == UPIO_MEM) ? "" :
-			(port->iotype == UPIO_MEM16) ? "16" :
-			(port->iotype == UPIO_MEM32) ? "32" : "32be",
-			&port->mapbase, device->options);
-	else
-		pr_info("%s%d at I/O port 0x%lx (options '%s')\n",
-			earlycon->name, earlycon->index,
-			port->iobase, device->options);
+	uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
+
+	pr_info("%s%d%s (options '%s')\n", earlycon->name, earlycon->index,
+		ioinfos, device->options);
 }
 
 static int __init parse_options(struct earlycon_device *device, char *options)
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 432281c96f80ce3be317e3f53324923292b3eb44..afc7c1421ad54aeb7492bbda670939498b9018fc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1998,9 +1998,9 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
 	struct tty_port *port = &state->port;
 	enum uart_pm_state pm_state;
 	struct uart_port *uport;
+	char ioinfos[64];
 	char stat_buf[32];
 	unsigned int status;
-	int mmio;
 
 	guard(mutex)(&port->mutex);
 
@@ -2008,13 +2008,10 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
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
+	uart_get_ioinfos(uport, ioinfos, sizeof(ioinfos));
+	seq_printf(m, "%s", ioinfos);
+	seq_printf(m, " irq:%u", uport->irq);
 
 	if (uport->type == PORT_UNKNOWN) {
 		seq_putc(m, '\n');
@@ -2476,38 +2473,47 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 }
 EXPORT_SYMBOL(uart_resume_port);
 
+static const char *uart_get_mmio_width(struct uart_port *port)
+{
+	switch (port->iotype) {
+	case UPIO_MEM16:
+		return "16";
+	case UPIO_MEM32:
+	case UPIO_MEM32BE:
+		return "32be";
+	case UPIO_AU:
+	case UPIO_MEM:
+	default:
+		return "";
+	}
+}
+
+void uart_get_ioinfos(struct uart_port *port, char *buf, size_t size)
+{
+	buf[0] = '\0';
+
+	if (uart_iotype_mmio(port->iotype)) {
+		scnprintf(buf, size, " MMIO%s:%pa", uart_get_mmio_width(port), &port->mapbase);
+	} else if (uart_iotype_io(port->iotype)) {
+		if (port->iotype == UPIO_PORT)
+			scnprintf(buf, size, " I/O:0x%lx", port->iobase);
+		else if (port->iotype == UPIO_HUB6)
+			scnprintf(buf, size, " I/O:0x%lx, offset 0x%x", port->iobase, port->hub6);
+	}
+}
+EXPORT_SYMBOL(uart_get_ioinfos);
+
 static inline void
 uart_report_port(struct uart_driver *drv, struct uart_port *port)
 {
-	char address[64];
+	char ioinfos[64];
 
-	switch (port->iotype) {
-	case UPIO_PORT:
-		snprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
-		break;
-	case UPIO_HUB6:
-		snprintf(address, sizeof(address),
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
-	}
+	uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
 
-	pr_info("%s%s%s at %s (irq = %u, base_baud = %u) is a %s\n",
-	       port->dev ? dev_name(port->dev) : "",
-	       port->dev ? ": " : "",
-	       port->name,
-	       address, port->irq, port->uartclk / 16, uart_type(port));
+	pr_info("%s%s%s%s (irq = %u, base_baud = %u) is a %s\n",
+		port->dev ? dev_name(port->dev) : "",
+		port->dev ? ": " : "",
+		port->name, ioinfos, port->irq, port->uartclk / 16, uart_type(port));
 
 	/* The magic multiplier feature is a bit obscure, so report it too.  */
 	if (port->flags & UPF_MAGIC_MULTIPLIER)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a06da6b24c1ad48afffa1e355377992aec0debff..b91ad22be11b0d0b82928b9277cf29807796830e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1319,6 +1319,7 @@ static inline int uart_handle_break(struct uart_port *port)
 
 int uart_get_rs485_mode(struct uart_port *port);
 
+void uart_get_ioinfos(struct uart_port *port, char *buf, size_t size);
 bool uart_iotype_mmio(enum uart_iotype iotype);
 bool uart_iotype_io(enum uart_iotype iotype);
 

-- 
2.47.3

