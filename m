Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5713C806
	for <linux-serial@vger.kernel.org>; Thu, 11 Apr 2024 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815157; cv=none; b=fWyMejoiGhEE9tl3KnsO1Vu7NMQcUlPVNqlD0ZDMMzUGRvWlCXQNP1TsGl51gHyVXKeq5sv5YGd5kAKjL7Ohh8TGVgs14HJOXt4R/0Ys2GvrPI8Ia9fmAigvCP4G5qbC99afI6rt2fJoge9fLPFP0fRgH3rbn+/KP/Tg3pJNI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815157; c=relaxed/simple;
	bh=qxz7IOWA0L4mzPObN8LOqebnNnq50hs6MVSP51B7ij8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXWuwW1/v/ZGpqDxXXVymDwIX/gAoduPCthMd+u34m3Lxk4fp4ESjapUqt86xepWYGxinm9llGHjhpXJbHyvZ4Jbwp21COeiHPX0q/SdQTsY0S/A5dbadDUMfmu3fWvl7UeoHrCOjFjI4A293H7Ooxka4lngwPOAyNALUv8qXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=lwY61MJ2; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="lwY61MJ2"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 8853A603E6;
	Thu, 11 Apr 2024 05:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712815150;
	bh=qxz7IOWA0L4mzPObN8LOqebnNnq50hs6MVSP51B7ij8=;
	h=From:To:Cc:Subject:Date:From;
	b=lwY61MJ2QQh97Vslffm6S2Y/2XfxWbcRI2OEkqX1BCql6ysPdzPRk4pIycGf2IAPT
	 bSDXQel/epBMFpBKE0yGxEGhm7rw/5noGt8nvuy52aYhpmLxPasO1Ihw34ncUoIPM2
	 tOodXi66QeDoABuU54nETzTsNe7CcMszdjXuFcxuT06/ZdnXXtXuS1UIg/4xQx2VJr
	 mz6ID+ARh7v09ctgNHnCTcwvllrzJYFsJKwuSmTALMkzNTmdRaeotIdlKlrHkK84vY
	 GW48cvrPUximSve17wk85Q88LT3UdbapsHOjZXY0XmVVtLqfEfIgFB43kWAORFZWf/
	 GpUVNyBjjI9lQ==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org
Subject: [PATCH] serial: core: Fix missing shutdown and startup for serial base port
Date: Thu, 11 Apr 2024 08:58:45 +0300
Message-ID: <20240411055848.38190-1-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are seeing start_tx being called after port shutdown as noted by Jiri.
This happens because we are missing the startup and shutdown related
functions for the serial base port.

Let's fix the issue by adding startup and shutdown functions for the
serial base port to block tx flushing for the serial base port when the
port is not in use.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base.h |  4 ++++
 drivers/tty/serial/serial_core.c | 20 ++++++++++++++++---
 drivers/tty/serial/serial_port.c | 34 ++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -22,6 +22,7 @@ struct serial_ctrl_device {
 struct serial_port_device {
 	struct device dev;
 	struct uart_port *port;
+	unsigned int tx_enabled:1;
 };
 
 int serial_base_ctrl_init(void);
@@ -30,6 +31,9 @@ void serial_base_ctrl_exit(void);
 int serial_base_port_init(void);
 void serial_base_port_exit(void);
 
+void serial_base_port_startup(struct uart_port *port);
+void serial_base_port_shutdown(struct uart_port *port);
+
 int serial_base_driver_register(struct device_driver *driver);
 void serial_base_driver_unregister(struct device_driver *driver);
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -323,16 +323,26 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 			bool init_hw)
 {
 	struct tty_port *port = &state->port;
+	struct uart_port *uport;
 	int retval;
 
 	if (tty_port_initialized(port))
-		return 0;
+		goto out_base_port_startup;
 
 	retval = uart_port_startup(tty, state, init_hw);
-	if (retval)
+	if (retval) {
 		set_bit(TTY_IO_ERROR, &tty->flags);
+		return retval;
+	}
 
-	return retval;
+out_base_port_startup:
+	uport = uart_port_check(state);
+	if (!uport)
+		return -EIO;
+
+	serial_base_port_startup(uport);
+
+	return 0;
 }
 
 /*
@@ -355,6 +365,9 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 
+	if (uport)
+		serial_base_port_shutdown(uport);
+
 	if (tty_port_initialized(port)) {
 		tty_port_set_initialized(port, false);
 
@@ -1775,6 +1788,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	uport->ops->stop_rx(uport);
 	uart_port_unlock_irq(uport);
 
+	serial_base_port_shutdown(uport);
 	uart_port_shutdown(port);
 
 	/*
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -39,8 +39,12 @@ static int serial_port_runtime_resume(struct device *dev)
 
 	/* Flush any pending TX for the port */
 	uart_port_lock_irqsave(port, &flags);
+	if (!port_dev->tx_enabled)
+		goto unlock;
 	if (__serial_port_busy(port))
 		port->ops->start_tx(port);
+
+unlock:
 	uart_port_unlock_irqrestore(port, flags);
 
 out:
@@ -60,6 +64,11 @@ static int serial_port_runtime_suspend(struct device *dev)
 		return 0;
 
 	uart_port_lock_irqsave(port, &flags);
+	if (!port_dev->tx_enabled) {
+		uart_port_unlock_irqrestore(port, flags);
+		return 0;
+	}
+
 	busy = __serial_port_busy(port);
 	if (busy)
 		port->ops->start_tx(port);
@@ -71,6 +80,31 @@ static int serial_port_runtime_suspend(struct device *dev)
 	return busy ? -EBUSY : 0;
 }
 
+static void serial_base_port_set_tx(struct uart_port *port,
+				    struct serial_port_device *port_dev,
+				    bool enabled)
+{
+	unsigned long flags;
+
+	uart_port_lock_irqsave(port, &flags);
+	port_dev->tx_enabled = enabled;
+	uart_port_unlock_irqrestore(port, flags);
+}
+
+void serial_base_port_startup(struct uart_port *port)
+{
+	struct serial_port_device *port_dev = port->port_dev;
+
+	serial_base_port_set_tx(port, port_dev, true);
+}
+
+void serial_base_port_shutdown(struct uart_port *port)
+{
+	struct serial_port_device *port_dev = port->port_dev;
+
+	serial_base_port_set_tx(port, port_dev, false);
+}
+
 static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
 				 serial_port_runtime_suspend,
 				 serial_port_runtime_resume, NULL);
-- 
2.44.0
