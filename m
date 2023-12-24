Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24493FE6
	for <linux-serial@vger.kernel.org>; Sun, 24 Dec 2023 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rT/njjHl"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d5473882aso5059415e9.1
        for <linux-serial@vger.kernel.org>; Sun, 24 Dec 2023 05:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703423526; x=1704028326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWTZ2Sa9HaAdVOS8JszMBrVk7S9FMz/EGRcmeM4FejM=;
        b=rT/njjHlpmRtKaRPIIiItf7RnFvINtFLz4eU7jTCegKDbajXlrTXcTMLNRz7aHDqQk
         uPWU5xzMXwHujP9tAinbjfjg5UgBo02sTw42vmpo1o3uI1fZo2NpwEk2sC2ocI8Wtbxm
         +jei8PLoHHQglTYO6xAqHafIcO7xYVfditJhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703423526; x=1704028326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWTZ2Sa9HaAdVOS8JszMBrVk7S9FMz/EGRcmeM4FejM=;
        b=mqIORCyMKQxyjTzom6GoU5SWrTbxhu4Se+1Gr5t5NVsTrKDjyCD1iETO1MeHgE44aZ
         NbxFcqmp6f3k2t+qwJ8W/QgDP5xUPp8lEv+uuyyBuzTawqdxgEHiFp6TUz9OxfrlM5Y1
         mIQ0fweYf82eNPhrqBEwElT0l3URdiDIYlUmaBZbQ3DzIhGNWJ0kGrg8CmmYpDNl3RgL
         KUfjfKjEl29+MB/ll1Hsp3PO7HmD6/kISYqXGcxRjfw2vjhxG27578YVCaJSF7OoC5Bq
         04DwQJIbj6xwHKahAXjdLdOsRMgSSKySXM3JUqu11tStC8SI/lKT7/nstBmo74fvCyxF
         BJtQ==
X-Gm-Message-State: AOJu0YzceR8cNsqhWeDx8OApmXWriellay8DCbA6EBJEuctFoYUS2XxK
	MfiTsdiFtH0NADG+vlzjD0VcjXVXoSaXag==
X-Google-Smtp-Source: AGHT+IHp/ktMkz0AZUoRhKZmWhT//doTxmCQDDKVOxYizpmOAnDCPfph9YKV1slVH4cyewfqiuCPDg==
X-Received: by 2002:a05:600c:5490:b0:40d:4153:59b with SMTP id iv16-20020a05600c549000b0040d4153059bmr2964155wmb.101.1703423525726;
        Sun, 24 Dec 2023 05:12:05 -0800 (PST)
Received: from panicking.amarulasolutions.com (93-35-133-136.ip55.fastwebnet.it. [93.35.133.136])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b0040d5112fcb8sm4898968wmo.38.2023.12.24.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 05:12:05 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: dianders@chromium.org
Cc: daniel.thompson@linaro.org,
	gregkh@linuxfoundation.org,
	jason.wessel@windriver.com,
	jirislaby@kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	michael@amarulasolutions.com
Subject: [PATCH V3] tty: serial: kgdboc: Fix 8250_* kgdb over serial
Date: Sun, 24 Dec 2023 14:12:00 +0100
Message-Id: <20231224131200.266224-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAD=FV=VaDJSXt5kyfzZ=qv9ZHRNerHFs7izXZbgudvfcOThc_Q@mail.gmail.com>
References: <CAD=FV=VaDJSXt5kyfzZ=qv9ZHRNerHFs7izXZbgudvfcOThc_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if port type is not PORT_UNKNOWN during poll_init.
The kgdboc calls the tty_find_polling_driver that check
if the serial is able to use poll_init. The poll_init calls
the uart uart_poll_init that try to configure the uart with the
selected boot parameters. The uart must be ready before setting
parameters. Seems that PORT_UNKNOWN is already used by other
functions in serial_core to detect uart status, so use the same
to avoid to use it in invalid state.

The crash happen for instance in am62x architecture where the 8250
register the platform driver after the 8250 core is initialized.

Follow the report crash coming from KGDB

Thread 2 received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1]
_outb (addr=<optimized out>, value=<optimized out>) at ./include/asm-generic/io.h:584
584		__raw_writeb(value, PCI_IOBASE + addr);
(gdb) bt

This section of the code is too early because in this case
the omap serial is not probed

Thread 2 received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1]
_outb (addr=<optimized out>, value=<optimized out>) at ./include/asm-generic/io.h:584
584		__raw_writeb(value, PCI_IOBASE + addr);
(gdb) bt

Thread 2 received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1]
_outb (addr=<optimized out>, value=<optimized out>) at ./include/asm-generic/io.h:584
584		__raw_writeb(value, PCI_IOBASE + addr);
(gdb) bt
0  _outb (addr=<optimized out>, value=<optimized out>) at ./include/asm-generic/io.h:584
1  logic_outb (value=0 '\000', addr=18446739675637874689) at lib/logic_pio.c:299
2  0xffff80008082dfcc in io_serial_out (p=0x0, offset=16760830, value=0) at drivers/tty/serial/8250/8250_port.c:416
3  0xffff80008082fe34 in serial_port_out (value=<optimized out>, offset=<optimized out>, up=<optimized out>)
    at ./include/linux/serial_core.h:677
4  serial8250_do_set_termios (port=0xffff8000828ee940 <serial8250_ports+1568>, termios=0xffff80008292b93c, old=0x0)
    at drivers/tty/serial/8250/8250_port.c:2860
5  0xffff800080830064 in serial8250_set_termios (port=0xfffffbfffe800000, termios=0xffbffe, old=0x0)
    at drivers/tty/serial/8250/8250_port.c:2912
6  0xffff80008082571c in uart_set_options (port=0xffff8000828ee940 <serial8250_ports+1568>, co=0x0, baud=115200, parity=110, bits=8, flow=110)
    at drivers/tty/serial/serial_core.c:2285
7  0xffff800080828434 in uart_poll_init (driver=0xfffffbfffe800000, line=16760830, options=0xffff8000828f7506 <config+6> "115200n8")
    at drivers/tty/serial/serial_core.c:2656
8  0xffff800080801690 in tty_find_polling_driver (name=0xffff8000828f7500 <config> "ttyS2,115200n8", line=0xffff80008292ba90)
    at drivers/tty/tty_io.c:410
9  0xffff80008086c0b0 in configure_kgdboc () at drivers/tty/serial/kgdboc.c:194
10 0xffff80008086c1ec in kgdboc_probe (pdev=0xfffffbfffe800000) at drivers/tty/serial/kgdboc.c:249
11 0xffff8000808b399c in platform_probe (_dev=0xffff000000ebb810) at drivers/base/platform.c:1404
12 0xffff8000808b0b44 in call_driver_probe (drv=<optimized out>, dev=<optimized out>) at drivers/base/dd.c:579
13 really_probe (dev=0xffff000000ebb810, drv=0xffff80008277f138 <kgdboc_platform_driver+48>) at drivers/base/dd.c:658
14 0xffff8000808b0d2c in __driver_probe_device (drv=0xffff80008277f138 <kgdboc_platform_driver+48>, dev=0xffff000000ebb810)
    at drivers/base/dd.c:800
15 0xffff8000808b0eb8 in driver_probe_device (drv=0xfffffbfffe800000, dev=0xffff000000ebb810) at drivers/base/dd.c:830
16 0xffff8000808b0ff4 in __device_attach_driver (drv=0xffff80008277f138 <kgdboc_platform_driver+48>, _data=0xffff80008292bc48)
    at drivers/base/dd.c:958
17 0xffff8000808ae970 in bus_for_each_drv (bus=0xfffffbfffe800000, start=0x0, data=0xffff80008292bc48,
    fn=0xffff8000808b0f3c <__device_attach_driver>) at drivers/base/bus.c:457
18 0xffff8000808b1408 in __device_attach (dev=0xffff000000ebb810, allow_async=true) at drivers/base/dd.c:1030
19 0xffff8000808b16d8 in device_initial_probe (dev=0xfffffbfffe800000) at drivers/base/dd.c:1079
20 0xffff8000808af9f4 in bus_probe_device (dev=0xffff000000ebb810) at drivers/base/bus.c:532
21 0xffff8000808ac77c in device_add (dev=0xfffffbfffe800000) at drivers/base/core.c:3625
22 0xffff8000808b3428 in platform_device_add (pdev=0xffff000000ebb800) at drivers/base/platform.c:716
23 0xffff800081b5dc0c in init_kgdboc () at drivers/tty/serial/kgdboc.c:292
24 0xffff800080014db0 in do_one_initcall (fn=0xffff800081b5dba4 <init_kgdboc>) at init/main.c:1236
25 0xffff800081b0114c in do_initcall_level (command_line=<optimized out>, level=<optimized out>) at init/main.c:1298
26 do_initcalls () at init/main.c:1314
27 do_basic_setup () at init/main.c:1333
28 kernel_init_freeable () at init/main.c:1551
29 0xffff8000810271ec in kernel_init (unused=0xfffffbfffe800000) at init/main.c:1441
30 0xffff800080015e80 in ret_from_fork () at arch/arm64/kernel/entry.S:857

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
v2 -> v3:
	- add reviewed-by
	- fix  {SUBJECT} "kgdb over serial" instead of "kgd over serial"
	- split long lines in 2 lines
v1 -> v2:
        - fix if condition during submission
        - improve a bit the commit message
RFC -> v1:
        - refuse uart that has type PORT_UNKNOWN
---
 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f1348a509552..497be381c647 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2633,7 +2633,8 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 	mutex_lock(&tport->mutex);
 
 	port = uart_port_check(state);
-	if (!port || !(port->ops->poll_get_char && port->ops->poll_put_char)) {
+	if (!port || port->type == PORT_UNKNOWN ||
+	    !(port->ops->poll_get_char && port->ops->poll_put_char)) {
 		ret = -1;
 		goto out;
 	}
-- 
2.40.1

