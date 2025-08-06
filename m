Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D32D0C60;
	Wed,  6 Aug 2025 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511037; cv=none; b=kxeKogF7S4U3KKvztRZiZTlDXNvuZ13LFGxEthsrL24l2QNTOMYNBg3GxmQRQe/wyor7H8spcnCvDVj0uXFywhymuAuWBFMUHOdz9jqQdNsoZpl53RmThnpP1i2HkzDpl/puMhdyWKGgHjYYrTdyN7UjyQwqPFNvHSWYjhofnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511037; c=relaxed/simple;
	bh=CsiX3LpbUBnihaw/xRlWgknthecZaoYlBgQAkUpiN98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXuCGeFvFbHOQqIkXuwpdcha2CRq9oUnY71CvZRZABQ9NRMqxtswaw2xE7f5FLIlBJhss2rGOnvlWDWFgXa51UK4ZbywtnM0w7UnHz99TwXllmZdZO6uQlc6P+nCsECQnbGo2IiiOXhn8ODPFH+q7lhZDj7nqvPGjuSPArA2z+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpBPQYaB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpBPQYaB"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bc55f6612so315717b3a.0;
        Wed, 06 Aug 2025 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754511035; x=1755115835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vucDMCt9anlq6y49qlrTW01EnOmxreRERlAc3t5nE5s=;
        b=VpBPQYaBSxtFjrPrSBPhgKUTsEgp3X9fYTKI7ypTRPsrPEAQuhjkWlf/LNFcjFY8T8
         lUziqfyf31/AyzOJXjlcHD28EvY8qBTO+ZE3p4PFUEDqw8IK7p5udU6LPSdr0w7VPowi
         +69fz15pi62eLvgjHmMf/qHZBDLmXA/Fsf7QYY7nvyZqa1cAmCOH88OzOOvTg9SyEjhH
         PFxTpN6ShHwWIZNGeJAegY2nnH6DZvsu2EqB8kbrYzPc0HNv/lXSbqWVla+EzbAfGn5q
         F7KQqLzIPyZDTmXKEouKFibxfgBoigpK4w+z+3cVA0mf2LA+cajJjUeNXgRNfB6Bz017
         STow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511035; x=1755115835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vucDMCt9anlq6y49qlrTW01EnOmxreRERlAc3t5nE5s=;
        b=waJdEwDsLXb7vSWKNcqQqK9KmATttMs0CPcE4lhfwLbnt11F7nnDRN6PzVlVIprS/L
         h5vRomAAgMEcoCFjfEa0r//hW3JHSI2A2dSy7OSDgpnq2ApJN9kxzjnTd12dmeRB73Ga
         76ItsUeTjF98txc/HZsoEFOTFG+gtiOe3AlsrBTffzFmvR1GZXlp4Kv0Qdg53uGuDT8k
         xuz9m2yU8KlM97TugkTU03Tig3MF3p/6EOSeJX9OSmsDPZ7lHgyaH6IPpwB05w+dXqHo
         wnGEIyQxiXCeETJ6baUva/yCa3Tr7ve1x+g5ucOEKep0kdEYdSxu5nwMab9ri0+sP9tK
         kjcw==
X-Forwarded-Encrypted: i=1; AJvYcCUeA9VWu3OomZTW6Iu6TGzzLjTf+aaotLOhjZE404vyGPuMmbPuon/5pf94ejw+xdCAW0tWRW8i07gYF/z+@vger.kernel.org, AJvYcCV1g0sfsMa7iJhcCJc7q4tO58yUkmmsboY/c9n18P1bdY2sEMBOWBff3Evgm1+L56TpQZBMLFqHTuvn6PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6+HsQk/hfCs8I1gHFG+ermdgRb4t0Pntqvrt7TAK/WKuNGPI
	SaBs7JLs50fFbe8BxBNjHUuEWez4wAV6TP4FLVMtS99wq/O271cB/Yid
X-Gm-Gg: ASbGncsWkoKbg71o5QKzUup2i85X155jQrPDompKMsL7xhMyESN0Me08PAabjCyIrTp
	fwqPgVeVe1pvyAXjc2oqXstlgzYMqgDvwz9SRVh0S0fpxySRjlJOQ5PmMEMxMIMnboHbO4XdBxE
	7gEl0G3eywA22kpG2PBLSHgyzUaX4p4NF7WDEJce3TL1QonJZJ1ONXlnqDaEtrm3uBdeQhmwClg
	XMw6aPjWoWSBjU9Se3fMtIHH8AhCBPfmAyUzMsGQdEXvO1+YVW0TccaPl7ElhVNsMa7kK0Ag3uT
	oDZOJ5QsiDo8LHD9aYR/dDMhe+UsyIxDusfWE0UEpfEWjoxahoAtzd2uE5EnG5evpUv2PPQV5fY
	H11/EvCfS/eqBbOoCTfv8bfUjN2NJIaCMDzWEAMjRFLk=
X-Google-Smtp-Source: AGHT+IFbR83uHiKT31m9Kk4PEXh0UA57R0vzVHjqcNFGdj8vzgKpGIwLn4vsIZVbCuMILZ7cjMnFIw==
X-Received: by 2002:a05:6a00:8590:b0:746:25d1:b712 with SMTP id d2e1a72fcca58-76c372e2c76mr1053974b3a.7.1754511035327;
        Wed, 06 Aug 2025 13:10:35 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c397b87d5sm38882b3a.96.2025.08.06.13.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:10:34 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: abinashsinghlalotra@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	sunilvl@ventanamicro.com,
	u.kleine-koenig@baylibre.com
Subject: [PATCH v2 2/2] serial: 8250_platform: Reduce stack usage in serial8250_probe_platform()
Date: Thu,  7 Aug 2025 01:40:47 +0530
Message-ID: <20250806201047.754240-3-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806201047.754240-1-abinashsinghlalotra@gmail.com>
References: <aJKDp1LBpzswp5lX@smile.fi.intel.com>
 <20250806201047.754240-1-abinashsinghlalotra@gmail.com>
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
`uart` structure using kzalloc(), rather than placing it on
the stack. This eliminates the overflow warning and improves kernel
robustness.

Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
 drivers/tty/serial/8250/8250_platform.c | 61 +++++++++++++------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 50cec2413aeb..0baedc7ff6e9 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -157,43 +157,44 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 
 static int serial8250_probe_platform(struct platform_device *dev, struct plat_serial8250_port *p)
 {
-	struct uart_8250_port uart;
 	int ret, i, irqflag = 0;
+	struct uart_8250_port *uart = kzalloc(sizeof(*uart), GFP_KERNEL);
 
-	memset(&uart, 0, sizeof(uart));
+	if (!uart)
+		return -ENOMEM;
 
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

