Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612824BC01
	for <linux-serial@vger.kernel.org>; Thu,  3 Apr 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671032; cv=none; b=OhZRdPTw283e4IMPegC1QXHwBVzl/OAkA9TJT7viKhugyALKeR3YSsimQ9kjfxZ04Ice4LcTxIqNzvkNPPdPZezyBgHjZFTs2b5gNETrb3M1v6zqTbS3dxyQixfJvd1zO3K02svwmLJW9R89lv0oGkpdMfFKIUt5WhTt+Uz162k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671032; c=relaxed/simple;
	bh=Zm3UfkLkf9JOvDt1YLZ1WiQhqcQXN2ei5hUgD3649oM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q3lX3l0KP95HoUknPXVpoNULkUym+Wx4W+rx8b9dNiPI/8aRP2VGKACaFra5j5Mgtssslvt0hzDdotvgZCNFgzsxgCJj6VcWV/MMBoNHaypwKWZ6MrdN/oy/cslTj2qSM0TIqfEYDc5V8lxce6O65Eue0p9z1BqWT3AqrnIiNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BouCKMcz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BouCKMcz"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2295d78b433so6660555ad.2
        for <linux-serial@vger.kernel.org>; Thu, 03 Apr 2025 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1743671029; x=1744275829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AHPTYMQZL/LE7wiI5rF/tVcf8BGV6JGb59TmAXBJq30=;
        b=BouCKMczgK/BlPXhpLuFL/F3awCRzmgFQkrHNouSmn6vXiBUrqIc3FW++7q+3J4m70
         exZPa5Y2WtX5zZtxHwD8o8O7RyJUepYkirxCBtpDiNR/Hd8qvD0F20shjI4RrkQlrpzx
         GW2cm7BRY0+o5AaD0ORTxObQsuxg7g/WfgGX2WDkI5V80juQV28ow4gf2VnUPJhZQwHa
         GNUDqB8m2H9XMbcmszg9AFDdy9N3T6R0+xl5CwhZohNuTq/b8XBM7Up0FNHJTqNPVtKZ
         fm5GaBmCrkKpw95AwlSwBFnDkyOtY/g21gjc1l/ihQNFF2gHB1TXEoTPdvPAZfqDnmOR
         0iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743671029; x=1744275829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHPTYMQZL/LE7wiI5rF/tVcf8BGV6JGb59TmAXBJq30=;
        b=O19ArZC0FPp8zhTUf/duuWQjeABFmfl+Du9oANWLBMX/5ysmzrIWAlQI8p2K0drjDz
         atmkas3rRzAO2VPhGP6Qx+llJnL40WEJuHV+zeYNVLvpsMFGpw0ioaOcMYHMeGXifJRi
         XbX3jjsCAKLYr9qSS20Za2ohnX1dbShqF5Iiozy1gPPsqCIvqqidm+ebidNWJgOs9xvH
         zJRdmdZ0j94MTKX00zRdOkQ5n6k+wiIa5KEuA4AzMBZcDwQO7C2Y7tRqRgjmsz5U8WeK
         oxyeNRCSqzSbjlaO6IDHFUjyWUcLLOe/qzoItLpDjD8vRXcez8Rut0RW+pQCoJJUvh/U
         6R8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqFtmFWpbHUItr5kumvauIHqCmsb6I1ugjY2kRjVzfPYmRsaoT4SYtwlz9U/8L14/qRRId2ms7obT8Dd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ioUrC70LWEkdaF5F9xxAm/oFWBYWAg0jOM/txozDqddtOLSF
	0i0KSKdQB9lhD6wvL5aLgbwrIZHnwONpzInBTV5xPIQy193c+n6OcNpk/MWCDdg=
X-Gm-Gg: ASbGncvjBaJZ04RDgx68Cub6/KEuO1Q02GoDIps1aWjz6DoVHTF0rS2TCbzBHLZUxzu
	4ufq5TFLITgfYHNy3rW1cYgkRs/nyZW3YhSBrNQw6q9oQCsQqMYdLz/OtdMPOOFrrFYbV+Ala/7
	8o4UqwOSnvvuBwJGBSSlTAQkpzKajrst/+tQIJsIp+IXS4VuKqNbwQynrIe1CcqgMGysL2ruhLY
	vSuP1cysw/Y6NVTpUXklud6Mmb4mmMxlZYJ7/gJxLnU7+IVtB9zoCpgnmew/3AyEOCFUg2RJode
	/aDuKZ9mnt9GQdcMcgFKAwoOQWPuDvxe/mw6cVw08cnDpcPb/+tZ2vxAzxijW43GskWyy5fahnI
	hXTq9phYPK9fqKw==
X-Google-Smtp-Source: AGHT+IHJTH5IXTdhlfHTNlklonReyoT3ZXsvJX9ID9s0cIQoqLFk+sBnhdfnbbBFM7qc+8LKQFWG+A==
X-Received: by 2002:a17:902:cf0f:b0:220:fe51:1aab with SMTP id d9443c01a7336-22977e0fa71mr33414205ad.38.1743671029007;
        Thu, 03 Apr 2025 02:03:49 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e90dsm9421275ad.196.2025.04.03.02.03.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Apr 2025 02:03:48 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] serial: 8250: fix panic due to PSLVERR
Date: Thu,  3 Apr 2025 17:03:36 +0800
Message-Id: <20250403090336.16643-1-cuiyunhui@bytedance.com>
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

In serial8250_do_startup, calling serial_port_out(port, UART_LCR,
UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
Execution proceeds to the dont_test_tx_en label:
...
serial_port_in(port, UART_RX);
This satisfies the PSLVERR trigger condition.

Because another CPU(e.g., using printk) is accessing the UART (UART
is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
(lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().

To resolve this issue, relevant serial_port_out operations should be
placed in a critical section, and UART_RX data should only be read
when the UART_LSR DR bit is set.

Panic message:
[    0.442336] Oops - unknown exception [#1]
[    0.442337] Modules linked in:
[    0.442339] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.13-00102-gf1f43e345877 #1
[    0.442342] Tainted: [W]=WARN
[    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
[    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
[    0.442354] epc : ffffffff8064efca ra : ffffffff8064af28 sp : ffff8f8000103990
[    0.442355]  gp : ffffffff815bad28 tp : ffffaf807e36d400 t0 : ffffaf80804cf080
[    0.442356]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffff8f80001039a0
[    0.442358]  s1 : ffffffff81626fc0 a0 : ffffffff81626fc0 a1 : 0000000000000000
[    0.442359]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffff81626fc0
[    0.442360]  a5 : ffff8f800012d900 a6 : 000000000000000f a7 : 000000000fc648c1
[    0.442361]  s2 : 0000000000000000 s3 : 0000000200000022 s4 : 0000000000000000
[    0.442362]  s5 : ffffffff81626fc0 s6 : ffffaf8085227000 s7 : ffffffff81073c58
[    0.442363]  s8 : 0000000000500000 s9 : ffffaf80851a5a60 s10: ffffaf80851a5a60
[    0.442365]  s11: ffffffff80e85980 t3 : ffffaf807e324600 t4 : 0000000000000002
[    0.442365]  t5 : 0000000000000003 t6 : ffffaf80804cf072
[    0.442366] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000013
[    0.442368] [<ffffffff8064efca>] dw8250_serial_in32+0x1e/0x4a
[    0.442371] [<ffffffff8064af28>] serial8250_do_startup+0x2c8/0x88e
[    0.442373] [<ffffffff8064b514>] serial8250_startup+0x26/0x2e
[    0.442375] [<ffffffff806428a2>] uart_startup+0x13a/0x308
[    0.442377] [<ffffffff80642aa4>] uart_port_activate+0x34/0x50
[    0.442378] [<ffffffff8062ab6a>] tty_port_open+0xb4/0x110
[    0.442383] [<ffffffff8063f548>] uart_open+0x22/0x36
[    0.442389] [<ffffffff806234b4>] tty_open+0x1be/0x5e6
[    0.442396] [<ffffffff802f2d52>] chrdev_open+0x10a/0x2a8
[    0.442400] [<ffffffff802e7ab6>] do_dentry_open+0xf6/0x34e
[    0.442405] [<ffffffff802e9456>] vfs_open+0x2a/0xb4
[    0.442408] [<ffffffff80300124>] path_openat+0x676/0xf36
[    0.442410] [<ffffffff80300a58>] do_filp_open+0x74/0xfa
[    0.442412] [<ffffffff802e9900>] file_open_name+0x84/0x144
[    0.442414] [<ffffffff802e99f6>] filp_open+0x36/0x54
[    0.442416] [<ffffffff80a01232>] console_on_rootfs+0x26/0x70
[    0.442420] [<ffffffff80a0154e>] kernel_init_freeable+0x2d2/0x30e
[    0.442422] [<ffffffff8099c730>] kernel_init+0x2a/0x15e
[    0.442427] [<ffffffff809a7666>] ret_from_fork+0xe/0x1c
[    0.442430] Code: e022 e406 0800 4683 0c15 691c 872a 96bb 00d5 97b6 (439c) 851b
[    0.442432] ---[ end trace 0000000000000000 ]---
[    0.442434] Kernel panic - not syncing: Fatal exception in interrupt
[    0.442435] SMP: stopping secondary CPUs
[    0.451111] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250_port.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3f256e96c722..6909c81109db 100644
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
 
@@ -2380,9 +2383,9 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
+	uart_port_lock_irqsave(port, &flags);
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	uart_port_lock_irqsave(port, &flags);
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
@@ -2435,8 +2438,9 @@ int serial8250_do_startup(struct uart_port *port)
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
-- 
2.39.2

