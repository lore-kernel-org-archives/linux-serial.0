Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401D230D0D;
	Wed,  6 Aug 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517067; cv=none; b=f4HlyNZ/6O9NGaeMU+08WkfQ4ztE4LE3YwNiR7e445elG6eDxR4+FXqyA+Z6H6vAzHo4g2HbBO+7ONwjr05ZodWTsg7tua84FLQK2zttKUqF9fRKHG9MVF5Xc8/PmwtXfssb4x/tP3BtiXOZLkU1A5dv+JjEvSJZTFG8N5gpVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517067; c=relaxed/simple;
	bh=mZ5NaOmF6p/vifvC9oqrOEoAj8DJT4fkAC3ITsaP2ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLnHY9j8TDny1SaNZhrQMUJtpYk0rtMH61IA/BrL1cWBlt1GnLMQ82lmGiN6ujlYvpuwrThWc8JapgJC1lglaURXjfc38Gei/W6Y2EMKv6OCAnRuSMo1qSRIuNczRSypn6Eu//UK0Rt05p9KphA5uMeAioG9pWlVaZRgxhTSkqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc9i2v/t; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc9i2v/t"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so423298b3a.0;
        Wed, 06 Aug 2025 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754517065; x=1755121865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByxCqwJkEn6LD06bCiaVsvKmS9NUJGLlvaGzvqPGgxo=;
        b=Hc9i2v/t1Dllb1Fdc594eS4Kh91AMB6Wtwr6e/LRHqao55fvL+fZfjN0GJSrhA/Zw7
         Ptdhzd6QvEMgV7Z1sToY91gUQm5Ct1+yxgA6lmYqfmhCrHvTzT8pMkwR+qXq0veFzAxq
         XgiS5jmXWuaItwLzBuavn2Qaf6JEwUtADBFEqUkt5M0G78sNknaf/53bLD2s7QL0uz1l
         rh+B6kbWOE0IbqeizZnltNisqbHkO4mu/lULDTeqCPXQ01xhsB3Qrk91hyp2WvLFYp4Q
         fTDYUM5VTbpvPzP18a0QubQmnIkkjdfTwy76Tr9O/CKrXJbky8PcJaiJwBg1hhTlMcn9
         dZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517065; x=1755121865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByxCqwJkEn6LD06bCiaVsvKmS9NUJGLlvaGzvqPGgxo=;
        b=xK7bfhEs+ur+hg5vXmVnZ0Z6U+HAa2ixNcZdul2U13CdtlXfR+Bt4paay6Ibcw+Xgp
         SsdVZkrwBiwyX0mjlRBkLrDAzM3pE/pFmfres58qMyAhmPkgHztqPeuZPo71UMA1sN6h
         4pzOSdcXsQHajcZzeLO3ApDe9u0aCj98W2lj2Qr8MxcnRoPMgWfqZxwbdZcH8Oko10G5
         xp1mazyqu5XuxNh6E4H3Wu9lbpHCgxwSESPu7lxMaRUQdGu4RoacgX2HWTyqXrjwz/xu
         EVEh9PctODMxXYvEyKKs306dmaoSTvvgKmi93zEx986RDQrcuy8kOPFYQJVO3w5TOpiu
         MWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkx5x3HHaDjHypXY8Z+nK1fXbl30xwLbMFrOaJ/ZbZ5XA/M5i/PVRicmfjGPDeMyBdl62HCsuy4z6m6vvC@vger.kernel.org, AJvYcCWF5qAnUQZCdi9kdLSRaqfQn1P7KiZZDG/DAZVs//7VQWK3tMYXDdm7GkkVBbEKQOHuhh+U+7uoOjt4mC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+Qoeq9pCZ3nR3KBpFJtwKivDzAtalMuYE4+l7x8112PEjhFH
	X+goYOXGnrTzkbBk+vq2ZREbMaw7Vd2+6UZm0OKYGmod80uuv1WL/K64
X-Gm-Gg: ASbGncv9yZmpgph65AgqlS8GLl9sSD3zBy8w7Y4a3VY/xj+m13rZGXMleKfzU17VEGY
	6vvBGL62t1SFwARdYOJqYSKMT1oNjxaJXegRFOFa1PfdvjWoogjAzVvjogyABZokzKa9CrOiS4n
	Eh23jdt4HNy2IUPDo9+OhXdCoVubGqqOc2Sr0NjpOUjgXd8ov0FIZ/hfDZgZgeqJ28lfZlyn3pr
	INkiXJq3OvCI5Roj5sCnKqwQZcE7dW0Cybqar+Xa/2S3OOSy63qTOBoyqTCUsdroQ59x7eZ2JCN
	4Oy+fmnui+LygrR/iZaQNjJzWSMy+Kn5oataMXRqQYWbYmyWJ5VHhFEMI6HD1humUtYWFXDjapd
	o4Avxx5aPRJ5/hPlJARaiDxZ838t8CoyxIL8Wj8iDxl4=
X-Google-Smtp-Source: AGHT+IEjS0HvIie6wLWDOmihYKJ02fpMlaUQKsKl/a6CVJoAczvJ0u/WizJPtds9oQDMhTEqFGlPhA==
X-Received: by 2002:a05:6a00:18a8:b0:76b:e936:607 with SMTP id d2e1a72fcca58-76c29b2b12fmr5601048b3a.0.1754517064731;
        Wed, 06 Aug 2025 14:51:04 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8911asm16252258b3a.36.2025.08.06.14.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:51:04 -0700 (PDT)
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
Subject: [PATCH v3 1/2] serial: 8250_platform: Reduce stack usage in serial8250_probe_acpi()
Date: Thu,  7 Aug 2025 03:21:33 +0530
Message-ID: <20250806215134.4921-2-abinashsinghlalotra@gmail.com>
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

The function serial8250_probe_acpi() in 8250_platform.c triggered a
    frame size warning:
drivers/tty/serial/8250/8250_platform.c: In function ‘serial8250_probe_acpi’:
drivers/tty/serial/8250/8250_platform.c:152:1: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This patch reduces the stack usage by dynamically allocating the
`uart` structure using kzalloc(), rather than placing it on
the stack. This eliminates the overflow warning and improves kernel
robustness.

Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
 drivers/tty/serial/8250/8250_platform.c | 26 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index c0343bfb8064..9938aeb917d8 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -10,6 +10,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/array_size.h>
+#include <linux/cleanup.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -110,41 +111,44 @@ void __init serial8250_isa_init_ports(void)
 static int serial8250_probe_acpi(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port uart = { };
 	struct resource *regs;
 	int ret, line;
 
+	struct uart_8250_port *uart __free(kfree) = kzalloc(sizeof(*uart), GFP_KERNEL);
+	if (!uart)
+		return -ENOMEM;
+
 	regs = platform_get_mem_or_io(pdev, 0);
 	if (!regs)
 		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
 	switch (resource_type(regs)) {
 	case IORESOURCE_IO:
-		uart.port.iobase = regs->start;
+		uart->port.iobase = regs->start;
 		break;
 	case IORESOURCE_MEM:
-		uart.port.mapbase = regs->start;
-		uart.port.mapsize = resource_size(regs);
-		uart.port.flags = UPF_IOREMAP;
+		uart->port.mapbase = regs->start;
+		uart->port.mapsize = resource_size(regs);
+		uart->port.flags = UPF_IOREMAP;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* default clock frequency */
-	uart.port.uartclk = 1843200;
-	uart.port.type = PORT_16550A;
-	uart.port.dev = &pdev->dev;
-	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+	uart->port.uartclk = 1843200;
+	uart->port.type = PORT_16550A;
+	uart->port.dev = &pdev->dev;
+	uart->port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 
-	ret = uart_read_and_validate_port_properties(&uart.port);
+	ret = uart_read_and_validate_port_properties(&uart->port);
 	/* no interrupt -> fall back to polling */
 	if (ret == -ENXIO)
 		ret = 0;
 	if (ret)
 		return ret;
 
-	line = serial8250_register_8250_port(&uart);
+	line = serial8250_register_8250_port(uart);
 	if (line < 0)
 		return line;
 
-- 
2.50.1

