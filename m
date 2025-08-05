Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD323FBB3;
	Tue,  5 Aug 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423498; cv=none; b=BFK7jbRmukEEQihICmPMu+b6MGqTXcYm5J8xbj4u/bP54qGIo4nmfiRjimLJCgPKbsYQOr987w0WUbxZaTYRWPFXeYG+DV/pE8G5q2NZQZRP61XESjprQVH4ov7WaIQmbwpzIsZ9vm+AqY4qHb9OnTWEyhusF86hra+8dELd8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423498; c=relaxed/simple;
	bh=3aFqBsM6mN5uu+1G1WaVaon7DG3vAbe7Eir3PTlYMk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dHeemPdKuaYmNKVxi9JsBPx/8uW9awXxbeF/N9+2v+WeCTt5yHcvb4oOC3I53jidSCFqLaktWDJ1GUN9acsj1gAZ+rZZhsvFmBPQuGOSirEChQq8hzdW7/6XXrqmkyKkk+yPzNkFQRFmlSrPNfbm3lfaoDZVsEM4c3GOiI1DwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+4M1yQw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+4M1yQw"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74264d1832eso5627868b3a.0;
        Tue, 05 Aug 2025 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754423496; x=1755028296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tybD8dvj3BrHV4ZA0++FRr8ip0ElrmI1dhTrw4vCNaI=;
        b=f+4M1yQwsbWmVap1weJoApmcxDh5RgYAXzoNlVZFW8dteKXyKARElzWUrJr+pMlgDF
         uM7NAtQ8eVOEIDgWqWU1BRB4RViGwNUHKlWJ3cdiy/nYaCLOnjf9rid1VDYJQKf1yHlm
         7Ex1L1dcn09flZG0qcFL8gAQEJUdSctvhcg1sS82VnOPGjgZMI+z4zwl3xKQMi+3J4B7
         URAqaxsh0R53c8TSWAXT9w3xRywHXo5Rwmg0yH5WCNqcdE3lw6jwGoVgbjdjSodF00w9
         mEut9DuLffOPYpYNoNoOKrC+frVYfT5V4touL6FNbu7lX82kotqparqSm/88bxgmjk8o
         LnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754423496; x=1755028296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tybD8dvj3BrHV4ZA0++FRr8ip0ElrmI1dhTrw4vCNaI=;
        b=GS479ZZnrQ2vmhK9S0HQEYoEoJlU0+0l5vpatbiHdRcDXvdzSwMhg8D8CR4IJluBhU
         sf0/dCkiifPfmh7QBks6jEWL8MBsErAQcRt/kjAAyrZxCSxlr8aPw4PmGVLAnBK0FSHf
         LLl7x+DUCG3wm1vcKENHxdg3D/IlWfISM/NYyp+vlyXgkdxQ5m4o3I0iHmneBT6TtwzT
         QpP2sv/89Y7LuJwvNPRRtpcgx9TXcSdj7yFmkF8+EGVfYd6u6ne7rwl1HLYmAXrPAiBV
         t4+ULhOXCNzK1AcCu69bs5rtIlay3dCcwQJx53ee+rxj+GqlQLp27qrCf6uy8aG4F8IU
         TYYg==
X-Forwarded-Encrypted: i=1; AJvYcCXAJAuIzk33ggSXqr3D2it2muwND4ZKHJgFYhx310o765P2kB5SNtsFNYOqFjw55HErbH9GaQBlLggMwkc=@vger.kernel.org, AJvYcCXuCq38hG9DwOyN/gScV45osZdLYwAwAlPw2Wq/uHg5ApD3aCgRNAaPfmVmLapRR29HB3gfKmMV81ESXi1N@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSpoJBab4WeMrNLlTM1TEncA6MuqA1j2NukM20dc3IyUj73FV
	4+oEq7VQEtQKIV1BG3KkcQ83iT4oPzFWqQrJ8kuYFX+yDu/0cqn8vcDL76Mo26TIH7k=
X-Gm-Gg: ASbGncu0hAhHeR8ZhW6EJriD7/FcrUya8TSDx0RveR7sM4sSooTE5DCmLoX11e80Iig
	Jlxg0Hhkojaku7gtBXJR5akK2286rPSCTkFNTxMQlz6Qas4+c42k17JjMitJv7Y96q4k+dcqKDS
	GGW3dF5v49LV7iQr8D4ex3F78yemnpiobGgKrp1nUNL1nBxfFzXyZ0AYPUNcgwyTkMgOrz6z+M+
	x3/Fol1y7runSzviTTYY8KDuSaD608fUWxiBtVhKJVuppQyFtHYs89Agcgq754kD08Zz3AB4Keu
	l9MQMD9/Qrgz4C6Y1eSNGpBbEw6yK9gGT5iMKdYxJYiugbSxPvAPYxH45Do983rCX5uNThbirXK
	9eBx0vlTtQwiW6NQt3t6hJiu+7+wFWkej
X-Google-Smtp-Source: AGHT+IHShzSvmgznm+V5oYi4OS4D6N3iRPuQfIj5sYhBlHvzTYOa8eyC3iXkIC/IGnMWMyQfnD/lqA==
X-Received: by 2002:a05:6a20:3ca1:b0:240:dc9:71cf with SMTP id adf61e73a8af0-240314fb2f7mr456804637.38.1754423496200;
        Tue, 05 Aug 2025 12:51:36 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm13744397b3a.18.2025.08.05.12.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:51:35 -0700 (PDT)
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
Subject: [RFC PATCH 1/2] tty: serial/8250: Fix build warning in serial8250_probe_acpi()
Date: Wed,  6 Aug 2025 01:21:54 +0530
Message-ID: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
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
    `uart` structure using kmalloc(), rather than placing it on
    the stack. This eliminates the overflow warning and improves kernel
    robustness.

Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
The stack usage was further confirmed by using -fstack-usage flag.
it was using 1200 bytes:
..............................
drivers/tty/serial/8250/8250_platform.c:110:12:serial8250_probe_acpi	1200	static
drivers/tty/serial/8250/8250_platform.c:351:20:serial8250_exit	16	static
......................................
After applying the patch it becomes :
.........
It doesn't show up in stack usage  and warning is fixed.
.......
This function is used for probing . So dynamic allocation will not create
any issues.

Thank You
---
 drivers/tty/serial/8250/8250_platform.c | 29 +++++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index c0343bfb8064..f7f9c5036d39 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -15,7 +15,7 @@
 #include <linux/moduleparam.h>
 #include <linux/once.h>
 #include <linux/platform_device.h>
-
+#include <linux/cleanup.h>
 #include <linux/serial_8250.h>
 
 #ifdef CONFIG_SPARC
@@ -110,41 +110,46 @@ void __init serial8250_isa_init_ports(void)
 static int serial8250_probe_acpi(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port uart = { };
+	struct uart_8250_port *uart __free(kfree) = NULL;
 	struct resource *regs;
 	int ret, line;
 
+	uart = kmalloc(sizeof(*uart), GFP_KERNEL);
+	if (!uart)
+		return -ENOMEM;
+	memset(uart, 0, sizeof(*uart));
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

