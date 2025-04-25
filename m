Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F622D792
	for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2025 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562282; cv=none; b=HOdjcH8A+cS/R1+B4ZU7KoaGW8Zwd6I47RgBHFlsLCrMi89hj23gPVbm3GyOTLuwB9wGWv2+gueXhbffUCL0DpSM2Y0HPzZymcTjkGKNuLC9eNxTAN50wiA/NdNXoPzENJEDr7bi2zhvSCI7vT5vWfxzzZtwo94j2/lJaT0pPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562282; c=relaxed/simple;
	bh=JRGY8EhJNG3LdqI7TA8WNIyRT8Uk4jU6OLCZM/Ys9YU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fuqJkfINyoEOkwF75eESWAmjiTUdNVk0oczGXIAWWSE/78Cfxov7JeJB7s3Lg7qeI9eHJPsmJgTFP37Cq0E2c/EaPq3PcllLNHfOnnRh0AacKcIBpfVyYmh82Nl7PguDBgQQztFGpyWQiqQOtFaFNOplAUvbqYV4wCzm9tHMrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gIsC7Phi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gIsC7Phi"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso2482084b3a.2
        for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 23:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1745562280; x=1746167080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJpEZ2xP+7fnMKxOHVyOLoCtS9TXg2X0D6AWCb+viEY=;
        b=gIsC7PhiyJ9GJghLi6YdJvLLL+WLYj1pgu+6PmC2QLE6ZSaiXJCbRlNpvRuhrl+XxV
         hjtwtcYBVKiY3LQphrp6pxZ0Dja7irARVwTJxjCeJXPvu1Us6iBcb6DZFr6ByC/XKSnm
         O/WjIFHw+JXRhAi0VfHztNiirjry3GmGdYI2lk7JyyKrmBAKLOVXCmPyAkihj6t54yv1
         itZFrArRSPcgeK3fx6/Dro5PCEU50b6Uo5ORnV55npyK50BiNUeFH1n8YJM2c2ouFtlh
         3uxkN5aSZ15GGV/Ytpa+bw4kXJToBtgTawxOCRKrgb7KfYHsIa+kxjsGY2d/Mg6z953G
         H+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745562280; x=1746167080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJpEZ2xP+7fnMKxOHVyOLoCtS9TXg2X0D6AWCb+viEY=;
        b=uh6q74SxMMfnznhWOxVmyMMmby9OIwfGmsLsTTdBsEj4tfirUHxOFtUi30QhLcfu65
         ihQQ5yr2LpOambzeYw6uGKqe8Gvdbq8A+j9/Ca0hAW21dWzoL1kRzL6bm4/EclXZ5OtZ
         PpAPe/rqJoXl5FTskSp7YXbAdzhMKiGV2fSDQvq3n5kxDGf6YJ3ziPikZdJTEy9RSco9
         2iERKie1OCL1Fc7cPOU0PIY6gTfcT8RZWyjKEDQmH3/HUmbI5SYsVVLBQsZ2yzGoKJF0
         uKgYRyJ5e6wwF7ccpu58CpPDf1RoYe6GSFZ1icdVQKBwxBtcQuL9jIW/piFpLwfpBqwm
         RPoA==
X-Forwarded-Encrypted: i=1; AJvYcCVCM0ueeAwnDw5SD91JZt+B3a49tbYfNMkiEMZbpZmnd14S59W2Dob0zXnRNuKqLR8NMu/H4Zgo/NdFWOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWk8T75rLMlpNWot0N9VMmzNVR+/Qxjg3Pt9rntW/w42Hn2u8J
	OLkvAAl7JiX8vLO2TR8k/dDUxrufUj8bqtdxEc7dCgk8y1dtJ3vhN0Yg5GjmbIE=
X-Gm-Gg: ASbGnctdOSMDS0LqH+j25SeXIOlWOi55wfqqq9cA85lbnmgQgeS1HZuaMukp3CidD9i
	d48G4JScjBB6wpqzgX4DKoKccHxOlLQH+UIy9oZ2B4Mu0KHvRPtGqdvxzrhftbM59b7W0YcKH/B
	Nsko446VYqhSiX78OZ8SPDqinVnlAXdSc47lHBy65eXrsPX0b+a5z3Hop93y/bCzrKmWbUwoRVM
	oBhK2j3x3j7QRu2BK5ofXra0Jf260NdUelqIvCUSAGwsGeqZv5nfX89sgj92ksenhD2I2mXygXR
	+VA7QEC3It2fNTT5iBCyxiLUqcgrjBHCmRQMQgHM7xLNDesGkZao5IhZU82AST7XKOeZDzI=
X-Google-Smtp-Source: AGHT+IHOnPocA6swARLMER33Lf2WWzjsNpRtF3v2KvZDOoV8D0ZSmIB+LGzAUQ2OJRGjlueD8RQ8pw==
X-Received: by 2002:a05:6a00:2301:b0:736:a77d:5412 with SMTP id d2e1a72fcca58-73fd75c4d6emr1493911b3a.12.1745562280132;
        Thu, 24 Apr 2025 23:24:40 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9fd26sm2414367b3a.151.2025.04.24.23.24.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Apr 2025 23:24:39 -0700 (PDT)
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
Subject: [PATCH v4 2/4] serial: 8250: introduce serial8250_discard_data()
Date: Fri, 25 Apr 2025 14:24:23 +0800
Message-Id: <20250425062425.68761-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250425062425.68761-1-cuiyunhui@bytedance.com>
References: <20250425062425.68761-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent triggering PSLVERR, it is necessary to check whether the
UART_LSR_DR bit of UART_LSR is set before reading UART_RX.
Ensure atomicity of UART_LSR and UART_RX, put serial8250_discard_data()
under port->lock.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250.h      | 15 +++++++++++
 drivers/tty/serial/8250/8250_port.c | 42 ++++++++++++++---------------
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b861585ca02a..5a106cf88207 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -162,6 +162,21 @@ static inline u16 serial_lsr_in(struct uart_8250_port *up)
 	return lsr;
 }
 
+/*
+ * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
+ * reading UART_RX.
+ */
+static inline unsigned int serial8250_discard_data(struct uart_8250_port *up)
+{
+	u16 lsr;
+
+	lsr = serial_in(up, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		return serial_in(up, UART_RX);
+
+	return 0;
+}
+
 /*
  * For the 16C950
  */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a913135d5217..802ac50357c0 100644
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
@@ -2137,25 +2136,21 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
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
 }
 
-
 static void serial8250_put_poll_char(struct uart_port *port,
 			 unsigned char c)
 {
@@ -2264,13 +2259,17 @@ int serial8250_do_startup(struct uart_port *port)
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
 
@@ -2429,15 +2428,14 @@ int serial8250_do_startup(struct uart_port *port)
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
@@ -2519,7 +2517,6 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2527,6 +2524,14 @@ void serial8250_do_shutdown(struct uart_port *port)
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
@@ -2535,11 +2540,6 @@ void serial8250_do_shutdown(struct uart_port *port)
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

