Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156C1D6193
	for <linux-serial@vger.kernel.org>; Tue, 13 May 2025 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104150; cv=none; b=VxV+FFKaBO5d92s5b9dpib8GuMxSkaCLKdVbNwQc5CgOLucUsS7XIqzqhDZNm6vHD6bgzTzomCXvcrNr1PZ//plNz2teQlP+eIwTGHQJZ+hWdfq2iN8UyCXmvF27CSeVhk61L92ZSjKW5t0eAvVW3Ad52SJZQ/nIEGj3mITLN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104150; c=relaxed/simple;
	bh=e+v4Zr92eyG7+QnKK0qnF/T8cpu3mmFjVSTUv1HxefA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVpqcpyOtHxSk/cBaP+q6rY9AD1rkJqmN0Ggi5VxTZ0Ba01lj8A3Mi8XUcTb0mAk35w/Gv4+Xw1k9iXRA6Pw2aWIWS1StikP4SpmOYQhiqm3zoo/4I+WkviIf4kp8gdGDAa00cGdUKrGYH6F80Xd8cosmuS+31lNweuEwzuy07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iKAku0j4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iKAku0j4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2301ac32320so17894445ad.1
        for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 19:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747104148; x=1747708948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DV5CEqfyHAgAAjyv2WRIohYgE+cRSSVgj3hQ7beqdWE=;
        b=iKAku0j4rpr33nHa4N1YZON8/KQhsNB4MW6WjQJ72K0Jyv7lB+wDA+CiyXvqLA6/z/
         BRgPVEyi88IfMKZNo3hYyjTw+gzqEWa0BUWp8fJAFtYDJnAlJz8BchTX+U5WicLANT0C
         fsTN5NLofLzCBROwVpQu4et8mUMkoLNR9f77kmh7FjgcsMWOXd+6J/gTATObbE98PaW6
         z2s+ojCiFkrRjjkM3sCTw+kc5794I9MwPGFx+eqKiGXwJGoI99ybsj4bAu/l/8ZqtjYO
         R9yUyksFizWmyKmLJDBZjGYSZv+a5noCI0ScaGmz5sAJvYPk4SOvjVwY26xkI8RiKVxw
         QVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747104148; x=1747708948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV5CEqfyHAgAAjyv2WRIohYgE+cRSSVgj3hQ7beqdWE=;
        b=TYMIK7yC3RQxEmwVfPTafobnKD498PVHUuJOGMoScyCmJd5SPhCtU0TCJVYQMh5Wf3
         sydgy3YP17VW8sjEz1bYycHRiBqY2aTCZdm8NmQKqnaqxdHCOdDYBj6y29HfrDcLASq2
         /W+nv9o7qwupE60jbq+tIkinE0zQgsBQ7fNnkOMXClj6wzxIkovGGuuWt684M1ekW1B8
         MItb/lok+61yDKG4YI0uFDYFAvtvW3mwtpFxC55i6fE4MYqdzVnJqp19U9LSVqacyDNY
         mQGAN24FHDMq6hgYfTfbb2zoo2NYedDWOy9NBej2S7YZWwTmIQKmnUIyiwfrYtspGZ02
         UjPg==
X-Forwarded-Encrypted: i=1; AJvYcCXaHH5HkqRb7D0qYFBuIxY61g7dV0e6LgyevB+8eKn68kPzc3+E6Dd6uPcM5OPVoxrcIiBUet/bU+2dryk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXw7nXT6ekwZtjCRaaVHrSN4tWthKP2U3s9vdPHxfS8Ye4hc+T
	RgkEpls0RPIgAFaU4a05/5mULlt1UaPaEQVFKsRqJxUTpcPV8QqkcS2lPxzJOOY=
X-Gm-Gg: ASbGnctsthmjzNPpH+4TgKwHk5mdvJvvBpnTsjiDZ3MldVJHIafy6pAdhQFyTzQBzjy
	EMQDZ7q+TjTxBcGy/frh1hUM/ggWUinsbWhH6IXgeCffLaWSJOHhRlPtOnN8CriN6+oUw/04LUu
	cnwemujJkSPi4v6Tl4m/TwiTrPPRkL+f4sPUvGsi+4D9cL20AwiwCOYMazOGXWInnycqntPu4cw
	w7tNK1Uq9MXyx9MYBuNE9cCLsPmZdv+aYbFN+8Zi3z4zdfyRC+MJEGrJpejrowfk4oUid3AA3zF
	04aczGwO+0pEwKi2NMzWqntTgDh1W4550BqSKJmXi5E8lAYqK050nZIm8Zqk0USG8ZvhdtDctu7
	gUTbrbw==
X-Google-Smtp-Source: AGHT+IFlfoZ5GV32RO45S0BratEQLlMY7PMYDfKSfBPZRjmbBcVeTwlszFo5ImGeJ2jOHanst9qMXg==
X-Received: by 2002:a17:902:ecd1:b0:223:58ff:c722 with SMTP id d9443c01a7336-22fc8c7c1famr265687285ad.28.1747104148027;
        Mon, 12 May 2025 19:42:28 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc829f532sm70592595ad.228.2025.05.12.19.42.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 May 2025 19:42:27 -0700 (PDT)
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
Subject: [PATCH v6 2/4] serial: 8250: avoid potential PSLVERR issue
Date: Tue, 13 May 2025 10:42:10 +0800
Message-Id: <20250513024212.74658-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250513024212.74658-1-cuiyunhui@bytedance.com>
References: <20250513024212.74658-1-cuiyunhui@bytedance.com>
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
 drivers/tty/serial/8250/8250.h      | 13 ++++++++
 drivers/tty/serial/8250/8250_port.c | 47 +++++++++++++++--------------
 2 files changed, 38 insertions(+), 22 deletions(-)

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
index 07fe818dffa34..9a04f24b0c762 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1353,9 +1353,8 @@ static void autoconfig_irq(struct uart_8250_port *up)
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
@@ -2133,25 +2132,22 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
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
@@ -2521,6 +2521,14 @@ void serial8250_do_shutdown(struct uart_port *port)
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
@@ -2529,11 +2537,6 @@ void serial8250_do_shutdown(struct uart_port *port)
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

