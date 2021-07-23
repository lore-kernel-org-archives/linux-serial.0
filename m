Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09976C4320E
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D7C60EBD
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhGWHCz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:02:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59064 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhGWHCr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:02:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 60E6E1FF60;
        Fri, 23 Jul 2021 07:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627026200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DW9wHXGIn920h02inTUK5OGEuw+ZnYhjNpBhkTFMVto=;
        b=Ah71VLGtVNcynC3Jqau1eNfmmPwZIjhCM8BEw7jiuSYnzcfKpgSeeFGNLSNoqnUpjzgg3V
        CEsMdtI4YgCgndn5GezJRrHr5FvlYNXewyOSK3UUv0WW+DpTzJAwAWih2a0GPRez/mGGQj
        8ez9EJThLKjVQxhykXu3IrIdX7t05jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627026200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DW9wHXGIn920h02inTUK5OGEuw+ZnYhjNpBhkTFMVto=;
        b=gbR3v70pynvuqyrj2kpW9Kk3vrIW20LK84zztZF6WNbshNtldBnLLDH3j6NS1tUrrMrfyM
        sfQ1ruRrBTEEl2AQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 05BDDA3B87;
        Fri, 23 Jul 2021 07:43:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 4/8] tty: stop using alloc_tty_driver
Date:   Fri, 23 Jul 2021 09:43:13 +0200
Message-Id: <20210723074317.32690-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723074317.32690-1-jslaby@suse.cz>
References: <20210723074317.32690-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

alloc_tty_driver was deprecated by tty_alloc_driver in commit
7f0bc6a68ed9 (TTY: pass flags to alloc_tty_driver) in 2012.

I never got into eliminating alloc_tty_driver until now. So we still
have two functions for allocating drivers which might be confusing. So
get rid of alloc_tty_driver uses to eliminate it for good in the next
patch.

Note we need to switch return value checking as tty_alloc_driver uses
ERR_PTR. And flags are now a parameter of tty_alloc_driver.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Richard Henderson <rth@twiddle.net>(odd fixer:ALPHA PORT)
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
---
 arch/alpha/kernel/srmcons.c            |  6 +++---
 arch/m68k/emu/nfcon.c                  |  7 +++----
 arch/parisc/kernel/pdc_cons.c          |  9 ++++-----
 arch/um/drivers/line.c                 | 11 ++++++-----
 arch/xtensa/platforms/iss/console.c    |  7 +++----
 drivers/ipack/devices/ipoctal.c        |  9 ++++-----
 drivers/isdn/capi/capi.c               | 10 ++++------
 drivers/mmc/core/sdio_uart.c           |  8 ++++----
 drivers/net/usb/hso.c                  |  8 ++++----
 drivers/s390/char/con3215.c            |  7 +++----
 drivers/s390/char/sclp_tty.c           |  7 +++----
 drivers/s390/char/sclp_vt220.c         |  7 +++----
 drivers/staging/gdm724x/gdm_tty.c      |  9 ++++-----
 drivers/tty/amiserial.c                |  7 +++----
 drivers/tty/ehv_bytechan.c             |  8 ++++----
 drivers/tty/goldfish.c                 | 14 +++++++-------
 drivers/tty/hvc/hvc_console.c          |  8 ++++----
 drivers/tty/hvc/hvcs.c                 |  8 ++++----
 drivers/tty/hvc/hvsi.c                 |  7 +++----
 drivers/tty/ipwireless/tty.c           |  8 ++++----
 drivers/tty/mxser.c                    |  8 ++++----
 drivers/tty/n_gsm.c                    |  9 ++++-----
 drivers/tty/nozomi.c                   |  8 ++++----
 drivers/tty/serial/kgdb_nmi.c          |  7 +++----
 drivers/tty/serial/serial_core.c       |  8 +++++---
 drivers/tty/synclink_gt.c              |  8 ++++----
 drivers/tty/vt/vt.c                    |  6 +++---
 drivers/usb/class/cdc-acm.c            |  8 ++++----
 drivers/usb/gadget/function/u_serial.c |  8 ++++----
 drivers/usb/serial/usb-serial.c        |  9 ++++-----
 net/bluetooth/rfcomm/tty.c             |  8 ++++----
 31 files changed, 120 insertions(+), 132 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index fc03471a0b0f..d0a1b08d851d 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -204,9 +204,9 @@ srmcons_init(void)
 		struct tty_driver *driver;
 		int err;
 
-		driver = alloc_tty_driver(MAX_SRM_CONSOLE_DEVICES);
-		if (!driver)
-			return -ENOMEM;
+		driver = tty_alloc_driver(MAX_SRM_CONSOLE_DEVICES, 0);
+		if (IS_ERR(driver))
+			return PTR_ERR(driver);
 
 		tty_port_init(&srmcons_singleton.port);
 
diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index f393af375c90..b3b64d03bad6 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -127,9 +127,9 @@ static int __init nfcon_init(void)
 	if (!stderr_id)
 		return -ENODEV;
 
-	driver = alloc_tty_driver(1);
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 
 	tty_port_init(&nfcon_tty_port);
 
@@ -138,7 +138,6 @@ static int __init nfcon_init(void)
 	driver->type = TTY_DRIVER_TYPE_SYSTEM;
 	driver->subtype = SYSTEM_TYPE_TTY;
 	driver->init_termios = tty_std_termios;
-	driver->flags = TTY_DRIVER_REAL_RAW;
 
 	tty_set_operations(driver, &nfcon_tty_ops);
 	tty_port_link_device(&nfcon_tty_port, driver, 0);
diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 650cb01203de..70c2a1648fc1 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -161,9 +161,10 @@ static int __init pdc_console_tty_driver_init(void)
 	printk(KERN_INFO "The PDC console driver is still registered, removing CON_BOOT flag\n");
 	pdc_cons.flags &= ~CON_BOOT;
 
-	driver = alloc_tty_driver(1);
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_RESET_TERMIOS);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 
 	tty_port_init(&tty_port);
 
@@ -173,8 +174,6 @@ static int __init pdc_console_tty_driver_init(void)
 	driver->minor_start = 0;
 	driver->type = TTY_DRIVER_TYPE_SYSTEM;
 	driver->init_termios = tty_std_termios;
-	driver->flags = TTY_DRIVER_REAL_RAW |
-		TTY_DRIVER_RESET_TERMIOS;
 	tty_set_operations(driver, &pdc_console_tty_ops);
 	tty_port_link_device(&tty_port, driver, 0);
 
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index fbc623d2cc07..0d8f4ee6335d 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -538,12 +538,14 @@ int register_lines(struct line_driver *line_driver,
 		   const struct tty_operations *ops,
 		   struct line *lines, int nlines)
 {
-	struct tty_driver *driver = alloc_tty_driver(nlines);
+	struct tty_driver *driver;
 	int err;
 	int i;
 
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(nlines, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 
 	driver->driver_name = line_driver->name;
 	driver->name = line_driver->device_name;
@@ -551,9 +553,8 @@ int register_lines(struct line_driver *line_driver,
 	driver->minor_start = line_driver->minor_start;
 	driver->type = line_driver->type;
 	driver->subtype = line_driver->subtype;
-	driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	driver->init_termios = tty_std_termios;
-	
+
 	for (i = 0; i < nlines; i++) {
 		tty_port_init(&lines[i].port);
 		lines[i].port.ops = &line_port_ops;
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 9c3cf369b7b2..0b8a0565cdfd 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -139,9 +139,9 @@ static int __init rs_init(void)
 	struct tty_driver *driver;
 	int ret;
 
-	driver = alloc_tty_driver(SERIAL_MAX_NUM_LINES);
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(SERIAL_MAX_NUM_LINES, TTY_DRIVER_REAL_RAW);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 
 	tty_port_init(&serial_port);
 
@@ -156,7 +156,6 @@ static int __init rs_init(void)
 	driver->init_termios = tty_std_termios;
 	driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	driver->flags = TTY_DRIVER_REAL_RAW;
 
 	tty_set_operations(driver, &serial_ops);
 	tty_port_link_device(&serial_port, driver, 0);
diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index 20fa02c81070..be6d11f46e62 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -347,10 +347,10 @@ static int ipoctal_inst_slot(struct ipoctal *ipoctal, unsigned int bus_nr,
 	/* Register the TTY device */
 
 	/* Each IP-OCTAL channel is a TTY port */
-	tty = alloc_tty_driver(NR_CHANNELS);
-
-	if (!tty)
-		return -ENOMEM;
+	tty = tty_alloc_driver(NR_CHANNELS, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(tty))
+		return PTR_ERR(tty);
 
 	/* Fill struct tty_driver with ipoctal data */
 	tty->owner = THIS_MODULE;
@@ -362,7 +362,6 @@ static int ipoctal_inst_slot(struct ipoctal *ipoctal, unsigned int bus_nr,
 	tty->minor_start = 0;
 	tty->type = TTY_DRIVER_TYPE_SERIAL;
 	tty->subtype = SERIAL_TYPE_NORMAL;
-	tty->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty->init_termios = tty_std_termios;
 	tty->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	tty->init_termios.c_ispeed = 9600;
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index d5f9261fa879..32abf4d15450 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1269,10 +1269,11 @@ static int __init capinc_tty_init(void)
 	if (!capiminors)
 		return -ENOMEM;
 
-	drv = alloc_tty_driver(capi_ttyminors);
-	if (!drv) {
+	drv = tty_alloc_driver(capi_ttyminors, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(drv)) {
 		kfree(capiminors);
-		return -ENOMEM;
+		return PTR_ERR(drv);
 	}
 	drv->driver_name = "capi_nc";
 	drv->name = "capi!";
@@ -1285,9 +1286,6 @@ static int __init capinc_tty_init(void)
 	drv->init_termios.c_oflag = OPOST | ONLCR;
 	drv->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	drv->init_termios.c_lflag = 0;
-	drv->flags =
-		TTY_DRIVER_REAL_RAW | TTY_DRIVER_RESET_TERMIOS |
-		TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(drv, &capinc_ops);
 
 	err = tty_register_driver(drv);
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index c36242b86b1d..04a57832e486 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -1135,9 +1135,10 @@ static int __init sdio_uart_init(void)
 	int ret;
 	struct tty_driver *tty_drv;
 
-	sdio_uart_tty_driver = tty_drv = alloc_tty_driver(UART_NR);
-	if (!tty_drv)
-		return -ENOMEM;
+	sdio_uart_tty_driver = tty_drv = tty_alloc_driver(UART_NR,
+			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(tty_drv))
+		return PTR_ERR(tty_drv);
 
 	tty_drv->driver_name = "sdio_uart";
 	tty_drv->name =   "ttySDIO";
@@ -1145,7 +1146,6 @@ static int __init sdio_uart_init(void)
 	tty_drv->minor_start = 0;
 	tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
 	tty_drv->subtype = SERIAL_TYPE_NORMAL;
-	tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty_drv->init_termios = tty_std_termios;
 	tty_drv->init_termios.c_cflag = B4800 | CS8 | CREAD | HUPCL | CLOCAL;
 	tty_drv->init_termios.c_ispeed = 4800;
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index dec96e8ab567..29df4b34e002 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -3242,9 +3242,10 @@ static int __init hso_init(void)
 		serial_table[i] = NULL;
 
 	/* allocate our driver using the proper amount of supported minors */
-	tty_drv = alloc_tty_driver(HSO_SERIAL_TTY_MINORS);
-	if (!tty_drv)
-		return -ENOMEM;
+	tty_drv = tty_alloc_driver(HSO_SERIAL_TTY_MINORS, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(tty_drv))
+		return PTR_ERR(tty_drv);
 
 	/* fill in all needed values */
 	tty_drv->driver_name = driver_name;
@@ -3257,7 +3258,6 @@ static int __init hso_init(void)
 	tty_drv->minor_start = 0;
 	tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
 	tty_drv->subtype = SERIAL_TYPE_NORMAL;
-	tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty_drv->init_termios = tty_std_termios;
 	hso_init_termios(&tty_drv->init_termios);
 	tty_set_operations(tty_drv, &hso_serial_ops);
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 67c0009ca545..3818a89aef5c 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -1076,9 +1076,9 @@ static int __init tty3215_init(void)
 	if (!CONSOLE_IS_3215)
 		return 0;
 
-	driver = alloc_tty_driver(NR_3215);
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(NR_3215, TTY_DRIVER_REAL_RAW);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 
 	ret = ccw_driver_register(&raw3215_ccw_driver);
 	if (ret) {
@@ -1101,7 +1101,6 @@ static int __init tty3215_init(void)
 	driver->init_termios.c_iflag = IGNBRK | IGNPAR;
 	driver->init_termios.c_oflag = ONLCR;
 	driver->init_termios.c_lflag = ISIG;
-	driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(driver, &tty3215_ops);
 	ret = tty_register_driver(driver);
 	if (ret) {
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 6be9de8ed37d..48790f8fb3b1 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -503,9 +503,9 @@ sclp_tty_init(void)
 		return 0;
 	if (!sclp.has_linemode)
 		return 0;
-	driver = alloc_tty_driver(1);
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 
 	rc = sclp_rw_init();
 	if (rc) {
@@ -548,7 +548,6 @@ sclp_tty_init(void)
 	driver->init_termios.c_iflag = IGNBRK | IGNPAR;
 	driver->init_termios.c_oflag = ONLCR;
 	driver->init_termios.c_lflag = ISIG | ECHO;
-	driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(driver, &sclp_ops);
 	tty_port_link_device(&sclp_port, driver, 0);
 	rc = tty_register_driver(driver);
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index da2496306c04..c6a7ea32aa5c 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -732,9 +732,9 @@ static int __init sclp_vt220_tty_init(void)
 
 	/* Note: we're not testing for CONSOLE_IS_SCLP here to preserve
 	 * symmetry between VM and LPAR systems regarding ttyS1. */
-	driver = alloc_tty_driver(1);
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 	rc = __sclp_vt220_init(MAX_KMEM_PAGES);
 	if (rc)
 		goto out_driver;
@@ -746,7 +746,6 @@ static int __init sclp_vt220_tty_init(void)
 	driver->type = TTY_DRIVER_TYPE_SYSTEM;
 	driver->subtype = SYSTEM_TYPE_TTY;
 	driver->init_termios = tty_std_termios;
-	driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(driver, &sclp_vt220_ops);
 	tty_port_link_device(&sclp_vt220_port, driver, 0);
 
diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 279de2cd9c4a..918575417264 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -281,9 +281,10 @@ int register_lte_tty_driver(void)
 	int ret;
 
 	for (i = 0; i < TTY_MAX_COUNT; i++) {
-		tty_driver = alloc_tty_driver(GDM_TTY_MINOR);
-		if (!tty_driver)
-			return -ENOMEM;
+		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
+				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+		if (IS_ERR(tty_driver))
+			return PTR_ERR(tty_driver);
 
 		tty_driver->owner = THIS_MODULE;
 		tty_driver->driver_name = DRIVER_STRING[i];
@@ -291,8 +292,6 @@ int register_lte_tty_driver(void)
 		tty_driver->major = GDM_TTY_MAJOR;
 		tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 		tty_driver->subtype = SERIAL_TYPE_NORMAL;
-		tty_driver->flags = TTY_DRIVER_REAL_RAW |
-					TTY_DRIVER_DYNAMIC_DEV;
 		tty_driver->init_termios = tty_std_termios;
 		tty_driver->init_termios.c_cflag = B9600 | CS8 | HUPCL | CLOCAL;
 		tty_driver->init_termios.c_lflag = ISIG | ICANON | IEXTEN;
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index bfd3acc1ecfa..50f1a54ef35a 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1494,9 +1494,9 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	unsigned long flags;
 	int error;
 
-	driver = alloc_tty_driver(1);
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 
 	/* Initialize the tty_driver structure */
 
@@ -1509,7 +1509,6 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	driver->init_termios = tty_std_termios;
 	driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(driver, &serial_ops);
 
 	memset(state, 0, sizeof(*state));
diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 97ae940af478..f580a5de3c98 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -774,9 +774,10 @@ static int __init ehv_bc_init(void)
 	if (!bcs)
 		return -ENOMEM;
 
-	driver = alloc_tty_driver(count);
-	if (!driver) {
-		ret = -ENOMEM;
+	driver = tty_alloc_driver(count, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(driver)) {
+		ret = PTR_ERR(driver);
 		goto err_free_bcs;
 	}
 
@@ -785,7 +786,6 @@ static int __init ehv_bc_init(void)
 	driver->type = TTY_DRIVER_TYPE_CONSOLE;
 	driver->subtype = SYSTEM_TYPE_CONSOLE;
 	driver->init_termios = tty_std_termios;
-	driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(driver, &ehv_bc_ops);
 
 	ret = tty_register_driver(driver);
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index ccb683a6e6f5..853083fcebb8 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -253,18 +253,18 @@ static int goldfish_tty_create_driver(void)
 		ret = -ENOMEM;
 		goto err_alloc_goldfish_ttys_failed;
 	}
-	tty = alloc_tty_driver(goldfish_tty_line_count);
-	if (tty == NULL) {
-		ret = -ENOMEM;
-		goto err_alloc_tty_driver_failed;
+	tty = tty_alloc_driver(goldfish_tty_line_count,
+			TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(tty)) {
+		ret = PTR_ERR(tty);
+		goto err_tty_alloc_driver_failed;
 	}
 	tty->driver_name = "goldfish";
 	tty->name = "ttyGF";
 	tty->type = TTY_DRIVER_TYPE_SERIAL;
 	tty->subtype = SERIAL_TYPE_NORMAL;
 	tty->init_termios = tty_std_termios;
-	tty->flags = TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_REAL_RAW |
-						TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(tty, &goldfish_tty_ops);
 	ret = tty_register_driver(tty);
 	if (ret)
@@ -275,7 +275,7 @@ static int goldfish_tty_create_driver(void)
 
 err_tty_register_driver_failed:
 	put_tty_driver(tty);
-err_alloc_tty_driver_failed:
+err_tty_alloc_driver_failed:
 	kfree(goldfish_ttys);
 	goldfish_ttys = NULL;
 err_alloc_goldfish_ttys_failed:
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5bb8c4e44961..9215dd4bd9f0 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -1021,9 +1021,10 @@ static int hvc_init(void)
 	int err;
 
 	/* We need more than hvc_count adapters due to hotplug additions. */
-	drv = alloc_tty_driver(HVC_ALLOC_TTY_ADAPTERS);
-	if (!drv) {
-		err = -ENOMEM;
+	drv = tty_alloc_driver(HVC_ALLOC_TTY_ADAPTERS, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_RESET_TERMIOS);
+	if (IS_ERR(drv)) {
+		err = PTR_ERR(drv);
 		goto out;
 	}
 
@@ -1033,7 +1034,6 @@ static int hvc_init(void)
 	drv->minor_start = HVC_MINOR;
 	drv->type = TTY_DRIVER_TYPE_SYSTEM;
 	drv->init_termios = tty_std_termios;
-	drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_RESET_TERMIOS;
 	tty_set_operations(drv, &hvc_ops);
 
 	/* Always start the kthread because there can be hotplug vty adapters
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index fe5e6b4f43de..23aebc964201 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1445,10 +1445,11 @@ static int hvcs_initialize(void)
 	} else
 		num_ttys_to_alloc = hvcs_parm_num_devs;
 
-	hvcs_tty_driver = alloc_tty_driver(num_ttys_to_alloc);
-	if (!hvcs_tty_driver) {
+	hvcs_tty_driver = tty_alloc_driver(num_ttys_to_alloc,
+			TTY_DRIVER_REAL_RAW);
+	if (IS_ERR(hvcs_tty_driver)) {
 		mutex_unlock(&hvcs_init_mutex);
-		return -ENOMEM;
+		return PTR_ERR(hvcs_tty_driver);
 	}
 
 	if (hvcs_alloc_index_list(num_ttys_to_alloc)) {
@@ -1473,7 +1474,6 @@ static int hvcs_initialize(void)
 	 * throw us into a horrible recursive echo-echo-echo loop.
 	 */
 	hvcs_tty_driver->init_termios = hvcs_tty_termios;
-	hvcs_tty_driver->flags = TTY_DRIVER_REAL_RAW;
 
 	tty_set_operations(hvcs_tty_driver, &hvcs_ops);
 
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index bfde7b1936a5..aa81f4835fef 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -1041,9 +1041,9 @@ static int __init hvsi_init(void)
 	struct tty_driver *driver;
 	int i, ret;
 
-	driver = alloc_tty_driver(hvsi_count);
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(hvsi_count, TTY_DRIVER_REAL_RAW);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 
 	driver->driver_name = "hvsi";
 	driver->name = "hvsi";
@@ -1054,7 +1054,6 @@ static int __init hvsi_init(void)
 	driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL;
 	driver->init_termios.c_ispeed = 9600;
 	driver->init_termios.c_ospeed = 9600;
-	driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(driver, &hvsi_ops);
 
 	for (i=0; i < hvsi_count; i++) {
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index e3a5a5ba752c..d24404c222e0 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -564,9 +564,10 @@ int ipwireless_tty_init(void)
 {
 	int result;
 
-	ipw_tty_driver = alloc_tty_driver(IPWIRELESS_PCMCIA_MINORS);
-	if (!ipw_tty_driver)
-		return -ENOMEM;
+	ipw_tty_driver = tty_alloc_driver(IPWIRELESS_PCMCIA_MINORS,
+			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(ipw_tty_driver))
+		return PTR_ERR(ipw_tty_driver);
 
 	ipw_tty_driver->driver_name = IPWIRELESS_PCCARD_NAME;
 	ipw_tty_driver->name = "ttyIPWp";
@@ -574,7 +575,6 @@ int ipwireless_tty_init(void)
 	ipw_tty_driver->minor_start = IPWIRELESS_PCMCIA_START;
 	ipw_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	ipw_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	ipw_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	ipw_tty_driver->init_termios = tty_std_termios;
 	ipw_tty_driver->init_termios.c_cflag =
 	    B9600 | CS8 | CREAD | HUPCL | CLOCAL;
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 900ccb2ca166..650fc6fac88e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1976,9 +1976,10 @@ static int __init mxser_module_init(void)
 {
 	int retval;
 
-	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS);
-	if (!mxvar_sdriver)
-		return -ENOMEM;
+	mxvar_sdriver = tty_alloc_driver(MXSER_PORTS, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(mxvar_sdriver))
+		return PTR_ERR(mxvar_sdriver);
 
 	/* Initialize the tty_driver structure */
 	mxvar_sdriver->name = "ttyMI";
@@ -1988,7 +1989,6 @@ static int __init mxser_module_init(void)
 	mxvar_sdriver->subtype = SERIAL_TYPE_NORMAL;
 	mxvar_sdriver->init_termios = tty_std_termios;
 	mxvar_sdriver->init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
-	mxvar_sdriver->flags = TTY_DRIVER_REAL_RAW|TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(mxvar_sdriver, &mxser_ops);
 
 	retval = tty_register_driver(mxvar_sdriver);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e907b7a5cab5..0308669c21c6 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3252,10 +3252,11 @@ static int __init gsm_init(void)
 		return status;
 	}
 
-	gsm_tty_driver = alloc_tty_driver(256);
-	if (!gsm_tty_driver) {
+	gsm_tty_driver = tty_alloc_driver(256, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_HARDWARE_BREAK);
+	if (IS_ERR(gsm_tty_driver)) {
 		pr_err("gsm_init: tty allocation failed.\n");
-		status = -ENOMEM;
+		status = PTR_ERR(gsm_tty_driver);
 		goto err_unreg_ldisc;
 	}
 	gsm_tty_driver->driver_name	= "gsmtty";
@@ -3264,8 +3265,6 @@ static int __init gsm_init(void)
 	gsm_tty_driver->minor_start	= 0;
 	gsm_tty_driver->type		= TTY_DRIVER_TYPE_SERIAL;
 	gsm_tty_driver->subtype	= SERIAL_TYPE_NORMAL;
-	gsm_tty_driver->flags	= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV
-						| TTY_DRIVER_HARDWARE_BREAK;
 	gsm_tty_driver->init_termios	= tty_std_termios;
 	/* Fixme */
 	gsm_tty_driver->init_termios.c_lflag &= ~ECHO;
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 0c80f25c8c3d..f3eb0aaec79b 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1824,16 +1824,16 @@ static __init int nozomi_init(void)
 {
 	int ret;
 
-	ntty_driver = alloc_tty_driver(NTTY_TTY_MAXMINORS);
-	if (!ntty_driver)
-		return -ENOMEM;
+	ntty_driver = tty_alloc_driver(NTTY_TTY_MAXMINORS, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(ntty_driver))
+		return PTR_ERR(ntty_driver);
 
 	ntty_driver->driver_name = NOZOMI_NAME_TTY;
 	ntty_driver->name = "noz";
 	ntty_driver->major = 0;
 	ntty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	ntty_driver->subtype = SERIAL_TYPE_NORMAL;
-	ntty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	ntty_driver->init_termios = tty_std_termios;
 	ntty_driver->init_termios.c_cflag = B115200 | CS8 | CREAD | \
 						HUPCL | CLOCAL;
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 3e7c6ee8e4b3..9209573a7e37 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -330,17 +330,16 @@ int kgdb_register_nmi_console(void)
 	if (!arch_kgdb_ops.enable_nmi)
 		return 0;
 
-	kgdb_nmi_tty_driver = alloc_tty_driver(1);
-	if (!kgdb_nmi_tty_driver) {
+	kgdb_nmi_tty_driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
+	if (IS_ERR(kgdb_nmi_tty_driver)) {
 		pr_err("%s: cannot allocate tty\n", __func__);
-		return -ENOMEM;
+		return PTR_ERR(kgdb_nmi_tty_driver);
 	}
 	kgdb_nmi_tty_driver->driver_name	= "ttyNMI";
 	kgdb_nmi_tty_driver->name		= "ttyNMI";
 	kgdb_nmi_tty_driver->num		= 1;
 	kgdb_nmi_tty_driver->type		= TTY_DRIVER_TYPE_SERIAL;
 	kgdb_nmi_tty_driver->subtype		= SERIAL_TYPE_NORMAL;
-	kgdb_nmi_tty_driver->flags		= TTY_DRIVER_REAL_RAW;
 	kgdb_nmi_tty_driver->init_termios	= tty_std_termios;
 	tty_termios_encode_baud_rate(&kgdb_nmi_tty_driver->init_termios,
 				     KGDB_NMI_BAUD, KGDB_NMI_BAUD);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 69092deba11f..b03a883a21c5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2522,9 +2522,12 @@ int uart_register_driver(struct uart_driver *drv)
 	if (!drv->state)
 		goto out;
 
-	normal = alloc_tty_driver(drv->nr);
-	if (!normal)
+	normal = tty_alloc_driver(drv->nr, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(normal)) {
+		retval = PTR_ERR(normal);
 		goto out_kfree;
+	}
 
 	drv->tty_driver = normal;
 
@@ -2537,7 +2540,6 @@ int uart_register_driver(struct uart_driver *drv)
 	normal->init_termios	= tty_std_termios;
 	normal->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	normal->init_termios.c_ispeed = normal->init_termios.c_ospeed = 9600;
-	normal->flags		= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	normal->driver_state    = drv;
 	tty_set_operations(normal, &uart_ops);
 
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 5bb928b7873e..525f3a568c32 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3689,10 +3689,11 @@ static int __init slgt_init(void)
 
 	printk(KERN_INFO "%s\n", driver_name);
 
-	serial_driver = alloc_tty_driver(MAX_DEVICES);
-	if (!serial_driver) {
+	serial_driver = tty_alloc_driver(MAX_DEVICES, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(serial_driver)) {
 		printk("%s can't allocate tty driver\n", driver_name);
-		return -ENOMEM;
+		return PTR_ERR(serial_driver);
 	}
 
 	/* Initialize the tty_driver structure */
@@ -3708,7 +3709,6 @@ static int __init slgt_init(void)
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	serial_driver->init_termios.c_ispeed = 9600;
 	serial_driver->init_termios.c_ospeed = 9600;
-	serial_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(serial_driver, &ops);
 	if ((rc = tty_register_driver(serial_driver)) < 0) {
 		DBGERR(("%s can't register serial driver\n", driver_name));
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ef981d3b7bb4..744caa327d8c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3559,8 +3559,9 @@ int __init vty_init(const struct file_operations *console_fops)
 
 	vcs_init();
 
-	console_driver = alloc_tty_driver(MAX_NR_CONSOLES);
-	if (!console_driver)
+	console_driver = tty_alloc_driver(MAX_NR_CONSOLES, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_RESET_TERMIOS);
+	if (IS_ERR(console_driver))
 		panic("Couldn't allocate console driver\n");
 
 	console_driver->name = "tty";
@@ -3571,7 +3572,6 @@ int __init vty_init(const struct file_operations *console_fops)
 	console_driver->init_termios = tty_std_termios;
 	if (default_utf8)
 		console_driver->init_termios.c_iflag |= IUTF8;
-	console_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_RESET_TERMIOS;
 	tty_set_operations(console_driver, &con_ops);
 	if (tty_register_driver(console_driver))
 		panic("Couldn't register console driver\n");
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 4895325b16a4..c19b59583d9f 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -2027,16 +2027,16 @@ static const struct tty_operations acm_ops = {
 static int __init acm_init(void)
 {
 	int retval;
-	acm_tty_driver = alloc_tty_driver(ACM_TTY_MINORS);
-	if (!acm_tty_driver)
-		return -ENOMEM;
+	acm_tty_driver = tty_alloc_driver(ACM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(acm_tty_driver))
+		return PTR_ERR(acm_tty_driver);
 	acm_tty_driver->driver_name = "acm",
 	acm_tty_driver->name = "ttyACM",
 	acm_tty_driver->major = ACM_TTY_MAJOR,
 	acm_tty_driver->minor_start = 0,
 	acm_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
 	acm_tty_driver->subtype = SERIAL_TYPE_NORMAL,
-	acm_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	acm_tty_driver->init_termios = tty_std_termios;
 	acm_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD |
 								HUPCL | CLOCAL;
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index c99917a07a96..74289f68a2ab 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1449,9 +1449,10 @@ static int userial_init(void)
 	unsigned			i;
 	int				status;
 
-	driver = alloc_tty_driver(MAX_U_SERIAL_PORTS);
-	if (!driver)
-		return -ENOMEM;
+	driver = tty_alloc_driver(MAX_U_SERIAL_PORTS, TTY_DRIVER_REAL_RAW |
+			TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
 
 	driver->driver_name = "g_serial";
 	driver->name = "ttyGS";
@@ -1459,7 +1460,6 @@ static int userial_init(void)
 
 	driver->type = TTY_DRIVER_TYPE_SERIAL;
 	driver->subtype = SERIAL_TYPE_NORMAL;
-	driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	driver->init_termios = tty_std_termios;
 
 	/* 9600-8-N-1 ... matches defaults expected by "usbser.sys" on
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index eeb441c77207..2f7855da645f 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1319,9 +1319,10 @@ static int __init usb_serial_init(void)
 {
 	int result;
 
-	usb_serial_tty_driver = alloc_tty_driver(USB_SERIAL_TTY_MINORS);
-	if (!usb_serial_tty_driver)
-		return -ENOMEM;
+	usb_serial_tty_driver = tty_alloc_driver(USB_SERIAL_TTY_MINORS,
+			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(usb_serial_tty_driver))
+		return PTR_ERR(usb_serial_tty_driver);
 
 	/* Initialize our global data */
 	result = bus_register(&usb_serial_bus_type);
@@ -1336,8 +1337,6 @@ static int __init usb_serial_init(void)
 	usb_serial_tty_driver->minor_start = 0;
 	usb_serial_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	usb_serial_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	usb_serial_tty_driver->flags = TTY_DRIVER_REAL_RAW |
-						TTY_DRIVER_DYNAMIC_DEV;
 	usb_serial_tty_driver->init_termios = tty_std_termios;
 	usb_serial_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD
 							| HUPCL | CLOCAL;
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 4e095746e002..8ec0600cd927 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -1127,9 +1127,10 @@ int __init rfcomm_init_ttys(void)
 {
 	int error;
 
-	rfcomm_tty_driver = alloc_tty_driver(RFCOMM_TTY_PORTS);
-	if (!rfcomm_tty_driver)
-		return -ENOMEM;
+	rfcomm_tty_driver = tty_alloc_driver(RFCOMM_TTY_PORTS,
+			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(rfcomm_tty_driver))
+		return PTR_ERR(rfcomm_tty_driver);
 
 	rfcomm_tty_driver->driver_name	= "rfcomm";
 	rfcomm_tty_driver->name		= "rfcomm";
@@ -1137,7 +1138,6 @@ int __init rfcomm_init_ttys(void)
 	rfcomm_tty_driver->minor_start	= RFCOMM_TTY_MINOR;
 	rfcomm_tty_driver->type		= TTY_DRIVER_TYPE_SERIAL;
 	rfcomm_tty_driver->subtype	= SERIAL_TYPE_NORMAL;
-	rfcomm_tty_driver->flags	= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	rfcomm_tty_driver->init_termios	= tty_std_termios;
 	rfcomm_tty_driver->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL;
 	rfcomm_tty_driver->init_termios.c_lflag &= ~ICANON;
-- 
2.32.0

