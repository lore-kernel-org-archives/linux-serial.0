Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0E281365
	for <linux-serial@vger.kernel.org>; Mon,  9 Jun 2025 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455058; cv=none; b=HMJ2d1ANZl3zCWJzCtnRVYzJJ6E5X5CkjXwD2tohwalD1924/78LU+CZCa9Vm38LLFbnVp0RNBE0jqPEfCjMH1TBbNcEekEasKC6QLnhHsYOH47bN8fG0EfEGC8eNzwnwuzxk3XUrJk1P+8cdh8wrMutytdrx249Ge0XKhZGW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455058; c=relaxed/simple;
	bh=qGjOULSQfrhZNYJbcbq9J/bx7G4cga14Ksr4xHqMKco=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/cOXO0UJQUvAIAisUKb5KDFZhru0VtxTW9rvTMh15r+G7kI5Z6duLXo8lRygHNXK6Hh5jJgnJ3ItN1Hq7Oli38TX0lHC5HsxLxI3iMooQOv7360SFj8iLv0V5PHAtTzHzNw7+n1JL181igb8fdaPE5wjTiElBmintDuSLBixT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bK/ExMvO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bK/ExMvO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2350b1b9129so24874915ad.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749455054; x=1750059854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MgSetHRD9od3OJ7iz2rDkPKMWGhLjKM4sQsvvkn2HM=;
        b=bK/ExMvOYEHrzxPVkf7YubFWv90BGP5KCfyqE0uIsWuBIBHYHoMr6JYcJYRpTcX/33
         jFtp6eiFQKWizVGYr0wmcfyzXYw9JLB2RKZnsDKIAauDjlJI2yidl5xTxD/4lnmYFsAc
         /ppUCLLl8PVdu3AUOFLkNDeX5cDCI1By2CzAXzZ/h+JFb8O6EhlXyG+q2pa3UhTf+ToZ
         lICK1volWOxsm1rR8aLYGZWeHWZcN1h/POo5BbkXkDz3J6qCIIexgLngATA0wQsYX9dV
         uBk7Z6yDKcQO+mJEA8ulXjsQ0ebHVaONDvOzTqT1RDd7n5JaiNxxTPT+ooO8ZJJWj23r
         QmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749455054; x=1750059854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MgSetHRD9od3OJ7iz2rDkPKMWGhLjKM4sQsvvkn2HM=;
        b=RxK+5ATZlaUfno9txfSXaTJLx1Cp9qRFx+cfl0pkeShJSEG60WN0qY5rwRV0xdBCjJ
         JYhExdDtlBThQAM4/QyjW3OEzO1dxpPdhTMXfS18Pby+1AL5KCQW16k/LtYaXQeMVV6w
         6LRn6XzvwJB0J/ASWA14zDudqsCF8Vw2qHVNBoyiLt2E8l5mPPTTPPGDiJD1Re21NGub
         b5FnH4vVlIhaz3tGfxlrqZfQQOEnAVIjENEeh8gqCWh8ztRqJYEMMc01HaoLy7oNTj8r
         jbSFn5e3jHteCkyZa+/2hDhxWs9jMQzM38xKuba6B9b+Ay9u6EwjNYnDZlqcKx+iANiE
         aCRw==
X-Forwarded-Encrypted: i=1; AJvYcCVkQPKB1WdXMHiRBr66y/a2aHEgP58+2E2HoLqF6ICPB9AqrDhKA1szvpqneWK0KMtdEaQtueenQSFvsdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy684pY3frXQ8aBHetNrgMRK5D69wiGiVqdr/62W2/Bqwo5sLT9
	NDJH12efUiy+0QZM+lC/fzsNtJhUNUq6euD9bV/fgVhjp6y03hQuklwlgAhNBNrZwfA=
X-Gm-Gg: ASbGncvhaFuEiIlPXhA4NdOyHW6hJoj+A4TSBYdue8Q5AxwjfNXCPhle1DK5pI5TRa9
	tiYCunn1TSxkD9FyYumUgRsB+uaA/Uu/SfTcxH1Y+DePnIBYRrc/EPvdSXmnYpDS/KhwZDFuJVd
	9LPMTAl5e30E4oArHDS1nrgAY9FsqwfVpYzmK4smeH1E4GIztvuQR/t8vugVtLWnEcT2oU7Xctz
	+oG/1pjaVVfvx+6izR7B9dDVy4gxdoC7PQj0wnB5V/SPrmLMZxlSX8toPpH4MllgjDEQtjzcdoE
	qU5A2ZJViulFjy4KsWXai/LpJwaJeGpk+OxIk2qZtn3zK1YWFp1FsI31cjDmNw5ppx8tehYdiH8
	5gNrhK+ivxjjEIHU57AdbMLDVUxk4V9LiInx762ao2Snxxksc2EDM
X-Google-Smtp-Source: AGHT+IGF35bl6kHfVcpqficVcBv0i2lmdc98JjLaSkjXXef5nwbwLjsouU+PXGgR5AeX/b1tmHYsMw==
X-Received: by 2002:a17:902:db07:b0:234:a139:1203 with SMTP id d9443c01a7336-23601d82d1bmr193428465ad.32.1749455054477;
        Mon, 09 Jun 2025 00:44:14 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm48573715ad.72.2025.06.09.00.44.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Jun 2025 00:44:13 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: arnd@arndb.de,
	andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu,
	cuiyunhui@bytedance.com,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	jkeeping@inmusicbrands.com,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	markus.mayer@linaro.org,
	matt.porter@linaro.org,
	namcao@linutronix.de,
	paulmck@kernel.org,
	pmladek@suse.com,
	schnelle@linux.ibm.com,
	sunilvl@ventanamicro.com,
	tim.kryger@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH v8 2/4] serial: 8250: avoid potential PSLVERR issue
Date: Mon,  9 Jun 2025 15:43:46 +0800
Message-Id: <20250609074348.54899-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250609074348.54899-1-cuiyunhui@bytedance.com>
References: <20250609074348.54899-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PSLVERR_RESP_EN parameter is set to 1, reading UART_RX while
the FIFO is enabled and UART_LSR_DR is not set will generate a PSLVERR
error.

Failure to check the UART_LSR_DR before reading UART_RX, or the non-
atomic nature of clearing the FIFO and reading UART_RX, poses
potential risks that could lead to PSLVERR.

PSLVERR is addressed through two methods. One is to introduce
serial8250_discard_data() to check whether UART_LSR_DR is set before
reading UART_RX, thus solving the PSLVERR issue when the FIFO is
enabled. The other is to place FIFO clearing and reading of UART_RX
under port->lock.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250.h      | 13 +++++++++++++
 drivers/tty/serial/8250/8250_port.c | 26 +++++++++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 18530c31a5981..b3fb8a550db35 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -162,6 +162,19 @@ static inline u16 serial_lsr_in(struct uart_8250_port *up)
 	return lsr;
 }
 
+/*
+ * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
+ * reading UART_RX.
+ */
+static inline void serial8250_discard_data(struct uart_8250_port *up)
+{
+	u16 lsr;
+
+	lsr = serial_in(up, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		serial_in(up, UART_RX);
+}
+
 /*
  * For the 16C950
  */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 07fe818dffa34..0560df9b064f9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -764,8 +764,6 @@ static void disable_rsa(struct uart_8250_port *up)
 
 	if (up->port.type == PORT_RSA &&
 	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
-		uart_port_lock_irq(&up->port);
-
 		mode = serial_in(up, UART_RSA_MSR);
 		result = !(mode & UART_RSA_MSR_FIFO);
 
@@ -777,7 +775,6 @@ static void disable_rsa(struct uart_8250_port *up)
 
 		if (result)
 			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-		uart_port_unlock_irq(&up->port);
 	}
 }
 #endif /* CONFIG_SERIAL_8250_RSA */
@@ -1353,9 +1350,8 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	/* Synchronize UART_IER access against the console. */
 	uart_port_lock_irq(port);
 	serial_out(up, UART_IER, UART_IER_ALL_INTR);
+	serial8250_discard_data(up);
 	uart_port_unlock_irq(port);
-	serial_in(up, UART_LSR);
-	serial_in(up, UART_RX);
 	serial_in(up, UART_IIR);
 	serial_in(up, UART_MSR);
 	serial_out(up, UART_TX, 0xFF);
@@ -2260,13 +2256,20 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
 	 */
+	uart_port_lock_irqsave(port, &flags);
 	serial8250_clear_fifos(up);
 
 	/*
-	 * Clear the interrupt registers.
+	 * Read UART_RX to clear interrupts (e.g., Character Timeout).
+	 * To prevent PSLVERR, we can either disable the FIFO before reading
+	 * UART_RX or read UART_RX only when UART_LSR_DR is set while the FIFO
+	 * remains enabled. If using the latter approach to avoid PSLVERR, it
+	 * creates a contradiction with the interrupt-clearing (see the
+	 * rx_timeout handling in dw8250_handle_irq()).
 	 */
 	serial_port_in(port, UART_LSR);
 	serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 
@@ -2423,15 +2426,13 @@ int serial8250_do_startup(struct uart_port *port)
 		}
 	}
 
-	uart_port_unlock_irqrestore(port, flags);
-
 	/*
 	 * Clear the interrupt registers again for luck, and clear the
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
+	serial8250_discard_data(up);
+	uart_port_unlock_irqrestore(port, flags);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 	up->lsr_saved_flags = 0;
@@ -2513,7 +2514,6 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2532,8 +2532,12 @@ void serial8250_do_shutdown(struct uart_port *port)
 	/*
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
+	 *
+	 * Since reading UART_RX clears interrupts, doing so with
+	 * FIFO disabled won't trigger PSLVERR.
 	 */
 	serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);
-- 
2.39.5

