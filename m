Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840E22C32D;
	Wed,  6 Aug 2025 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517088; cv=none; b=BI95Wzs6gNVse9KE5UXpUifl3t5t9h194iJKqGfus2sHsWNTJD4rYqjrfLojOD2F/XzN+tsMscULDPUxmMGoQ75v+8aR2x8nx/IATHHiRFjo/g1lDykdwJX9NDkATBo9KpncA6auWHWuC+XCNmI42m51Nwnq2LlP8cUTp40ho18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517088; c=relaxed/simple;
	bh=ueezBJxiEcLZko58BFHUTUcQZIMxe2744O16k3Hklx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ti6SghtarVTo0xpRproV1Nv5p+kvDA3+lzGCqsOmlUSAiWqjIBsM/XgXCPIdUcqqAy7jPXivu0bOGnHl4WtYLx9crVV5vhGk3i0t4/+EAE0M0jLD7PCvjmTVvuA0vRrapbTWnElE6eAV/7NXWkG2Vs9OBDWKgbrclDyyZca5eDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBsXZXbb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBsXZXbb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so452787b3a.2;
        Wed, 06 Aug 2025 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754517086; x=1755121886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUAMmDH3TUpKHCQOIz+sxh3moL+ynvF9d1SPXfB+dDs=;
        b=FBsXZXbbjdeKEbnIv9cXK1WzjTBPqOpI2FOJp7yWjPMZATIlETL1rSmp12Fz6kfgNe
         nkswcUOaL8awrhBA3b/Bc4gs2GJq3rFceKLxDQRIUnBngc7jcvu0/pYN1Evw7kqyTs1K
         99pugI+EnN1BDmYANTJrK/DKnA+fm+HJ0FnOJOanpyF7R+OApr3sv7ieoByKVYVat18w
         tkrScCzOoOGjtKU9xp8d9oh4zfhfZs/HVqwlmLhsCFoW+SKCTes+WkocX6zP7MyWpQkV
         CDGeh4cIfh5w8aC1/JJDuwphBGR4vmE6AoCmAzj8ljcFDC2KEKZy8I5b+KR8dvgq2iFl
         EuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517086; x=1755121886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUAMmDH3TUpKHCQOIz+sxh3moL+ynvF9d1SPXfB+dDs=;
        b=ITHDrH+TgNpyVksbFawWsz4+t2n0afehiFy4uvRUe1txFn1ybR90GkHz1OUJlKjIQG
         MBMZGTib4VfDlGtT+RMbaSyqAetXOGrc/zIFl4Xj/7xuolWzYFu3wwIDqXaJ/VZrxc7J
         PnWZJqgDjJu9vhDx/oEToGdSqUsP8e3Mh2U7xoSCeYU/FQTLRIiKX0oaSYNdZM9tEsZr
         dJXXDeqFInXZtD0ZpCNnMDnxMrg8/e8JxW0wcBmNnxJrJXp8gDwWKadXLoC1vDsj7SRD
         S5aD30u62gDceXJJJqMY6uMgS5/iRDTbDYok46iKAYhkTIw0rclfls9gS324pB2w+mEq
         ArHA==
X-Forwarded-Encrypted: i=1; AJvYcCU0QPldU5e0EdG8ctRW6MR8SFait6yDGjUtNq78vpGaZXjaKFt9sxkQ9IeYPx7FVae1raBm+XRsO00dVw4=@vger.kernel.org, AJvYcCUGACoFTWDeFVxe7Jx6mVyz9QaZKhAfgq46+RqUnZTSlOPxraeEu92bINTM1touHIytmECyS8OPIfay1ki/@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5zte6iYFtef15lqpKHme3DrC9ivwwC+/qnw2XFJsQryECRgH
	6y9Dz9pZKcr4VBgiaH096/YG+bGY/MNIAPvPkBkHg75owTssmqpk6r1/
X-Gm-Gg: ASbGncua2Co5vamBmE9jpGTPGlwEtNpTxbCrLQ02IScYLtuvMNaGDXLdSDGXFvuDsu2
	mdE2WRhTtupT+b5Uk5gfe7dcAVD83wMeoQmE3z/7rf4XQSyyRhUFv22lTIkjy0bnursQpnYZOH1
	zdBR4uLLGLVkEeshTgHWRORM77hsPUZz2+wnzexJJe5Lh7UbR6WNLZ7lMPrvmpBtVai/tQfVHgu
	As6Nja/TANz9XmM1AA4z56EFZ7Jkng2XDHC59MxHpTB19AxhR1V39YcF/UhAPgdrlY2ElSaeciq
	mUX4S6FIFIy+TO7HW1AZXGXElmRrV6AxY5l5JePWXxQZ13Xtwdkp9vFEaP4ZGmqGXLoJke2B+k4
	7cU0iG9nkMCMtSR0S4vt3h5yRh+UPWdvR/10p+h5gG6w=
X-Google-Smtp-Source: AGHT+IFMNR1ZxmTgLulP7ip52oXMzytv6X6Yg2yBqWCn0opIOfanZsaEfU1seHVbYGLqjMe42cwJBw==
X-Received: by 2002:a05:6300:8045:b0:240:43e9:6cb7 with SMTP id adf61e73a8af0-24043e97001mr381186637.45.1754517086016;
        Wed, 06 Aug 2025 14:51:26 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8911asm16252258b3a.36.2025.08.06.14.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:51:25 -0700 (PDT)
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
Subject: [PATCH v3 2/2] serial: 8250_platform: Reduce stack usage in serial8250_probe_platform()
Date: Thu,  7 Aug 2025 03:21:34 +0530
Message-ID: <20250806215134.4921-3-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806215134.4921-1-abinashsinghlalotra@gmail.com>
References: <aJO9fnbydWqu1RpJ@smile.fi.intel.com>
 <20250806215134.4921-1-abinashsinghlalotra@gmail.com>
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
index 9938aeb917d8..b27981340e76 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -157,43 +157,44 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 
 static int serial8250_probe_platform(struct platform_device *dev, struct plat_serial8250_port *p)
 {
-	struct uart_8250_port uart;
 	int ret, i, irqflag = 0;
 
-	memset(&uart, 0, sizeof(uart));
+	struct uart_8250_port *uart __free(kfree) = kzalloc(sizeof(*uart), GFP_KERNEL);
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

