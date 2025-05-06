Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD83277817
	for <linux-serial@vger.kernel.org>; Tue,  6 May 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530619; cv=none; b=XqV5XcDXv1uI777d9LznFos2+L0OTgkV92lRwbof674KiniaiTF9naYDs6RlAKCP49UzdiukunZMc5NBvMgR4M9FK+U8o3bWbeM2gnQrmep4zKmWvnbFw9Q+8gDeGGejBaHPkA2fWULViAY62imn+7Bl6aWKWcZlrvq7tQhTRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530619; c=relaxed/simple;
	bh=H3l282jI5Layhto6Pmynhm3ddZElvS+Gd+StASMFlFc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nBHEA5thyUU8FRJlmlnLilKka1cY+1iXu9/JtVbODpTu45x9ioigmFG8BF4nlA94vqeJOJrhiZvd9xvNBYC4p336xNzkw1jIvDrJsEXSs6KuG67bSwRpGmW9fzV0sMztzhNgYfmEu7Yb4UPxF6njvHn3nSdktABlXcOK6Mwg5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ihvYTMsb; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ihvYTMsb"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-309f3bf23b8so7238356a91.3
        for <linux-serial@vger.kernel.org>; Tue, 06 May 2025 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746530617; x=1747135417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iSa5DYMN+92PEYo5yJGBYTHY1dFKEUc+Tn0/1DSVH4=;
        b=ihvYTMsbbGDAe1YiME3im0853yv4UUXCEtvl/G4FYtDpiW8Ys/nDhSkxOj8DEj7Iqf
         8lHJSr9PWCmQ3NarlKQS9rlgI5zlFY00d1KUwskX7vMiPxqBHBEu+wkbuQjNgCja4T2l
         k9FGvaGD5R1zge6XG/PMot2uR/9Gm7eSKJflk6lFZRLpyIV7L0iJhJ/2eeqzGVvuzR6W
         hswBVuiehvvMHRIxy2eetTjCpnQGrK921/xViSxW9B8XPHk3/4NMGbg0cw1S9SHlyKPW
         Tp4dqvA4HwfWt0/hIuMFQB/JcOas4C21Qx278uDCn6mLvOq22YOHJayz2Aq5SahQJEYr
         SvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746530617; x=1747135417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iSa5DYMN+92PEYo5yJGBYTHY1dFKEUc+Tn0/1DSVH4=;
        b=KNk9ny52jLWTsGMpQbOWhxcSsqon5DNP4GJuRsm9UUFvIWuHq3SO1ncClwDb4+90OR
         D+qbPI2vs2SJS7p2amuPVDNovhB5sadB8e03VhNSz7Jslq+RixpptF3ZM+9zzVkrFu3k
         78DQF3hMNmGlKT7aK0HNpyfizyGfinMB8R/ZEtSLz9AxRQpxO3xGmkDhpPSXGvU6Mkf0
         smHgZAexk49LcwMuhv5XNixTvkgOl+uTt+Rjc1oSiG/IRLSkzeowO2uiG/68EtiGRToO
         H5/PcquJiYSC8AXukC+xghCi6DxDWTx9JU+10ekb0sfxcUCKYwcEdg/xrH9I1yBbxrfE
         FjYA==
X-Forwarded-Encrypted: i=1; AJvYcCU6+t+soXfx/q0ktZaTbrwANQXo8JCWtgQZmPeqQEoUYAthnK4J5GURknHlK4mZwvVYsq3mZzeKEL1AN0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BDIKfa69Cxfbekg6EBzUvib45Z6IHuNLq1JUOfb+pmgCwKDG
	UybkDbcef+oslihrrDwnR3b/wrJX3NOVGdxXsPDdDY47I4i9QnXEayb7n+IOow4=
X-Gm-Gg: ASbGncuu+tvQKbnfOXzOKyRw3Y7Ew4cLoTTjc3gnLQy4EFE+fjoqxbhWMjjUa8KJ0DE
	9ExE80cw4u7i6vF9VpYONaufNns0wn3A+wONkw9P3W2oifHGgSzwvpb1WJjhUYxMIuBD6bl7xir
	wSHDmbt2YQ186tFQ0QHebUX5kr823z+1ymrFIAPRFGPcc8vIZCzRR7QGl+fQpMYV+Dp/YibkIfU
	x7fVHI1begxdO3u6eIVm/36mePa2JFMVrJN7274nGnMn8So1U8nRSfUuPLBOCHbYauqQswRacEM
	PrhfQZm9tnI0MUyaINzIw2UkeoEpAt+LJk+C7o5YGf3TcwkRatBsZRFXP0dUs1kk64HA+dP/
X-Google-Smtp-Source: AGHT+IFZHmt25dELEMwZQhUshisxGn6bjEwlTvzFcbNJLIa3RfN+PGPZSE1vLKGtcV12XFgGyQr6kA==
X-Received: by 2002:a17:90b:1f82:b0:2fe:baa3:b8bc with SMTP id 98e67ed59e1d1-30a7c0c8b8emr3223643a91.23.1746530616613;
        Tue, 06 May 2025 04:23:36 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480ea0dsm13630303a91.37.2025.05.06.04.23.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 May 2025 04:23:36 -0700 (PDT)
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
	tim.kryger@linaro.org
Subject: [PATCH v5 2/4] serial: 8250: avoid potential PSLVERR issue
Date: Tue,  6 May 2025 19:23:19 +0800
Message-Id: <20250506112321.61710-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250506112321.61710-1-cuiyunhui@bytedance.com>
References: <20250506112321.61710-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failure to check the UART_LSR_DR before reading UART_RX, or the
non-atomic nature of clearing the FIFO and reading UART_RX, poses
potential risks that could lead to PSLVERR.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250.h      | 13 +++++++++
 drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++--------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b861585ca02a..6f97ff3a197d 100644
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
index a913135d5217..1666b965f6a0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1357,9 +1357,8 @@ static void autoconfig_irq(struct uart_8250_port *up)
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
@@ -2137,25 +2136,22 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 static int serial8250_get_poll_char(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	int status;
+	int status = NO_POLL_CHAR;
 	u16 lsr;
+	unsigned long flags;
 
 	serial8250_rpm_get(up);
 
+	uart_port_lock_irqsave(port, &flags);
 	lsr = serial_port_in(port, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		status = serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 
-	if (!(lsr & UART_LSR_DR)) {
-		status = NO_POLL_CHAR;
-		goto out;
-	}
-
-	status = serial_port_in(port, UART_RX);
-out:
 	serial8250_rpm_put(up);
 	return status;
 }
 
-
 static void serial8250_put_poll_char(struct uart_port *port,
 			 unsigned char c)
 {
@@ -2264,13 +2260,17 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
 	 */
+	uart_port_lock_irqsave(port, &flags);
 	serial8250_clear_fifos(up);
 
 	/*
-	 * Clear the interrupt registers.
+	 * Read UART_RX to clear interrupts (e.g., Character Timeout).
+	 * No data on UART_IIR_RX_TIMEOUT, UART_LSR_DR won't set.
+	 * FIFO disabled, read UART_RX without LSR check, no PSLVERR.
 	 */
 	serial_port_in(port, UART_LSR);
 	serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 
@@ -2429,15 +2429,14 @@ int serial8250_do_startup(struct uart_port *port)
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
+	serial8250_discard_data(up);
+	uart_port_unlock_irqrestore(port, flags);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 	up->lsr_saved_flags = 0;
@@ -2519,7 +2518,6 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2527,6 +2525,14 @@ void serial8250_do_shutdown(struct uart_port *port)
 	serial_port_out(port, UART_LCR,
 			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
+	/*
+	 * Read data port to reset things, and then unlink from
+	 * the IRQ chain.
+	 * Since reading UART_RX clears interrupts, doing so with
+	 * FIFO disabled won't trigger PSLVERR.
+	 */
+	serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
@@ -2535,11 +2541,6 @@ void serial8250_do_shutdown(struct uart_port *port)
 	disable_rsa(up);
 #endif
 
-	/*
-	 * Read data port to reset things, and then unlink from
-	 * the IRQ chain.
-	 */
-	serial_port_in(port, UART_RX);
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);
-- 
2.39.2

