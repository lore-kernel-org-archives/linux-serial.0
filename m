Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC347D92F
	for <linux-serial@vger.kernel.org>; Thu,  6 Aug 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030943; cv=none; b=V2lidgCb4kT73k7K9jXJphClqJrK6cICYaarlQCk7lJBgNCbkL8EOGilXrnZdpVcNQfrJpqAz3VHmYOZMehFtsKy2sen+ZYir21gl6TQ6nYyyiSckqjvlTzhUJFUuSgkjWyG19XgpHclxYtnQu19PmDKuRDKS9mXChBReAn5Zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030943; c=relaxed/simple;
	bh=0pHFPjqwX9Hs6H1aBw3JTXm0xzuiHKsgVsjGqvBYpKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co+vw7Ty/AAxgEdp565Hy+XZRMphibgZN1wuCZKbvDFJceKv6wSyOn1n7IQUQ3K2hmaFW3g32zDLCqt2JZJcNEJEi3iS98qlZnExNTwLwRk2wTwcJl36GKmKVDDtLxSQQB8I0fI0V8iPPEg/B441S5kkATKkyzvNinM+lsX/kzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=WI4dbGjG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="WI4dbGjG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso13098955e9.3
        for <linux-serial@vger.kernel.org>; Thu, 06 Aug 2026 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1786030940; x=1786635740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4GZuBKa5ESBM1sRTvDk7zO5q8SVteXo+V4m4gZSpseg=;
        b=WI4dbGjGUgneddVjtjAPJMfAa7rOplLNCKveU1PUN9bgPYU+zj6huGdm+kj1CSqWoS
         F3XcwRy4o3JxhE2y+xhkxEH0EaA6o20RvBC1qRmiXK12XM4GqhC2m2xv+g2YQUebX3dy
         1B3vAvWTEc1OPvwp+mRsiFOlbjI86e4TI7e3GHqF0NqZeoGwvsdbVjzJAHX7ofB804Vg
         fgj5AUpCb8n4NluqJuH+h16N7uWQVsE1rksteDZR1WFPXakTWK17qLw7SkEEJSzRTSmk
         TIt5STZjwo5tGjwH4FXymALOL7kKszFZr6J8r3CkBJzyqblV0QyrNmjLEgemFGIxn2lm
         45yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030940; x=1786635740;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GZuBKa5ESBM1sRTvDk7zO5q8SVteXo+V4m4gZSpseg=;
        b=XhK7LBh+QeQNweI8OSz9QFa/+L24MSQgRrx6BjGDSxmrl6BaPZ4HqNGsqBOSjN7cx3
         Dg+42Dg5fvsSuaBl7WytO4KfvYuXSfdsoVif+wx1QAF/QrS6f2gTLqdW0NdUbXl6NTh0
         FkAQbM0FfvcnEl0t4Q7EIdf/eE4xc25Ll+UnBFQ9rFif6VR2sLAW1Jic2m33q/cn8ciH
         +d6mGeSbq7nDIo9lmCtSla+35pYPLMjei2+W+KIqibhbATh3QkzLrGw9x/L3q8lLzIxG
         ExI+KNrKGa3RaGExEfzOgjtWq2TmSiE/M/80slPFrF/vJZcfj8N+L1osrJhKe20sr1tA
         ES2g==
X-Forwarded-Encrypted: i=1; AHgh+Rr9rwsCeHn3Hi0hcpB/+90J7MV3TJfShfbgbzGc7lAp/pA5S8syNhPH/brOz6yK0ecUDenlZJCuBWS2sG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGBiwWVVlRCQO//Uea9AvCP9IHZDrfyUrbnm9A96vSRUoO/l9
	k/+U8mS/55W/tLlVOdIvC8f/VbdOd1Ey0cpMQ5bNAtuVCXSAHuhNeWM5dcO3MQHj94o=
X-Gm-Gg: AR+sD11FNPLzHXjuMVMSRHQYTrCzRwxmK1yZ7fZSnp+uR6Esf4CExejyrBP1jWJ21A1
	dXolHpZ/yITuVLRDAdihMJZGxKsNBCctV+UNhVmAkLlPVJdy7PWiHCmQJYAFdymGsSyBUjywaeb
	eJvVDRGIVj6ayt6cvIGDG5dfS3lxQJzpTFedMarc4QqrxipPNvYN9mqPvKrx4DX+/mtyXJd8oYb
	SCs79DOsqcusk5aiirrCGugAQm8AXVJQu79vcMWpsxzWDUql+pcqPoaN1rgJBrhSO7uHeYJT6jH
	kkRpmc4/g5lj8SWUj/PVnc1kDAX1fwBMQ61ZPnvyy4nDurAFr+DVZAwv0EL/4lxPq0FASG+e9EI
	j3YtkL0R2FQPts2+Vr498sFOUv7ThAlh/auL+R6shVMHTp9PRmIw+BWOA58paau33uGJE2PD7PI
	JB5DD3whi0Sn6N/zWgzUN/GlfemQTH+1jPIFDR/0Ld1kR5BBd0l2TmcUtBxmo5JVb6xKwdCX0y7
	60EMUbsjNNEt64elmMXbYuJg5qA61xpBjqWtNKYRzCB0SOoDkgfbAh3xpSAV/1REZX0xoUqy4Pi
	bfOclDxmiEqUtYaqIpcKb7rN
X-Received: by 2002:a05:600c:c043:b0:495:7a5a:d96c with SMTP id 5b1f17b1804b1-4994e7d89cfmr172359555e9.18.1786030939373;
        Thu, 06 Aug 2026 08:42:19 -0700 (PDT)
Received: from krabice.lan (ip-89-103-66-201.bb.vodafone.cz. [89.103.66.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b25c01sm6605380f8f.29.2026.08.06.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:42:18 -0700 (PDT)
From: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com
Cc: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>,
	phil@raspberrypi.com,
	stefan@agner.ch,
	bcm-kernel-feedback-list@broadcom.com,
	linux-serial@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] serial: 8250_bcm2835aux: Add support for RTS/CTS auto flow control
Date: Thu,  6 Aug 2026 17:42:04 +0200
Message-ID: <7e5ed3fb37ee4e113706c258d792121b868861a9.1786030659.git.sairon@sairon.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786030659.git.sairon@sairon.cz>
References: <cover.1786030659.git.sairon@sairon.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The bcm2835aux mini UART can automatically de-assert RTS based on the RX
FIFO fill level and gate the transmitter on CTS, but the driver never
made use of it. Wire it up:

- Enable AUTORTS/AUTOCTS (with the RTS4 threshold and inverted, i.e.
  conventional active-low, polarity) whenever CRTSCTS is set on ports
  declaring the "uart-has-rtscts" property, advertised via
  UPF_HARD_FLOW.

- Gate the AUTORTS function on TIOCM_RTS in set_mctrl() so that
  clearing RTS (port close, TIOCMBIC, B0) actually de-asserts the pin
  while auto flow control is active.

- Implement throttle()/unthrottle() by disabling the RX interrupts and
  letting the FIFO fill up, making the hardware de-assert RTS - the
  same approach as in 8250_omap. Re-sync this state on termios and
  rs485 changes, as those paths may re-enable the RX interrupts (or
  leave them disabled) behind the throttle's back.

- Never enable auto flow control together with rs485, which uses RTS
  as the transceiver direction control. As the software CTS fallback
  of the serial core cannot work without a modem status interrupt,
  strip CRTSCTS whenever it cannot be handled in hardware.

- Restore RXEN when rs485 is disabled, as the emulation may be torn
  down without the rs485_stop_tx() callback ever being called, which
  would leave the receiver disabled.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jan Čermák <sairon@sairon.cz>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 160 +++++++++++++++++++++-
 1 file changed, 156 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 0609582a62f7..cf9cf08ddb17 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -7,9 +7,9 @@
  * Based on 8250_lpc18xx.c:
  * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
  *
- * The bcm2835aux is capable of RTS auto flow-control, but this driver doesn't
- * take advantage of it yet.  When adding support, be sure not to enable it
- * simultaneously to rs485.
+ * The bcm2835aux's RTS/CTS auto flow-control is enabled for ports declaring
+ * the "uart-has-rtscts" property, but never simultaneously to rs485, which
+ * repurposes RTS as the transceiver direction control.
  */
 
 #include <linux/clk.h>
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/tty.h>
 
 #include "8250.h"
 
@@ -34,6 +35,18 @@
 #define BCM2835_AUX_UART_CNTL_RTSINV	0x40 /* Invert auto RTS polarity */
 #define BCM2835_AUX_UART_CNTL_CTSINV	0x80 /* Invert auto CTS polarity */
 
+/*
+ * Set auto RTS to de-assert with 4 FIFO slots left (RTS4).
+ *
+ * The RTSINV/CTSINV bits select the auto flow assert level, which out of
+ * reset is active-high. Set them to get the conventional active-low RTS/CTS.
+ */
+#define BCM2835_AUX_UART_CNTL_AUTORTS_MASK \
+	(BCM2835_AUX_UART_CNTL_AUTORTS | BCM2835_AUX_UART_CNTL_RTS4 | \
+	 BCM2835_AUX_UART_CNTL_RTSINV)
+#define BCM2835_AUX_UART_CNTL_AUTOCTS_MASK \
+	(BCM2835_AUX_UART_CNTL_AUTOCTS | BCM2835_AUX_UART_CNTL_CTSINV)
+
 /**
  * struct bcm2835aux_data - driver private data of BCM2835 auxiliary UART
  * @clk: clock producer of the port's uartclk
@@ -46,6 +59,139 @@ struct bcm2835aux_data {
 	u32 cntl;
 };
 
+static bool bcm2835aux_tty_throttled(struct uart_port *port)
+{
+	struct tty_struct *tty = port->state ? port->state->port.tty : NULL;
+
+	return tty && tty_throttled(tty);
+}
+
+/* Program the CNTL auto flow bits from port->status and mctrl */
+static void bcm2835aux_update_flow(struct uart_port *port, unsigned int mctrl)
+{
+	struct bcm2835aux_data *data = dev_get_drvdata(port->dev);
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	data->cntl &= ~(BCM2835_AUX_UART_CNTL_AUTORTS_MASK |
+			BCM2835_AUX_UART_CNTL_AUTOCTS_MASK);
+	if ((port->status & UPSTAT_AUTORTS) && (mctrl & TIOCM_RTS))
+		data->cntl |= BCM2835_AUX_UART_CNTL_AUTORTS_MASK;
+	if (port->status & UPSTAT_AUTOCTS)
+		data->cntl |= BCM2835_AUX_UART_CNTL_AUTOCTS_MASK;
+
+	serial_out(up, BCM2835_AUX_UART_CNTL, data->cntl);
+}
+
+static void bcm2835aux_enable_rx_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	serial_out(up, UART_IER, up->ier);
+}
+
+static void bcm2835aux_set_autoflow(struct uart_port *port, tcflag_t cflag,
+				    bool rs485_enabled)
+{
+	bool was_enabled = port->status & UPSTAT_AUTORTS;
+	bool enable;
+
+	/*
+	 * rs485 uses RTS as the transceiver direction control, which is
+	 * mutually exclusive with the auto flow-control of the pin.
+	 */
+	enable = (cflag & CRTSCTS) && (port->flags & UPF_HARD_FLOW) &&
+		 !rs485_enabled;
+
+	if (enable) {
+		port->status |= UPSTAT_AUTORTS | UPSTAT_AUTOCTS;
+		/* Restore the throttle state lost in startup/resume/rs485 paths */
+		if (bcm2835aux_tty_throttled(port)) {
+			/* let the FIFO fill up and de-assert RTS in hardware */
+			port->ops->stop_rx(port);
+			/* reclaim an RTS lowered by software flow control */
+			if ((cflag & CBAUD) != B0)
+				port->mctrl |= TIOCM_RTS;
+		}
+	} else {
+		port->status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+		/* unthrottle() will no longer be called after leaving auto-RTS mode */
+		if (was_enabled)
+			bcm2835aux_enable_rx_irq(port);
+	}
+
+	bcm2835aux_update_flow(port, port->mctrl);
+}
+
+static void bcm2835aux_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	serial8250_do_set_mctrl(port, mctrl);
+	bcm2835aux_update_flow(port, mctrl);
+}
+
+static void bcm2835aux_set_termios(struct uart_port *port,
+				   struct ktermios *termios,
+				   const struct ktermios *old)
+{
+	/*
+	 * Strip CRTSCTS when the hardware auto flow-control cannot be
+	 * used, as the serial core's software CTS fallback cannot work
+	 * without a modem status interrupt.
+	 */
+	if (!(port->flags & UPF_HARD_FLOW) ||
+	    (port->rs485.flags & SER_RS485_ENABLED))
+		termios->c_cflag &= ~CRTSCTS;
+
+	serial8250_do_set_termios(port, termios, old);
+
+	guard(uart_port_lock_irqsave)(port);
+
+	bcm2835aux_set_autoflow(port, termios->c_cflag,
+				port->rs485.flags & SER_RS485_ENABLED);
+}
+
+static void bcm2835aux_throttle(struct uart_port *port)
+{
+	guard(uart_port_lock_irqsave)(port);
+
+	port->ops->stop_rx(port);
+}
+
+static void bcm2835aux_unthrottle(struct uart_port *port)
+{
+	guard(uart_port_lock_irqsave)(port);
+
+	bcm2835aux_enable_rx_irq(port);
+}
+
+static int bcm2835aux_rs485_config(struct uart_port *port,
+				   struct ktermios *termios,
+				   struct serial_rs485 *rs485)
+{
+	tcflag_t cflag = termios ? termios->c_cflag : 0;
+	bool rs485_enabled;
+	int ret;
+
+	ret = serial8250_em485_config(port, termios, rs485);
+	if (ret)
+		return ret;
+
+	rs485_enabled = rs485->flags & SER_RS485_ENABLED;
+	if (!rs485_enabled) {
+		struct bcm2835aux_data *data = dev_get_drvdata(port->dev);
+
+		data->cntl |= BCM2835_AUX_UART_CNTL_RXEN;
+	}
+
+	/*
+	 * termios is NULL when rs485 is set up from firmware properties at
+	 * port registration, before the port has been opened.
+	 */
+	bcm2835aux_set_autoflow(port, cflag, rs485_enabled);
+
+	return 0;
+}
+
 static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up, bool toggle_ier)
 {
 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
@@ -99,7 +245,11 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	up.port.dev = &pdev->dev;
 	up.port.type = PORT_16550;
 	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST | UPF_IOREMAP;
-	up.port.rs485_config = serial8250_em485_config;
+	up.port.set_termios = bcm2835aux_set_termios;
+	up.port.set_mctrl = bcm2835aux_set_mctrl;
+	up.port.throttle = bcm2835aux_throttle;
+	up.port.unthrottle = bcm2835aux_unthrottle;
+	up.port.rs485_config = bcm2835aux_rs485_config;
 	up.port.rs485_supported = serial8250_em485_supported;
 	up.rs485_start_tx = bcm2835aux_rs485_start_tx;
 	up.rs485_stop_tx = bcm2835aux_rs485_stop_tx;
@@ -134,6 +284,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	ret = uart_read_port_properties(&up.port);
 	if (ret)
 		goto rm_swnode;
+	if (device_property_read_bool(&pdev->dev, "uart-has-rtscts"))
+		up.port.flags |= UPF_HARD_FLOW;
 
 	up.port.regshift = 2;
 	up.port.fifosize = 8;
-- 
2.55.0

