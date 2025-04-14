Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEC2F32
	for <linux-serial@vger.kernel.org>; Mon, 14 Apr 2025 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600512; cv=none; b=ccLO/Lw+O/46W5xVyl6fqI2IH238f9AdGbqDKDB4mxJQV6WhuJPiImUZeDlA5DYi1sceCG6u6a7i7VciZJnPmo/CVWS6/g165+ux+XofXK9/ZnCM9H5HBUJw0sKUUHcRpXFSYiZttHHNS+OAFJUBP3aw7CjOOjbDyhNxk1TnTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600512; c=relaxed/simple;
	bh=wzRIJgLkF8VUETe1SqtyrBmiyQlvLZjQsQ+5bkHj4xk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nvucnnzbA9a63sEHpGtl/nZW2N3rTqwFAADNrTp4rTNcdc2yqwRiqRhpj8qo10/cxIN30P42BF7rHJMb1WPLb1ofuGr7dMZK8AKDUsS4Fh+q2mQisZ4tC57QZw6KBx+L/B6P/bpwgfpw6R5k/y1sZPZ5Q5PTiLtrJT0+yHnzom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RCycGpJB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RCycGpJB"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bb647eb23so3305812b3a.0
        for <linux-serial@vger.kernel.org>; Sun, 13 Apr 2025 20:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744600509; x=1745205309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=thHsBjdSUEPBqZYjj1q1ADPSVWz2MuGiCEWFo9naqu0=;
        b=RCycGpJBT/bjHawpA/eIJp8Nkz2XHtMpIsZpWDHGQIE41wTaodXHryw/EO8xA6tx0x
         zWYDhNsDIOv4hxc44HcSOoYSZGuQ25qZBd9/P9VEsLYV2qYm5EmZ6uOIPBOAQMGpMdmx
         Ybe6fkFurq4cnqcDRzG0XWohD9D06f/JlX6BKVInNyjMKVsnlSKUt561772aRrJtBlQ7
         MUMq4vM8IWjl4gKrs6uo6rZSmjr96qKd9i+Lw2uZKqIUFLcVMTfeL2U+horV3q+odWKm
         jmdRMoNZvPbZ197gKHAG1D7rhjMbGfFwy16sHEwzugn+DqhLtY4HnzJrLrtnNZFzO4yX
         2fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744600509; x=1745205309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thHsBjdSUEPBqZYjj1q1ADPSVWz2MuGiCEWFo9naqu0=;
        b=OKxo2oPmlMorgaGUQuTRQxthhIZTyVxusKQyG22uWWC0dJSi+h/45hs1EwyfJ9s5O6
         QSJ/ZHOUaCoMwqOI4lxecvbiRA+C94calTkfz1ZF1dDGChqVKhctsGxV4OgNpq6RpWdU
         7JCajRd73tEUzyXLhwRO0hVk2AyyGOLpu+319jJs3SzanlJ8/TgCjW0YBZgBrDGHZ24n
         lIPIquFzBuXp250wDU3JKNBFIpcmLZiqUgcxRaVXwH+yshwyNMToeZR2aYPl6g8YURX/
         oTNLYxTHq9Cqu6iBrLn23xu26zT/cpZzguVg7RQPAxqz30V1l1r1gXKtwCGhLdyj1ShW
         02zw==
X-Forwarded-Encrypted: i=1; AJvYcCX4HYV7+R6HBaS1u8927vQaAZ0hZqUdmg8dXXuiv8RTIH69+RtzEy2noVgz6WwagAYp8/EIFudBMyIyDG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPdDp/Bz4FnDzaF1XQ3jb9IFtb9907B9q1erC/+EA0OJCoaYD
	HG68RIPmPTb+p02YD+F0TF0Z7cpAaBJ9PpKbTamc3NMstKbVF+tIYciXt80DQo8=
X-Gm-Gg: ASbGncuqRgM0Wy3ELWKeV0ovD/JV2COVqttw1nhZk16Xz3a0G5yYnsiE97o1aZBWuxa
	joXP7EOKZz9dv48okgUSc/3bvOGV2RB0pxB49iGQCAMKNRtdOK6fo+0wAh7IITHejAFwLjABu5n
	Ss1+nDv5u7XZ1FJyU+WEbWt8EItzskCFhmTRcJly6mVF+SKAbSTgGnVeKcOkIh9x1Qd+qLClT0X
	3FOtfER3MTpvB6QK1dsSLLlGtgon+syYbgWCaNaHFwwcbF5B9PTQbC2fSbOlv97OmijjwpjGVUE
	Eu77TltvQHAvrHXJQWUxRsIbHz6XtTsJxwCSnVA+w99lZ0NUciECtn+PboP0XcMki1Bl43/Vhb0
	=
X-Google-Smtp-Source: AGHT+IG9RsUknfnPfzX6lufHAL3g3nxaG4w9MhD2xiFW2ObI7U3+UgIG3UDH/v0jd3xPq5DsQksqZw==
X-Received: by 2002:a05:6a00:39a0:b0:736:34ca:deee with SMTP id d2e1a72fcca58-73bd11cb079mr14576302b3a.7.1744600508507;
        Sun, 13 Apr 2025 20:15:08 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21df1a7sm5646781b3a.73.2025.04.13.20.15.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Apr 2025 20:15:08 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	pmladek@suse.com,
	arnd@arndb.de,
	namcao@linutronix.de,
	cuiyunhui@bytedance.com,
	benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com,
	heikki.krogerus@linux.intel.com,
	markus.mayer@linaro.org,
	tim.kryger@linaro.org,
	matt.porter@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3] serial: 8250: fix panic due to PSLVERR
Date: Mon, 14 Apr 2025 11:14:50 +0800
Message-Id: <20250414031450.42237-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PSLVERR_RESP_EN parameter is set to 1, the device generates
an error response if an attempt is made to read an empty RBR (Receive
Buffer Register) while the FIFO is enabled.

In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
Execution proceeds to the dont_test_tx_en label:
...
serial_port_in(port, UART_RX);
This satisfies the PSLVERR trigger condition.

Because another CPU(e.g., using printk()) is accessing the UART (UART
is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
(lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().

To fix this, all calls to serial_out(UART_LCR) and serial_in(UART_RX)
should be executed under port->lock. Additionally, checking the readiness
via UART_LSR should also be done under port->lock.

Panic backtrace:
[    0.442336] Oops - unknown exception [#1]
[    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
[    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
...
[    0.442416] console_on_rootfs+0x26/0x70

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250_dw.c   |  8 +++++
 drivers/tty/serial/8250/8250_port.c | 46 ++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index af24ec25d976..e97200ff30e3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -112,6 +113,13 @@ static void dw8250_force_idle(struct uart_port *p)
 	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned int lsr;
 
+	/*
+	 * Serial_in(p, UART_RX) should be under port->lock, but we can't add
+	 * it to avoid AA deadlock as we're unsure if serial_out*(...UART_LCR)
+	 * is under port->lock.
+	 */
+	lockdep_assert_held_once(&p->lock);
+
 	serial8250_clear_and_reinit_fifos(up);
 
 	/*
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3f256e96c722..21bbd18195f5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1328,6 +1328,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	unsigned int ICP = 0;
 	unsigned long irqs;
 	int irq;
+	u16 lsr;
 
 	if (port->flags & UPF_FOURPORT) {
 		ICP = (port->iobase & 0xfe0) | 0x1f;
@@ -1357,9 +1358,10 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	/* Synchronize UART_IER access against the console. */
 	uart_port_lock_irq(port);
 	serial_out(up, UART_IER, UART_IER_ALL_INTR);
+	lsr = serial_in(up, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		serial_port_in(port, UART_RX);
 	uart_port_unlock_irq(port);
-	serial_in(up, UART_LSR);
-	serial_in(up, UART_RX);
 	serial_in(up, UART_IIR);
 	serial_in(up, UART_MSR);
 	serial_out(up, UART_TX, 0xFF);
@@ -2137,19 +2139,16 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 static int serial8250_get_poll_char(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	int status;
+	int status = NO_POLL_CHAR;
 	u16 lsr;
 
 	serial8250_rpm_get(up);
 
+	uart_port_lock_irqsave(port, &flags);
 	lsr = serial_port_in(port, UART_LSR);
-
-	if (!(lsr & UART_LSR_DR)) {
-		status = NO_POLL_CHAR;
-		goto out;
-	}
-
-	status = serial_port_in(port, UART_RX);
+	if ((lsr & UART_LSR_DR))
+		status = serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 out:
 	serial8250_rpm_put(up);
 	return status;
@@ -2264,13 +2263,16 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
 	 */
+	uart_port_lock_irqsave(port, &flags);
 	serial8250_clear_fifos(up);
 
 	/*
 	 * Clear the interrupt registers.
 	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
+	lsr = serial_port_in(port, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 
@@ -2380,9 +2382,10 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
 	uart_port_lock_irqsave(port, &flags);
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
+
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
@@ -2428,15 +2431,16 @@ int serial8250_do_startup(struct uart_port *port)
 	}
 
 dont_test_tx_en:
-	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Clear the interrupt registers again for luck, and clear the
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
+	lsr = serial_port_in(port, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 	up->lsr_saved_flags = 0;
@@ -2492,6 +2496,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
+	u16 lsr;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2518,7 +2523,6 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2526,6 +2530,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 	serial_port_out(port, UART_LCR,
 			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
+	uart_port_unlock_irqrestore(port, flags);
 
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
@@ -2538,7 +2543,12 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
 	 */
-	serial_port_in(port, UART_RX);
+	uart_port_lock_irqsave(port, &flags);
+	lsr = serial_port_in(port, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
+
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);
-- 
2.39.2

