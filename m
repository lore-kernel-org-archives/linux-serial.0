Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429B28AB16
	for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547350; cv=none; b=SNqhVesu9/0Y53xZae/SJxqFtEgZkHiy6IJzr19jCHzXmefVVyNsSSYC382cbc/3NH3bDNYphk+3sR2oedkgWYbm1nCaMGJi3MFNmsGkhr2BZ+g/otQMb0ZkEAVSZf5vLkDlYem8asYDguGClIy/Ff1DkK4qVDDB431iLBlx1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547350; c=relaxed/simple;
	bh=Yay0E1IktJ5U3dv9Jr5sXBr5qazP/zu1WzMA4ShslGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGm170e04RmGxYKo6jw8t9PaAwNLnBoB2UGJ7+z01l2UV/ftrWq0FKVYyfEP4R457cc2SB/A1tb88LAKAvhKDBl8Os7LqO08v3u9RDad/r+9EHODCu4LH7snMNFA79/eoJIpp1spbpnMhFgMXXfDmVVzrHqK009x4f1OMgaTbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jVFiiOF3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jVFiiOF3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234fcadde3eso61725755ad.0
        for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749547348; x=1750152148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Inkjt4Nq2XV942wyB2oCSN3ntPshT/X6vryIjMwcT1A=;
        b=jVFiiOF38oqLjJUReNTGhqSFrZZPEFMTginsQDmkYe2OyS1Rjv0O6n3784AmpWp2rY
         pSnmlsUzdoVTwZDYZZjw/7IXKBpdWIG5pLa74sAG97KQxLNk+TN05KAG2hUayyOkMq0M
         4aGsGiJkvOTCG6rh/pL/D+E3B8+bVCrLQaPHy5ipZJ/e9XAAbdZkMWJNzI/jpjNvdEJx
         boMy8AUZzLsft9eDXqFnkB0R3iV1s8NTb1dneAo0u7zzgrDqbiBoT7k1zPaxz9FHOfNZ
         mGvZvSvUOqUEeMvW199o98XZN28o6Z05+dV/TRCD1ukzilHlg52A3zgX9eKSpAoWyfYZ
         0JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749547348; x=1750152148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Inkjt4Nq2XV942wyB2oCSN3ntPshT/X6vryIjMwcT1A=;
        b=irNmg3kCjpW6I4x0qEk/x8kbeIaHIseNKx0vb/GQMNJHsPZaHD3AXUofXVqXor64h+
         dTv1eUP256a938oEJuXnUB2BueMDsxrX2YV5FcJKddntIHDFLBhuzYpXs1GULymnpyn2
         /QR5WoSOV10zQ6tSV+jYd+SuaEurly7liGqyOiORsWPd6l3bAdPVpfKj72OwITEQkwvt
         hwwD7O6OPeKZdZITF4Bz/jnWrgkGcrQABMcdkDkcQnW1XgKMHyqzcif0bbNJT3vg2zI0
         hwkx7q8MkwoSXmcs/2fE++xwwDHICNQ0Svg7/4duWLYPCVT05kujgj8qj/hQ9B41L1qk
         86Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVtqqSYbwfjfsBNFMvKOf/BIBvgi1vqRWDZKi1yr9O6cmB/dHPR66wRS7/FCstM5Veo58Drqv9i77SHu34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNetmaez6H+GAMcW20SN49GVQUq9EoxRnnAvdeZWE2w1oxAdVh
	HQcFWiB7JgmR5FjRRw4rEh0/PZiuIYa4bJu+JcdNmg4I/7WSPIeHDdWb5hoHSHRz4gg2DBKeLXB
	uou0wjGo=
X-Gm-Gg: ASbGncvrgcXpsEcAgT+9mxaLugc5nIXUVrIwEOYCUv0K+Fl5bDkVk8TYB6dLfN3sut1
	lXahpJWoZtbPigbwIawUjdXl/mgky7+Yv22zZOXc0y5FUC8mIxspMqLGBA8O6SjVihx0llKheEq
	ldOg8JZn6QpxWpyN+HCrn+VhkMttcRytvqAYTgfgpKaZhSWLHs4dJ1KXS6EFos8DzqtXvozr7/k
	zyJ+o2/fi0Q3xbz9lsYCx158Jth1lkSAwjYOc1UZRCk2m8QQ2A8XV6eN+oS2Sc89IkQ1aa/p1b2
	4wwCfacBpuNXSZQOuf5FhzFoAtERjh3Tvqtc9qKLaZLBjUR3vUAxNcfDMZ4wRmQi3vyBJt1j5XK
	h0Nm28BiAU8vL8+MEBewU5KWi/AYlLqT8KXibIsszdA==
X-Google-Smtp-Source: AGHT+IGF1wKkfYtuiimtR/p3LIkqw+9S8l8lvSXg9Z3PNzxGl9/ZZMkReEoX7Hs9Ut7c8jSVbeCQjA==
X-Received: by 2002:a17:903:22c7:b0:234:b123:b4ff with SMTP id d9443c01a7336-23601d08686mr221662445ad.21.1749547348162;
        Tue, 10 Jun 2025 02:22:28 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc9ebsm66968605ad.106.2025.06.10.02.22.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 02:22:27 -0700 (PDT)
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
Cc: stable@vger.kernel.org
Subject: [PATCH v9 1/4] serial: 8250: fix panic due to PSLVERR
Date: Tue, 10 Jun 2025 17:21:32 +0800
Message-Id: <20250610092135.28738-2-cuiyunhui@bytedance.com>
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

When the PSLVERR_RESP_EN parameter is set to 1, the device generates
an error response if an attempt is made to read an empty RBR (Receive
Buffer Register) while the FIFO is enabled.

In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
Execution proceeds to the serial_port_in(port, UART_RX).
This satisfies the PSLVERR trigger condition.

When another CPU (e.g., using printk()) is accessing the UART (UART
is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
(lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
dw8250_force_idle().

Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
to fix this issue.

Panic backtrace:
[    0.442336] Oops - unknown exception [#1]
[    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
[    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
...
[    0.442416] console_on_rootfs+0x26/0x70

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6d7b8c4667c9c..07fe818dffa34 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2376,9 +2376,10 @@ int serial8250_do_startup(struct uart_port *port)
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
-- 
2.39.5

