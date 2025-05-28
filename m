Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B8229B0B
	for <linux-serial@vger.kernel.org>; Wed, 28 May 2025 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748413590; cv=none; b=HtZbqBSPH6yBitfEOZ/tB+v/AM1ZI1iR5osm3lp60qauYCXH0PQIBIW+dRgDQbDdo2u8jekAgv7uqgOqSXXPZLhLrZbT+JCyzt1HSvQpgivtIdR668xeHNgN7WI11O50Um8nxK5Rqc8J4smdJPjfxqMRdxv8Sy3GDPBLYapnF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748413590; c=relaxed/simple;
	bh=qGjOULSQfrhZNYJbcbq9J/bx7G4cga14Ksr4xHqMKco=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EONs6Os6ITRfMvAbJ1LrG8sh/OpBimch6SNEvs3AadJmXJkPXGLP9RR6dODEE2sqF7g6KbfGVONlk+qweys+tMs2J9LXUwJZu2FJj4U+u+efxqObVIdjo65Zc1wrLEjI/TT6tdSlX62NTGVqgamSVz0+m2WwMFiPUjdwg3apXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BANbHvaF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BANbHvaF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-231e8553248so32111545ad.1
        for <linux-serial@vger.kernel.org>; Tue, 27 May 2025 23:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748413588; x=1749018388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MgSetHRD9od3OJ7iz2rDkPKMWGhLjKM4sQsvvkn2HM=;
        b=BANbHvaFuZb3wPlbhHaPzWrBgU3MH5Tcb8ioHlAPVidFx0LDHqP/nt8b6Mhvspgq15
         6xLa/9VdBbp4aJ9pLU07S1pwFjG6WwrstIbFCb5vuh4jhhxnJ4M1MAlSVJmHVARL3NXU
         F+0MnyO0MDXj6d+Vr3Yy4iNzad5RxN8FDTEni4eARXjIFOSg/S1lUchAqD+xi4G0QbdV
         bRS0Qm7r8n1r/2+KcpWKjLM8okHCPOkUpUFHz8qxOUqZSlwg1O2Fp9hJ5JRktogUVqss
         hf+4O3LXOuuewXaE0ZGUcRacqEq5CHp4j3wwM3b4yDXwIb90Z+VL4z7AWRrrH+3rijto
         bs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748413588; x=1749018388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MgSetHRD9od3OJ7iz2rDkPKMWGhLjKM4sQsvvkn2HM=;
        b=OGFLlXrB3b5VFKn8UXBTryi8T0oN3CbrrMEcBOw6Rx79mLac+1QdpTKqAtOa64wx2R
         RsnwI/WDRBGS1POK7ZTTTQ66GsNJyv0BrcvWRnFBtZzmlv3qrDF0oMtdm8ex/sNq02Lf
         OsQRHUIH79yTmrywEnPFvglPJsBsWdBC2vQH35BEGML+BSMSSVlVmEus7Vrxh+WfMTdT
         gIByzkRYvT5wFkZiFHEM/RpT0P8YRwVeU4lOma5cU7vm2NovzA3OCOCbcyG8cs4wj2X0
         jCrTBDVIOuH3wfE3mcYQ/SEAuQwJmWNc88afPg94Vxu/jPoaWoZvx+jDXSVtnZczgumm
         UHVw==
X-Forwarded-Encrypted: i=1; AJvYcCUkthXeZG95XvUxZ+T6gG+1wqLy/4D0wtQlXqwUnji5UGq4byfxl+l9Samhsnqv+tocJKJHW7L6FquJq3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzW0wZHK0oGh7gnZ5kleq9+e73B1/6f44e6znP7CemHnFclko3
	f1QYVeF8Df2x6Zna7WjXyFgiZYX5adclURXWICjzAX7GMQCdqi2iLUsWj4BKCx6C06E=
X-Gm-Gg: ASbGncvkTjmhkyhyriXOaqJhHeS42sbspH9kt82OOxcEQiH8XWhQi0nOBCu+dy28CLe
	832zp4e8OrkYLilcbDJ/T2Nmf9o7SbY9U5UXare9jIhAMnE25MXy/oxVyMzwwTu74VP/7dwlRFD
	9ixzt2NWKa3/tZVW3O3XmTYUFQJIdHpEd8dt6okX510GQIVx5x6Fp9f80tLUCi6LcHAeO89wIm3
	kG34ZTeL96NGNnBv9z2WuAEtJKXXJxjke1NYyN/qjzcASOOmPz41iiqG7W+nRN4G2Lg2vBLL39Q
	egS1y/BGNHJLP+SrTJOp1QelcL7+T9VOBD+pmUARGG5Y6H4V2gbogD6UMFq/AdKDysKcFtItwlK
	6dKAYFgsjWw==
X-Google-Smtp-Source: AGHT+IF325pPEY0R+/zinfzdIgswAy892RWSaAg07IWccXaRc3y73zytZGgiOq5DoEa+ManNhR1Afw==
X-Received: by 2002:a17:902:d490:b0:234:aa9a:9e0f with SMTP id d9443c01a7336-234aa9a9e76mr57107955ad.23.1748413588026;
        Tue, 27 May 2025 23:26:28 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35acf6dsm4619515ad.201.2025.05.27.23.26.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 May 2025 23:26:27 -0700 (PDT)
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
Subject: [PATCH v7 2/4] serial: 8250: avoid potential PSLVERR issue
Date: Wed, 28 May 2025 14:26:07 +0800
Message-Id: <20250528062609.25104-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250528062609.25104-1-cuiyunhui@bytedance.com>
References: <20250528062609.25104-1-cuiyunhui@bytedance.com>
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

