Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52554258CDC;
	Tue,  5 Aug 2025 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423518; cv=none; b=CdvnOmn5xVOwdJg9Avtm/3aIe03P4/YpRWbvmmPttNx2YU3yNQVeR1qMrmYwlucxcq68V+WCDpUqF1BAggKSzJV54mwYURKK/70y/z2g3ttdynikU+5ToRgljCDCr/FSfMLzzZ+EMe1wDnNey3GsY8Y63BYA4N9fXWvl2tmoA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423518; c=relaxed/simple;
	bh=WKskQjnDuPRfZGq6aVAzNHj7TdUGFaEOiESvhCgPCsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7ryEmif4hZ0Ur9dW5y6H2QKafR2xP0vyUA0J3zvCqO1TzEH7uxvonKtS7wc2P7/V5pKtjheh6wuBByiyHLJDuuCaumlZ9Q512dErFB1sZIfNvy8R5lCe4v1dmyyxXCnUUVPnw5JYU3SCuD6fcwYR5YthP5dkhFV8bi7KVC5lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcQreted; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcQreted"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76c18568e5eso1895192b3a.1;
        Tue, 05 Aug 2025 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754423516; x=1755028316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02zt95JSIZhvyc1m6kLzXG+cJqDtwABL9QPxGxdLnW4=;
        b=HcQreted7a+CgPX8el4RRDuiwM1uzpgD1KS9NajOL8CIw9Sm6A2N3mkrIWaL6sZLNn
         HXU7oy+TzjZPDX0Dq2JLHi7zJy5Ds3vnVvk4v2q7RoC7HE0lDZ24l5N8icqrM/OhT8S3
         gQmk/NhTfFdceRUXBQgUG6aPF+Y4LyuN5A3P/ic+wjW/CI1swTS7bR5DgDVdLwYCgORT
         isqZSDmCW863J70iPKuoLQso6K1u4fDZCcxZHq4c40eQxuNlMQnljPCGWKvUDakUjO4p
         QTTEFotmeIVv14FnXtkKTAsJEfQYxfXOqwA4bgBQp8STA4hN0bJStB55N4akoHZvB1M8
         P1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754423516; x=1755028316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02zt95JSIZhvyc1m6kLzXG+cJqDtwABL9QPxGxdLnW4=;
        b=jcmpSj+hNWhMkkBJAKQid1onuG2+a7Fmmhlqy9rHIN/Q6P2LFyLpvYBR+9IpFjifMv
         0LhNTzoPLoxP2SuCDxk8TbDTFf1XJa1Dd9+FddU4lBIy/rOZx5fC7bRKh/vr3pKnZpB/
         DG1loTVMlgolYcBZWFTnOlbM/1HsLz6MYoKoqNjgToAjznZZ552ah1XgGTMHGFXF0w7p
         dvFQQF6tI/U9QC/bS7qkD0+oKGWiqkvFEwx1hXQWRXkmfzAsPvM5UAzuiey96NS0i3Oo
         wEgRX2N2JA3FauL3K9KC2M3bXnHauo67DX4WU0xQKRRj8PSWxpbA1VDrR3a4N47WXYCj
         tq/A==
X-Forwarded-Encrypted: i=1; AJvYcCXpH4bNx7QqOKznPeHzAQda8B/hFxizMv0UZL8szH3jln8ACiVC/BpSzu2x+DUkrILRDAQ+CSUKJB00tQc=@vger.kernel.org, AJvYcCXvMKAQU8yKfXP7DHj6rMSci2qfbgPAXb6/Snmva6sINM9qJZQmtOwCyqIa7xLF4YIAUAw54V6NlqyENgv7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kgfooIPV4UuxfkGj0GaQWCIqvQw/LMpSAVrC+nPSANFTDJ4K
	u2PQ4d2wjO3lX8a7u90J3o0yewUypOEow/fg9yvzE9EH9GaTodBG+I8ayr9jM0zrdM0=
X-Gm-Gg: ASbGncsC2cFGQMH5ySQhiIhImA+wocUXZHUtQrbT2tZK7xmaKJSkknRS5wpdy+j77Sz
	fpD7xd6h+4lS/ulLFvIX9Q+Y0sIj32+Dp7hcdsvt2kIfoYKBwA01m49sctnDrq2wVWQosk6TTbf
	Iv6g/acfIAMikpuXfnIpFpLVFAS6HZObNyoeTHg7HMsG9Ql+BVLsuj0QJlSRdEqXcEGQOOsqJXd
	uhkkiyO5gRdaNCxWsGPwRFMmaz14dt4SLSQaOzA0sdSr6Kyklx3bcRfS+Tg3AQCmhP7VzKXZpyx
	C9meB0y+gSDvBB6SZ/Y7bnw9Nu2DG/htzNeO14bBp3c9rA2/uWs+oxI1ke3i13DMtjyjNr9ALGw
	sySAejxE8kzBEZaxQ2IlWAY9tIl+rsWx2
X-Google-Smtp-Source: AGHT+IFHc4vG1G/T3XZna5tCJg244PSDXuBclEDuuVzt0iPu7zCV172SLYMKl1Jsz+zFxybtnXKAkw==
X-Received: by 2002:a05:6a00:2d11:b0:76b:e0d7:c3cf with SMTP id d2e1a72fcca58-76c2a12c06fmr114050b3a.4.1754423516568;
        Tue, 05 Aug 2025 12:51:56 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm13744397b3a.18.2025.08.05.12.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:51:56 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	sunilvl@ventanamicro.com,
	arnd@arndb.de,
	u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	abinashsinghlalotra@gmail.com
Subject: [RFC PATCH 2/2]  tty: serial/8250: Fix build warning in serial8250_probe_platform()
Date: Wed,  6 Aug 2025 01:21:55 +0530
Message-ID: <20250805195155.742004-2-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
References: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

    The function serial8250_probe_platform() in 8250_platform.c triggered a
        frame size warning:
    drivers/tty/serial/8250/8250_platform.c: In function ‘serial8250_probe_platform.isra’:
drivers/tty/serial/8250/8250_platform.c:201:1: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This patch reduces the stack usage by dynamically allocating the
`uart` structure using kmalloc(), rather than placing it on
the stack. This eliminates the overflow warning and improves kernel
robustness.

Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
The stack usage was further confirmed by using -fstack-usage flag.
it was usiing 1248 bytes:
..............................
drivers/tty/serial/8250/8250_platform.c:154:12:serial8250_probe_platform.isra	1248	dynamic,bounded
drivers/tty/serial/8250/8250_platform.c:208:12:serial8250_probe	16	static
......................................
After applying the patch it becomes :
.........
It doesn't show up in stack usage  and warning is fixed.
.......
This function is used for probing . So dynamic allocation will not create
any issues.

Thank You
---
 drivers/tty/serial/8250/8250_platform.c | 63 +++++++++++++------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index f7f9c5036d39..86816d9b32ce 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -158,43 +158,46 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 
 static int serial8250_probe_platform(struct platform_device *dev, struct plat_serial8250_port *p)
 {
-	struct uart_8250_port uart;
+	struct uart_8250_port *uart __free(kfree) = NULL;
 	int ret, i, irqflag = 0;
 
-	memset(&uart, 0, sizeof(uart));
+	uart = kmalloc(sizeof(*uart), GFP_KERNEL);
+	if (!uart)
+		return -ENOMEM;
+	memset(uart, 0, sizeof(*uart));
 
 	if (share_irqs)
 		irqflag = IRQF_SHARED;
 
 	for (i = 0; p && p->flags != 0; p++, i++) {
-		uart.port.iobase	= p->iobase;
-		uart.port.membase	= p->membase;
-		uart.port.irq		= p->irq;
-		uart.port.irqflags	= p->irqflags;
-		uart.port.uartclk	= p->uartclk;
-		uart.port.regshift	= p->regshift;
-		uart.port.iotype	= p->iotype;
-		uart.port.flags		= p->flags;
-		uart.port.mapbase	= p->mapbase;
-		uart.port.mapsize	= p->mapsize;
-		uart.port.hub6		= p->hub6;
-		uart.port.has_sysrq	= p->has_sysrq;
-		uart.port.private_data	= p->private_data;
-		uart.port.type		= p->type;
-		uart.bugs		= p->bugs;
-		uart.port.serial_in	= p->serial_in;
-		uart.port.serial_out	= p->serial_out;
-		uart.dl_read		= p->dl_read;
-		uart.dl_write		= p->dl_write;
-		uart.port.handle_irq	= p->handle_irq;
-		uart.port.handle_break	= p->handle_break;
-		uart.port.set_termios	= p->set_termios;
-		uart.port.set_ldisc	= p->set_ldisc;
-		uart.port.get_mctrl	= p->get_mctrl;
-		uart.port.pm		= p->pm;
-		uart.port.dev		= &dev->dev;
-		uart.port.irqflags	|= irqflag;
-		ret = serial8250_register_8250_port(&uart);
+		uart->port.iobase	= p->iobase;
+		uart->port.membase	= p->membase;
+		uart->port.irq		= p->irq;
+		uart->port.irqflags	= p->irqflags;
+		uart->port.uartclk	= p->uartclk;
+		uart->port.regshift	= p->regshift;
+		uart->port.iotype	= p->iotype;
+		uart->port.flags		= p->flags;
+		uart->port.mapbase	= p->mapbase;
+		uart->port.mapsize	= p->mapsize;
+		uart->port.hub6		= p->hub6;
+		uart->port.has_sysrq	= p->has_sysrq;
+		uart->port.private_data	= p->private_data;
+		uart->port.type		= p->type;
+		uart->bugs		= p->bugs;
+		uart->port.serial_in	= p->serial_in;
+		uart->port.serial_out	= p->serial_out;
+		uart->dl_read		= p->dl_read;
+		uart->dl_write		= p->dl_write;
+		uart->port.handle_irq	= p->handle_irq;
+		uart->port.handle_break	= p->handle_break;
+		uart->port.set_termios	= p->set_termios;
+		uart->port.set_ldisc	= p->set_ldisc;
+		uart->port.get_mctrl	= p->get_mctrl;
+		uart->port.pm		= p->pm;
+		uart->port.dev		= &dev->dev;
+		uart->port.irqflags	|= irqflag;
+		ret = serial8250_register_8250_port(uart);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
 				"(IO%lx MEM%llx IRQ%d): %d\n", i,
-- 
2.50.1

