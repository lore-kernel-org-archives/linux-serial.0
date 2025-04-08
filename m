Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C01CD1E0
	for <linux-serial@vger.kernel.org>; Tue,  8 Apr 2025 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092734; cv=none; b=ghBwkgPvJfN+c+IdcQb0tnMrXzToGuKJt+MKJM3Sz7HQJhP3ZmAjiPExYJPynm/W1vtLcDWyIhokVREguzwPLCOHcsmb3CvhE7EKLaNC4ccTWE+8cZdB6Ls+Ka+JsXE8VHqKwGrEf7yt7rBprerYZhDzmib7toW3Vu2vbQloM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092734; c=relaxed/simple;
	bh=/XVoDUPkVMXpMySVKgHf41oApm9urLS04UxPzNfilP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BsT0LWXMuwWl9y4Uxg8jH4ReP7c0thaAXcnFA2/q5AvsWiFL6sP62Wzzg5JahKad2fZxNLIJVMpvvQxg/HzzZDA4/1AiqVJdnbDY11/hJAcOxAydxNtbBtW0SNMaUVZJ4csOxzrH4HyvoVVscY1Mz6I7X3dGgLFyxTINOT7Dbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DgJZWPsT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DgJZWPsT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-227914acd20so54550065ad.1
        for <linux-serial@vger.kernel.org>; Mon, 07 Apr 2025 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744092731; x=1744697531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja9t77LzVnBbcdFbbm7pXpQan+yLqLsiGwXfln1XZjo=;
        b=DgJZWPsTC6CcjQw1kmfRyxHEREH/8MqgJthJtdA0SmmJhFV3c2LBZentw4I439GXoc
         pXHUOxGrTj1pkG85vIJrHl/1XeftifriuEDFGBYRCga/f0CHPlD+wvk527n2IoAd8pqU
         A9xOpnIzalW5vceyBV3jlloLML34Ud+vmIl8FE0IRiE2RehJi/GjVV5TqVWru4BmbEHO
         fnrSm4/00ZRMkeut59hZeItepTyobpYY4eblnco4PrElq6Gsn+7ZfcC0TlDU6z4xQ3d0
         RYUs9Kf6XGHlcR4O33I9IyhCSQIkGST1cC5uxIJzaV6nY99dBVAfWqkIe/BeVB6I2Dvs
         mk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092731; x=1744697531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ja9t77LzVnBbcdFbbm7pXpQan+yLqLsiGwXfln1XZjo=;
        b=FThWE+GJwJzwGhaaLnbquaZfrLn4KCIWeNU9aGZ0sHMh5SAYM0GlpT6MfhYWsHX08C
         uwtkzL5OzKRT88bk1fa9kZDpK2GqA+iudH7QbPjVpuMfGHsqkRZqqS+MHUoWMBU0oC3y
         GoeRXQuOqn9y2l1qul0kwp5HKZvdbcFhOErpmYoFXTuD6dr654J+UEQ0dClcuNpnpN/F
         dxsnB9/4azSsh0FSm9VM3hEnufNLKngc4C60VPoymotTRblRIugXtlYm2VF91uNpqGWE
         hTzWGJASwrP1PvXDgALlfyHiKLcGDsxuGvO7+bM0ldbjzhYgYUzP6nPEQKQ/G6/9guvO
         pF2A==
X-Forwarded-Encrypted: i=1; AJvYcCWfIhx6zvZJ+1oMH3drkL6X8YMzDNlrEr05GVjIdQEcp84CrnSv0OQQs0TlHDHTvDDbuB7cK+s8PXBx65Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcL3nKElo0zzHzIo0KExZgyp5+xmsGBzlNIMCB4xXln9OUAXe1
	xAm9DuuITJq2JjYM7Ya0+h09YgoMhDMIBH5NJjglWOJZgB/diMJmgYwvP6mFqAs=
X-Gm-Gg: ASbGnctEpWZkWMmCpcznVsWAJTVH5ncA9Ritzdhc4euRb5WWBWmv8aG79ewh6LlhHqD
	EHcgDj91phy2fMrliL1C4bP0vxMfXfF+2SDzbd/sY80QLPqQkSOp3EPx2N2Fu4qjPtcjOAFSPmX
	ywg5t6ejXh1Z8nesflDFYIaNJu5vXiRDAf5cz/t++kTfzngzpZ9ydVJGxHuBDHzgEdn1JOjaqQB
	aJcwhjhJxdnEEibI3u/OIjAlwxBnBIjPizfVUYGheCRTT/3fWpCn69L+P3h/906rFe2r3EBnxZe
	/Iwt0nUv8nvxgl9u7Pzo7I5NSLqyffDl+X7XpDYkq2ubh/HtcqukiiAToEcOu+JsJdVKn2zYfEt
	NF1M=
X-Google-Smtp-Source: AGHT+IF/7Kb27Mxww3xm9QXF7jh8x98TLr2PScPfaDKxwWdwGRcFiMRdb9/iQCiKilLFCYbh7uESNg==
X-Received: by 2002:a17:903:2281:b0:224:3994:8a8c with SMTP id d9443c01a7336-22ab5e0f6cbmr27047145ad.8.1744092731484;
        Mon, 07 Apr 2025 23:12:11 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787778efsm91523045ad.259.2025.04.07.23.12.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 23:12:11 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	pmladek@suse.com,
	arnd@arndb.de,
	andriy.shevchenko@linux.intel.com,
	namcao@linutronix.de,
	benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com,
	matt.porter@linaro.org,
	tim.kryger@linaro.org,
	markus.mayer@linaro.org,
	heikki.krogerus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2] serial: 8250: fix panic due to PSLVERR
Date: Tue,  8 Apr 2025 14:12:00 +0800
Message-Id: <20250408061200.76148-1-cuiyunhui@bytedance.com>
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

To resolve this issue, relevant serial_port_out() operations should be
placed in a critical section, and UART_RX data should only be read
when the UART_LSR DR bit is set.

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
 drivers/tty/serial/8250/8250_port.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3f256e96c722..3df358008489 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2264,13 +2264,16 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
 	 */
+	uart_port_lock_irqsave(port, &flags);
 	serial8250_clear_fifos(up);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Clear the interrupt registers.
 	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
+	lsr = serial_port_in(port, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 
@@ -2380,9 +2383,10 @@ int serial8250_do_startup(struct uart_port *port)
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
@@ -2435,8 +2439,9 @@ int serial8250_do_startup(struct uart_port *port)
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
+	lsr = serial_port_in(port, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		serial_port_in(port, UART_RX);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 	up->lsr_saved_flags = 0;
@@ -2492,6 +2497,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
+	u16 lsr;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2538,7 +2544,9 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
 	 */
-	serial_port_in(port, UART_RX);
+	lsr = serial_port_in(port, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		serial_port_in(port, UART_RX);
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);
-- 
2.39.2

