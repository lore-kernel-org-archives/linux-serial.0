Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B22EB11
	for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538646; cv=none; b=FsVxN8jIpapCuBk41ttqFxcjBMF6CGDorBBqSoS5u7N2NOmt86Abiwiqv81eDK5VMQuUybuujA1pTGZuFFCyS13Chd4IwqZJzJwTKjTqsH1Q2FE1KMnO7Nmb1rDYZq5Rdxo0jo+V0KsZX1bYghdhDJbTwvzaGCb03toccpmYpRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538646; c=relaxed/simple;
	bh=NJXio4QauoFkz2xa5jL1qxd0jPxxaL5PMYTl9r8XtoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=juoYl1Noy/k23FwzmzZ5VFUqW08EyBFxfe/5ize+XVn74phq32MMg4Uh0bI+w7C1fmemrAQ+ByTWewbYl/8FMdMoiUPI3xm9q1z10kKG0JY3Kg2Q1Iu14gKuATx4FTRuUf/IQ2bNvumt/4+lxc/zOwvcl8ZDiax+ctGKQlcMPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astranis.com; spf=pass smtp.mailfrom=astranis.com; dkim=pass (2048-bit key) header.d=astranis.com header.i=@astranis.com header.b=QGTvmL6k; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astranis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astranis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astranis.com header.i=@astranis.com header.b="QGTvmL6k"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74267c68c11so4042228b3a.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=astranis.com; s=google; t=1749538644; x=1750143444; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X3qMGFLHagyS9aANbZdxYcY5chH/c0eXebcd3qCsKuo=;
        b=QGTvmL6kRbk1fipiZ2PitEW32ebTYjCK30VW8YypZC/qxlai+rPaMtxrsThf5KKFec
         3QDE5wSDSm+gvc+ZZBAGrSCyGe2Iku2Z2LoAJT5hKA0/fEmY5lC5Ex52ZsxlMwXUWWRA
         A25I/ljsQ5dChihb9TqYuCxLZSXlOP7pyhcncH15FmCl0g4OacJ3zad+d4ruo0M+1uzO
         0WrwnzvylLMB6vHH1jIXzePCdeMo6yZVH8uUiLmAoO78A2Z0XGT+NPafP0rCu0MH+PfW
         W2fACXQXpFZgPQM+BG0dam13i9rusNv8ZdQIo9yQWe1QoTT7+nD9FCWpvNCoLMU0oRMc
         l//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749538644; x=1750143444;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3qMGFLHagyS9aANbZdxYcY5chH/c0eXebcd3qCsKuo=;
        b=pVQb709joNt4gYhK2cmDHQlSXdz2srOkBm1P6aQsOPCqs3eIcL7xi2HMMOI4QVdEOO
         yvAielax+Fa0dO4Nrv1ZFcFaNE2ZnysoIwn/Pu/b6bUvyDOT9wh/YknBQ7NgiQGiKn6g
         NS+LwocsZ6qtwUYm0z6/bdgKFB1qvcB5faKjKDl37wSvrkpaTog20wOSea5WgUaVvHBY
         fDqUGc8lWd7PHUvqn2422qe2PlaBrdTnna+LBzqhgQA1FGzKCZX6R2ijBZ4USWse0HtH
         yhFuU3W2bOgcYrypX/1hhZjm4IgP5uZV71jSnmMs50c9ibbhqOWve06GUCtmqfhThS1B
         5U1w==
X-Forwarded-Encrypted: i=1; AJvYcCUr/KCOWd/HPu7Lynaigxcjod8mFwGu4mrNIuMQxImA8nzgDcBXeJaNLY7a73L3VI0LYYYbG+cZYBSV1aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJNSYEUKEJakxT0R814NufsrDOQukJNa3tCObHtUX9bfcE/vx
	CW93S8BYIxDGNvxWfognhXVlz1bH+qs6UtQdM1FGnhh02dsdqNNGjyqPrjB/1xW8SJl0bfvA1oX
	Qw7DC7kammiChHFMQ+/Gt7T0yV8bBpDa2G9GEpsRZWUWhg2LNGL4RKf2zQ5c=
X-Gm-Gg: ASbGnct0MHK1a7/yhEiHP1ify5jgpN4zqVsLFAZQKZ+vbhpBAxOm6vLT6fo+SWG4TZX
	bLyObc4U398Nt3qBbvMx+9quXaOdOu+NiEwobXzZsWwwQ69DRrlBXWjq/QL27KxXX6oP6fEzGI8
	RBsv0Omdj+Fw8plCpKrf0qthaykXs0wIkLPoG6yC7Saq2I2JEfm9hbiP4Z7k9NCuPp7KRGqRmnV
	xCQFy44PRTASsKXAguarR6b4dC+FKUQ7+pGlf8cl2BawfBea0dXz17oo7nxQFtuyUE6EQtCoPgP
	C57gOPAmCPBErRht5I4zJu8Wpd/7B/WO5y++dMG6v6bSNDAdkWzXTXAweB2b/ej/7uJvYRcVGUm
	0ezYi5zTlUDqe5Q==
X-Google-Smtp-Source: AGHT+IE/uFJARzySw8XTfJfoIXM9eq4DQp45vCYluSX1sb3ToIeAmeTH+ImqVWaqCAKDqCK9US52jg==
X-Received: by 2002:a05:6a00:17a3:b0:748:33f3:8da3 with SMTP id d2e1a72fcca58-74833f38eaamr18567434b3a.19.1749538644251;
        Mon, 09 Jun 2025 23:57:24 -0700 (PDT)
Received: from 6GLGQW3.attlocal.net ([2600:1700:43b0:1fc0:f9fc:b80b:6b8:4edf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0ea2b2sm6768024b3a.161.2025.06.09.23.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 23:57:23 -0700 (PDT)
From: jtilahun@astranis.com
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Joseph Tilahun <jtilahun@astranis.com>
Subject: [PATCH] tty: serial: fix print format specifiers
Date: Mon,  9 Jun 2025 23:56:53 -0700
Message-Id: <20250610065653.3750067-1-jtilahun@astranis.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

From: Joseph Tilahun <jtilahun@astranis.com>

The serial info sometimes produces negative TX/RX counts. E.g.:

3: uart:FSL_LPUART mmio:0x02970000 irq:46 tx:-1595870545 rx:339619
RTS|CTS|DTR|DSR|CD

It appears that the print format specifiers don't match with the types of
the respective variables. E.g.: All of the fields in struct uart_icount
are u32, but the format specifier used is %d, even though u32 is unsigned
and %d is for signed integers. Update drivers/tty/serial/serial_core.c
to use the proper format specifiers. Reference
https://docs.kernel.org/core-api/printk-formats.html as the documentation
for what format specifiers are the proper ones to use for a given C type.

Signed-off-by: Joseph Tilahun <jtilahun@astranis.com>
---
 drivers/tty/serial/serial_core.c | 44 ++++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1f7708a91fc6..8a1482131257 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1337,28 +1337,28 @@ static void uart_sanitize_serial_rs485_delays(struct uart_port *port,
 	if (!port->rs485_supported.delay_rts_before_send) {
 		if (rs485->delay_rts_before_send) {
 			dev_warn_ratelimited(port->dev,
-				"%s (%d): RTS delay before sending not supported\n",
+				"%s (%u): RTS delay before sending not supported\n",
 				port->name, port->line);
 		}
 		rs485->delay_rts_before_send = 0;
 	} else if (rs485->delay_rts_before_send > RS485_MAX_RTS_DELAY) {
 		rs485->delay_rts_before_send = RS485_MAX_RTS_DELAY;
 		dev_warn_ratelimited(port->dev,
-			"%s (%d): RTS delay before sending clamped to %u ms\n",
+			"%s (%u): RTS delay before sending clamped to %u ms\n",
 			port->name, port->line, rs485->delay_rts_before_send);
 	}
 
 	if (!port->rs485_supported.delay_rts_after_send) {
 		if (rs485->delay_rts_after_send) {
 			dev_warn_ratelimited(port->dev,
-				"%s (%d): RTS delay after sending not supported\n",
+				"%s (%u): RTS delay after sending not supported\n",
 				port->name, port->line);
 		}
 		rs485->delay_rts_after_send = 0;
 	} else if (rs485->delay_rts_after_send > RS485_MAX_RTS_DELAY) {
 		rs485->delay_rts_after_send = RS485_MAX_RTS_DELAY;
 		dev_warn_ratelimited(port->dev,
-			"%s (%d): RTS delay after sending clamped to %u ms\n",
+			"%s (%u): RTS delay after sending clamped to %u ms\n",
 			port->name, port->line, rs485->delay_rts_after_send);
 	}
 }
@@ -1388,14 +1388,14 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 			rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
 
 			dev_warn_ratelimited(port->dev,
-				"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
+				"%s (%u): invalid RTS setting, using RTS_ON_SEND instead\n",
 				port->name, port->line);
 		} else {
 			rs485->flags |= SER_RS485_RTS_AFTER_SEND;
 			rs485->flags &= ~SER_RS485_RTS_ON_SEND;
 
 			dev_warn_ratelimited(port->dev,
-				"%s (%d): invalid RTS setting, using RTS_AFTER_SEND instead\n",
+				"%s (%u): invalid RTS setting, using RTS_AFTER_SEND instead\n",
 				port->name, port->line);
 		}
 	}
@@ -1834,7 +1834,7 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 
 	expire = jiffies + timeout;
 
-	pr_debug("uart_wait_until_sent(%d), jiffies=%lu, expire=%lu...\n",
+	pr_debug("uart_wait_until_sent(%u), jiffies=%lu, expire=%lu...\n",
 		port->line, jiffies, expire);
 
 	/*
@@ -2028,7 +2028,7 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
 		return;
 
 	mmio = uport->iotype >= UPIO_MEM;
-	seq_printf(m, "%d: uart:%s %s%08llX irq:%d",
+	seq_printf(m, "%u: uart:%s %s%08llX irq:%u",
 			uport->line, uart_type(uport),
 			mmio ? "mmio:0x" : "port:",
 			mmio ? (unsigned long long)uport->mapbase
@@ -2050,18 +2050,18 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
 		if (pm_state != UART_PM_STATE_ON)
 			uart_change_pm(state, pm_state);
 
-		seq_printf(m, " tx:%d rx:%d",
+		seq_printf(m, " tx:%u rx:%u",
 				uport->icount.tx, uport->icount.rx);
 		if (uport->icount.frame)
-			seq_printf(m, " fe:%d",	uport->icount.frame);
+			seq_printf(m, " fe:%u",	uport->icount.frame);
 		if (uport->icount.parity)
-			seq_printf(m, " pe:%d",	uport->icount.parity);
+			seq_printf(m, " pe:%u",	uport->icount.parity);
 		if (uport->icount.brk)
-			seq_printf(m, " brk:%d", uport->icount.brk);
+			seq_printf(m, " brk:%u", uport->icount.brk);
 		if (uport->icount.overrun)
-			seq_printf(m, " oe:%d", uport->icount.overrun);
+			seq_printf(m, " oe:%u", uport->icount.overrun);
 		if (uport->icount.buf_overrun)
-			seq_printf(m, " bo:%d", uport->icount.buf_overrun);
+			seq_printf(m, " bo:%u", uport->icount.buf_overrun);
 
 #define INFOBIT(bit, str) \
 	if (uport->mctrl & (bit)) \
@@ -2553,7 +2553,7 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 		break;
 	}
 
-	pr_info("%s%s%s at %s (irq = %d, base_baud = %d) is a %s\n",
+	pr_info("%s%s%s at %s (irq = %u, base_baud = %u) is a %s\n",
 	       port->dev ? dev_name(port->dev) : "",
 	       port->dev ? ": " : "",
 	       port->name,
@@ -2561,7 +2561,7 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 
 	/* The magic multiplier feature is a bit obscure, so report it too.  */
 	if (port->flags & UPF_MAGIC_MULTIPLIER)
-		pr_info("%s%s%s extra baud rates supported: %d, %d",
+		pr_info("%s%s%s extra baud rates supported: %u, %u",
 			port->dev ? dev_name(port->dev) : "",
 			port->dev ? ": " : "",
 			port->name,
@@ -2960,7 +2960,7 @@ static ssize_t close_delay_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.close_delay);
+	return sprintf(buf, "%u\n", tmp.close_delay);
 }
 
 static ssize_t closing_wait_show(struct device *dev,
@@ -2970,7 +2970,7 @@ static ssize_t closing_wait_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.closing_wait);
+	return sprintf(buf, "%u\n", tmp.closing_wait);
 }
 
 static ssize_t custom_divisor_show(struct device *dev,
@@ -2990,7 +2990,7 @@ static ssize_t io_type_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.io_type);
+	return sprintf(buf, "%u\n", tmp.io_type);
 }
 
 static ssize_t iomem_base_show(struct device *dev,
@@ -3010,7 +3010,7 @@ static ssize_t iomem_reg_shift_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.iomem_reg_shift);
+	return sprintf(buf, "%u\n", tmp.iomem_reg_shift);
 }
 
 static ssize_t console_show(struct device *dev,
@@ -3146,7 +3146,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	state->pm_state = UART_PM_STATE_UNDEFINED;
 	uart_port_set_cons(uport, drv->cons);
 	uport->minor = drv->tty_driver->minor_start + uport->line;
-	uport->name = kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
+	uport->name = kasprintf(GFP_KERNEL, "%s%u", drv->dev_name,
 				drv->tty_driver->name_base + uport->line);
 	if (!uport->name)
 		return -ENOMEM;
@@ -3185,7 +3185,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 		device_set_wakeup_capable(tty_dev, 1);
 	} else {
 		uport->flags |= UPF_DEAD;
-		dev_err(uport->dev, "Cannot register tty device on line %d\n",
+		dev_err(uport->dev, "Cannot register tty device on line %u\n",
 		       uport->line);
 	}
 
-- 
2.34.1


-- 


________
This email and any attachments may contain Astranis confidential 
and/or proprietary information governed by a non-disclosure agreement, and 
are intended solely for the individual or entity specified by the message.
