Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF6450915;
	Tue, 28 Apr 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398877; cv=none; b=u9QFwhV41A2weV1i/tKF6nA8HH9z1s3W7T1yvqNQjus9GiCVgxdkGrzZVrwV85h9QpEpuuf2aJ7wP+zPYr5DyhB23BOmkq7Ovwm+0igRsG86cQ9PZR6+YJf0iP4rM7j74OSNa/8lOE1uaCb/4ZXUOk6hLc4Jxstw2AqhjeaPxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398877; c=relaxed/simple;
	bh=JiOdqUzOqSvFzaiuy1yqf6MtmcBEiohcgPOVOP4/lB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enKPsyTrhZRZtFvJk9HR0NpqLyn5dl3PJNfbRwXhnupteQkF2fBD1ir1KjXDo8lE6WuwZbJb5xYZgPSGNzxMlV8TtwYS6+yq6hnyzf4HQ9NSklUvVB45Z6mu/vzSiVqZIEMU0a7NOxe/w8kvaOfE8bHz/9W/GswptqndJCGf7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GudmAl+e; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GudmAl+e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=YZYiDWbW457QwQKFpo4Etol5I2BYhCkR5UyGIELMXRI=; b=GudmAl+ec3J4J/x5EQMpQcOdUm
	3TthZD/tgKOaWuc7aE5HmIJOZhMVsbgrHWl65vxuFqNnUQzcg+4Rvy4OSjRqESPGiXue/On05EO87
	3otcE6TiKAkFsW5zlMxdL668iS/sHh+Vp2cOcBYqbw+2shnWyF+LvuqcEvaHIjbcghG8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdm-000000004cz-3BC1;
	Tue, 28 Apr 2026 13:54:34 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:54:01 -0400
Subject: [PATCH v2 15/15] serial: uniformize serial port I/O infos display
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-15-01c1857cf761@dimonoff.com>
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

Uniformize serial port I/O infos display from three different functions
that display mostly the same information, but with some variations, by
adding a common function.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Maybe the width information could be dropped entirely?
---
 drivers/tty/serial/earlycon.c    | 13 +++-------
 drivers/tty/serial/serial_core.c | 52 +++++++++++++++++++++++++++-------------
 include/linux/serial_core.h      |  1 +
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index e799feaa14bf1ac7c1a5677cd84490e7c486449b..ce740cdc7cebffca0b4f6be98b8bca66540af72d 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -75,19 +75,12 @@ static void __init earlycon_print_info(struct earlycon_device *device)
 {
 	struct console *earlycon = device->con;
 	struct uart_port *port = &device->port;
-	char address[64] = "";
+	char ioinfos[64];
 
-	if (uart_iotype_mmio(port->iotype))
-		scnprintf(address, sizeof(address), " at MMIO%s %pa",
-			  (port->iotype == UPIO_MEM) ? "" :
-			  (port->iotype == UPIO_MEM16) ? "16" :
-			  (port->iotype == UPIO_MEM32) ? "32" : "32be",
-			  &port->mapbase);
-	else if (uart_iotype_legacy_io(port->iotype))
-		scnprintf(address, sizeof(address), " at I/O port 0x%lx", port->iobase);
+	uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
 
 	pr_info("%s%d%s (options '%s')\n", earlycon->name, earlycon->index,
-		address, device->options);
+		ioinfos, device->options);
 }
 
 static int __init parse_options(struct earlycon_device *device, char *options)
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0e015477848504e37afb34c8088957083f1662c7..b9a9225d99b616a7f691a8f990fd77ab02609012 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2002,6 +2002,7 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
 	struct tty_port *port = &state->port;
 	enum uart_pm_state pm_state;
 	struct uart_port *uport;
+	char ioinfos[64];
 	char stat_buf[32];
 	unsigned int status;
 
@@ -2013,10 +2014,8 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
 
 	seq_printf(m, "%u: uart:%s", uport->line, uart_type(uport));
 
-	if (uart_iotype_mmio(uport->iotype))
-		seq_printf(m, " mmio:%pa", &uport->mapbase);
-	else if (uart_iotype_legacy_io(uport->iotype))
-		seq_printf(m, " port:%08lX", uport->iobase);
+	uart_get_ioinfos(uport, ioinfos, sizeof(ioinfos));
+	seq_printf(m, "%s", ioinfos);
 
 	seq_printf(m, " irq:%u", uport->irq);
 
@@ -2480,26 +2479,47 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
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
+	} else if (uart_iotype_legacy_io(port->iotype)) {
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
-	char address[64] = "";
+	char ioinfos[64];
 
-	if (uart_iotype_mmio(port->iotype))
-		scnprintf(address, sizeof(address), " at MMIO %pa", &port->mapbase);
-	else if (uart_iotype_legacy_io(port->iotype)) {
-		if (port->iotype == UPIO_PORT)
-			scnprintf(address, sizeof(address), " at I/O 0x%lx", port->iobase);
-		else if (port->iotype == UPIO_HUB6)
-			scnprintf(address, sizeof(address), " at I/O 0x%lx offset 0x%x",
-				  port->iobase, port->hub6);
-	}
+	uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
 
 	pr_info("%s%s%s%s (irq = %u, base_baud = %u) is a %s\n",
 		port->dev ? dev_name(port->dev) : "",
 		port->dev ? ": " : "",
-		port->name,
-		address, port->irq, port->uartclk / 16, uart_type(port));
+		port->name, ioinfos, port->irq, port->uartclk / 16, uart_type(port));
 
 	/* The magic multiplier feature is a bit obscure, so report it too.  */
 	if (port->flags & UPF_MAGIC_MULTIPLIER)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 626dd939c53c9f920d71aadd360ec0ea0bacce0d..1289e812b40f3d7b7a02ff1a87eaf649e71e0d2f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1308,6 +1308,7 @@ static inline int uart_handle_break(struct uart_port *port)
 
 int uart_get_rs485_mode(struct uart_port *port);
 
+void uart_get_ioinfos(struct uart_port *port, char *buf, size_t size);
 bool uart_iotype_mmio(enum uart_iotype iotype);
 bool uart_iotype_legacy_io(enum uart_iotype iotype);
 

-- 
2.47.3

