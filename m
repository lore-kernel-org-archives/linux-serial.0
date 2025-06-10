Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5828B4E1
	for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547363; cv=none; b=kN9pJDWS66BTxyrxqOBdRa8uOrgJYQK8Ru/MVNZ2+0t1pjMj2QBubau9NEwO54zwc2t69gcV5PgeP9HmVfC6Ik38jNDR8l4LE/mGxiZ+ok+EO2EU4sfWsg4q8oAun18L1dB6p8DtVArPzfamFvg0CemfCbUM6+QXAMtHyWi84k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547363; c=relaxed/simple;
	bh=qGjOULSQfrhZNYJbcbq9J/bx7G4cga14Ksr4xHqMKco=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJ0Z14vyzH9rrBXI94VN0E+t8qRgC2swa2GEbJ4KmxTbDCp19EBB6O1+zOvEXdnzXrvGEthpASm569cIKbamXaBtc93lXqyDOX+B/wiQw4vuAWlF4rP9if4mJeoIPP1aktC+BxCnVUIa3ylQ8FYGQfCO0+zkqI3Talee7Whh6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X3zOLXdP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X3zOLXdP"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so4311822a91.1
        for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749547362; x=1750152162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MgSetHRD9od3OJ7iz2rDkPKMWGhLjKM4sQsvvkn2HM=;
        b=X3zOLXdPj/USKfWtKzO5pYLFm+lJFGmkp9XClStqWELox/zcQx1K35/1udJqlbgqO2
         WXBYIYoUHZ6b2Dr9oDhLKYUHQwlU55NsGoPaj+r1MAyzH1wTSe+qvLZiPkaHdTfnlKp7
         mfaEsSlS00ytd0g2svs9I1xDEKRH4XpWW8JHDEQMkHIVbFjyFCIZ5Q/DXQC+UAwoXQFA
         ZYy4kLrSELXNATMnzj8ls2ceagWOXTRvmO03xv2fydjWkz6/TQ6avrGsq30MwFHLgDOR
         NG1mmRuM8tlMLAOZWTv4QBsoPxWcXigX6NQgtPitr2nuOyd8gofilrbTriAc8/W+nJQI
         aksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749547362; x=1750152162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MgSetHRD9od3OJ7iz2rDkPKMWGhLjKM4sQsvvkn2HM=;
        b=hnqAvsPu2wHq4xEKe1//p9RszIfe9YmQ+mA13P0ma2MVg6Wcr9py+/BwBGbY4S4GZW
         gW1RERvR0PRbWGZGpGAgdIxaygj8DLE88wxzYd21HtYgHeQVToUo9xTpeNmRrgTXWXoK
         kgfkvU+wiAUv9+NauPhVO18SVvLKMd/19tok2IPSHwmNQ/JwrOspXBiAeyz/5ZbwZK8i
         87XUDI6cq8f5PvbX/BthFrSflRhNwGtUlf8x8ICGGqM1XErE+oc0ChYHRDjchXA86ztu
         fxefgMQxfUQAZaSOPCCmRTYZHjU9lawXnnkr68cqKfs8+H556YOb+bul9aLX4QdTj6Po
         fIJg==
X-Forwarded-Encrypted: i=1; AJvYcCX9qRH9ES6JMnN+LQ3n00oqX3smY56oW6zOYYpGoJChwOI72J/vLIpw2iremfjgzbyhf2V0NDytRQmOtJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WYVyHDI8nphILuQEvJIOUnoiecNyLnw/JYOi43tX8/g4mQtt
	8Wssc/OxLfyZWphLGAjLSaHeoy8URWjx9xBNveA1F3p6PF76qXGfonfjWeAXeHw3fe0=
X-Gm-Gg: ASbGnct9wsUVs83sllIowiEOSsg3PxJnDXc4s8pbfQ1hB4GaCKUk8ukK535kXLPfRjC
	iVyz78oPN5UvbtUijeB7BFsmgrTFTzQcU0NOfNYCF+FYnpnM8jMoTPfpDqX7v5rW299SfeH8ok0
	HBByLvCvShGX3bCjKxGpk5X0nFpSvqRKcnH5HWND3gY3E+txmdCigjg3YCugZ1wr86y9z7ddqUg
	LxuEXNMSRqe8k3ApshILLMZ87pIKlPcBIUb9yY16gRrgTi5mmHzQ6TNS/W8D4nEm1mZdiBBwwMC
	R/K8ZDI5isJuh4bVQw4IpeGMbJpjX76QrFv5gqy33VBKtV0zg8gkCByZCfwrtro+LaOkdg4dldU
	6eSRB9PUoiXzEWPOtQHwoM/6XzQmlwSPKjQLPjEX3m9aCm+pAnnPZ
X-Google-Smtp-Source: AGHT+IGZ6kCTpPTdoYwEBrEfm3L6AeIfxAzFF36vrkgy3DUS4kpMxoV+uz127U6xDCaxRl/X5+hdwQ==
X-Received: by 2002:a17:90b:390e:b0:312:ec:412f with SMTP id 98e67ed59e1d1-31346b3fc52mr28602435a91.14.1749547361546;
        Tue, 10 Jun 2025 02:22:41 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc9ebsm66968605ad.106.2025.06.10.02.22.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 02:22:41 -0700 (PDT)
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
Subject: [PATCH v9 3/4] serial: 8250: avoid potential PSLVERR issue
Date: Tue, 10 Jun 2025 17:21:34 +0800
Message-Id: <20250610092135.28738-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250610092135.28738-1-cuiyunhui@bytedance.com>
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
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

