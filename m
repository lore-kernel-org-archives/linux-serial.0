Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E9C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FE160E8E
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhGWHCt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:02:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55396 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhGWHCq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:02:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 018A12260A;
        Fri, 23 Jul 2021 07:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627026199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maVDzmthzf1hY/R8cz0R9hhhQSQ/MU2JtblKuWZXo4c=;
        b=dXc5JngJElTdv7IGgNy+W3SUMPgGNi53s+bINV7y7tglD9rPn/U0yhcueGX+iSImTect37
        Wr6lyq90K72M2jiDLjs36uq00VZla8+u44KJAmxo/sbqGoVS9QA4Y1GiCENnIKcaVcS0Rl
        ezlyidORYXciIvypq2wriyRd5TPUi6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627026199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maVDzmthzf1hY/R8cz0R9hhhQSQ/MU2JtblKuWZXo4c=;
        b=IFW9AeJzbMSEfGBUC+5fOiyv7YCf3PK5k7ul6xwhORE10wT9njr8hfv5XHfrKicpFE4lUJ
        EjdQQConRObzsDCg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8B518A3B88;
        Fri, 23 Jul 2021 07:43:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 3/8] tty: don't store semi-state into tty drivers
Date:   Fri, 23 Jul 2021 09:43:12 +0200
Message-Id: <20210723074317.32690-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723074317.32690-1-jslaby@suse.cz>
References: <20210723074317.32690-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When a tty driver pointer is used as a return value of struct
console's device() hook, don't store a semi-state into global variable
which holds the tty driver. It could mean console::device() would return
a bogus value. This is important esp. after the next patch where we
switch from alloc_tty_driver to tty_alloc_driver. tty_alloc_driver
returns ERR_PTR in case of error and that might have unexpected results
as the code doesn't expect this.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Felipe Balbi <balbi@kernel.org>
---
 arch/m68k/emu/nfcon.c                  | 27 +++++++++++---------
 arch/parisc/kernel/pdc_cons.c          | 28 +++++++++++----------
 arch/xtensa/platforms/iss/console.c    | 33 +++++++++++++-----------
 drivers/tty/amiserial.c                | 35 ++++++++++++++------------
 drivers/tty/ehv_bytechan.c             | 28 ++++++++++++---------
 drivers/tty/hvc/hvsi.c                 | 35 ++++++++++++++------------
 drivers/usb/gadget/function/u_serial.c | 32 ++++++++++++-----------
 7 files changed, 119 insertions(+), 99 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index 92636c89d65b..f393af375c90 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -120,35 +120,38 @@ early_param("debug", nf_debug_setup);
 
 static int __init nfcon_init(void)
 {
+	struct tty_driver *driver;
 	int res;
 
 	stderr_id = nf_get_id("NF_STDERR");
 	if (!stderr_id)
 		return -ENODEV;
 
-	nfcon_tty_driver = alloc_tty_driver(1);
-	if (!nfcon_tty_driver)
+	driver = alloc_tty_driver(1);
+	if (!driver)
 		return -ENOMEM;
 
 	tty_port_init(&nfcon_tty_port);
 
-	nfcon_tty_driver->driver_name = "nfcon";
-	nfcon_tty_driver->name = "nfcon";
-	nfcon_tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
-	nfcon_tty_driver->subtype = SYSTEM_TYPE_TTY;
-	nfcon_tty_driver->init_termios = tty_std_termios;
-	nfcon_tty_driver->flags = TTY_DRIVER_REAL_RAW;
+	driver->driver_name = "nfcon";
+	driver->name = "nfcon";
+	driver->type = TTY_DRIVER_TYPE_SYSTEM;
+	driver->subtype = SYSTEM_TYPE_TTY;
+	driver->init_termios = tty_std_termios;
+	driver->flags = TTY_DRIVER_REAL_RAW;
 
-	tty_set_operations(nfcon_tty_driver, &nfcon_tty_ops);
-	tty_port_link_device(&nfcon_tty_port, nfcon_tty_driver, 0);
-	res = tty_register_driver(nfcon_tty_driver);
+	tty_set_operations(driver, &nfcon_tty_ops);
+	tty_port_link_device(&nfcon_tty_port, driver, 0);
+	res = tty_register_driver(driver);
 	if (res) {
 		pr_err("failed to register nfcon tty driver\n");
-		put_tty_driver(nfcon_tty_driver);
+		put_tty_driver(driver);
 		tty_port_destroy(&nfcon_tty_port);
 		return res;
 	}
 
+	nfcon_tty_driver = driver;
+
 	if (!(nf_console.flags & CON_ENABLED))
 		register_console(&nf_console);
 
diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 39ccad063533..650cb01203de 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -138,6 +138,7 @@ static struct tty_driver *pdc_console_tty_driver;
 
 static int __init pdc_console_tty_driver_init(void)
 {
+	struct tty_driver *driver;
 	int err;
 
 	/* Check if the console driver is still registered.
@@ -160,31 +161,32 @@ static int __init pdc_console_tty_driver_init(void)
 	printk(KERN_INFO "The PDC console driver is still registered, removing CON_BOOT flag\n");
 	pdc_cons.flags &= ~CON_BOOT;
 
-	pdc_console_tty_driver = alloc_tty_driver(1);
-
-	if (!pdc_console_tty_driver)
+	driver = alloc_tty_driver(1);
+	if (!driver)
 		return -ENOMEM;
 
 	tty_port_init(&tty_port);
 
-	pdc_console_tty_driver->driver_name = "pdc_cons";
-	pdc_console_tty_driver->name = "ttyB";
-	pdc_console_tty_driver->major = MUX_MAJOR;
-	pdc_console_tty_driver->minor_start = 0;
-	pdc_console_tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
-	pdc_console_tty_driver->init_termios = tty_std_termios;
-	pdc_console_tty_driver->flags = TTY_DRIVER_REAL_RAW |
+	driver->driver_name = "pdc_cons";
+	driver->name = "ttyB";
+	driver->major = MUX_MAJOR;
+	driver->minor_start = 0;
+	driver->type = TTY_DRIVER_TYPE_SYSTEM;
+	driver->init_termios = tty_std_termios;
+	driver->flags = TTY_DRIVER_REAL_RAW |
 		TTY_DRIVER_RESET_TERMIOS;
-	tty_set_operations(pdc_console_tty_driver, &pdc_console_tty_ops);
-	tty_port_link_device(&tty_port, pdc_console_tty_driver, 0);
+	tty_set_operations(driver, &pdc_console_tty_ops);
+	tty_port_link_device(&tty_port, driver, 0);
 
-	err = tty_register_driver(pdc_console_tty_driver);
+	err = tty_register_driver(driver);
 	if (err) {
 		printk(KERN_ERR "Unable to register the PDC console TTY driver\n");
 		tty_port_destroy(&tty_port);
 		return err;
 	}
 
+	pdc_console_tty_driver = driver;
+
 	return 0;
 }
 device_initcall(pdc_console_tty_driver_init);
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 0108504dfb45..9c3cf369b7b2 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -136,39 +136,42 @@ static const struct tty_operations serial_ops = {
 
 static int __init rs_init(void)
 {
+	struct tty_driver *driver;
 	int ret;
 
-	serial_driver = alloc_tty_driver(SERIAL_MAX_NUM_LINES);
-	if (!serial_driver)
+	driver = alloc_tty_driver(SERIAL_MAX_NUM_LINES);
+	if (!driver)
 		return -ENOMEM;
 
 	tty_port_init(&serial_port);
 
 	/* Initialize the tty_driver structure */
 
-	serial_driver->driver_name = "iss_serial";
-	serial_driver->name = "ttyS";
-	serial_driver->major = TTY_MAJOR;
-	serial_driver->minor_start = 64;
-	serial_driver->type = TTY_DRIVER_TYPE_SERIAL;
-	serial_driver->subtype = SERIAL_TYPE_NORMAL;
-	serial_driver->init_termios = tty_std_termios;
-	serial_driver->init_termios.c_cflag =
+	driver->driver_name = "iss_serial";
+	driver->name = "ttyS";
+	driver->major = TTY_MAJOR;
+	driver->minor_start = 64;
+	driver->type = TTY_DRIVER_TYPE_SERIAL;
+	driver->subtype = SERIAL_TYPE_NORMAL;
+	driver->init_termios = tty_std_termios;
+	driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	serial_driver->flags = TTY_DRIVER_REAL_RAW;
+	driver->flags = TTY_DRIVER_REAL_RAW;
 
-	tty_set_operations(serial_driver, &serial_ops);
-	tty_port_link_device(&serial_port, serial_driver, 0);
+	tty_set_operations(driver, &serial_ops);
+	tty_port_link_device(&serial_port, driver, 0);
 
-	ret = tty_register_driver(serial_driver);
+	ret = tty_register_driver(driver);
 	if (ret) {
 		pr_err("Couldn't register serial driver\n");
-		tty_driver_kref_put(serial_driver);
+		tty_driver_kref_put(driver);
 		tty_port_destroy(&serial_port);
 
 		return ret;
 	}
 
+	serial_driver = driver;
+
 	return 0;
 }
 
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 7ad103e128ac..bfd3acc1ecfa 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1490,34 +1490,35 @@ static const struct tty_port_operations amiga_port_ops = {
 static int __init amiga_serial_probe(struct platform_device *pdev)
 {
 	struct serial_state *state = &serial_state;
+	struct tty_driver *driver;
 	unsigned long flags;
 	int error;
 
-	serial_driver = alloc_tty_driver(1);
-	if (!serial_driver)
+	driver = alloc_tty_driver(1);
+	if (!driver)
 		return -ENOMEM;
 
 	/* Initialize the tty_driver structure */
 
-	serial_driver->driver_name = "amiserial";
-	serial_driver->name = "ttyS";
-	serial_driver->major = TTY_MAJOR;
-	serial_driver->minor_start = 64;
-	serial_driver->type = TTY_DRIVER_TYPE_SERIAL;
-	serial_driver->subtype = SERIAL_TYPE_NORMAL;
-	serial_driver->init_termios = tty_std_termios;
-	serial_driver->init_termios.c_cflag =
+	driver->driver_name = "amiserial";
+	driver->name = "ttyS";
+	driver->major = TTY_MAJOR;
+	driver->minor_start = 64;
+	driver->type = TTY_DRIVER_TYPE_SERIAL;
+	driver->subtype = SERIAL_TYPE_NORMAL;
+	driver->init_termios = tty_std_termios;
+	driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	serial_driver->flags = TTY_DRIVER_REAL_RAW;
-	tty_set_operations(serial_driver, &serial_ops);
+	driver->flags = TTY_DRIVER_REAL_RAW;
+	tty_set_operations(driver, &serial_ops);
 
 	memset(state, 0, sizeof(*state));
 	state->port = (int)&amiga_custom.serdatr; /* Just to give it a value */
 	tty_port_init(&state->tport);
 	state->tport.ops = &amiga_port_ops;
-	tty_port_link_device(&state->tport, serial_driver, 0);
+	tty_port_link_device(&state->tport, driver, 0);
 
-	error = tty_register_driver(serial_driver);
+	error = tty_register_driver(driver);
 	if (error)
 		goto fail_put_tty_driver;
 
@@ -1558,15 +1559,17 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, state);
 
+	serial_driver = driver;
+
 	return 0;
 
 fail_free_irq:
 	free_irq(IRQ_AMIGA_TBE, state);
 fail_unregister:
-	tty_unregister_driver(serial_driver);
+	tty_unregister_driver(driver);
 fail_put_tty_driver:
 	tty_port_destroy(&state->tport);
-	put_tty_driver(serial_driver);
+	put_tty_driver(driver);
 	return error;
 }
 
diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 445e5ff9b36d..97ae940af478 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -751,6 +751,7 @@ static struct platform_driver ehv_bc_tty_driver = {
  */
 static int __init ehv_bc_init(void)
 {
+	struct tty_driver *driver;
 	struct device_node *np;
 	unsigned int count = 0; /* Number of elements in bcs[] */
 	int ret;
@@ -773,26 +774,28 @@ static int __init ehv_bc_init(void)
 	if (!bcs)
 		return -ENOMEM;
 
-	ehv_bc_driver = alloc_tty_driver(count);
-	if (!ehv_bc_driver) {
+	driver = alloc_tty_driver(count);
+	if (!driver) {
 		ret = -ENOMEM;
 		goto err_free_bcs;
 	}
 
-	ehv_bc_driver->driver_name = "ehv-bc";
-	ehv_bc_driver->name = ehv_bc_console.name;
-	ehv_bc_driver->type = TTY_DRIVER_TYPE_CONSOLE;
-	ehv_bc_driver->subtype = SYSTEM_TYPE_CONSOLE;
-	ehv_bc_driver->init_termios = tty_std_termios;
-	ehv_bc_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
-	tty_set_operations(ehv_bc_driver, &ehv_bc_ops);
+	driver->driver_name = "ehv-bc";
+	driver->name = ehv_bc_console.name;
+	driver->type = TTY_DRIVER_TYPE_CONSOLE;
+	driver->subtype = SYSTEM_TYPE_CONSOLE;
+	driver->init_termios = tty_std_termios;
+	driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
+	tty_set_operations(driver, &ehv_bc_ops);
 
-	ret = tty_register_driver(ehv_bc_driver);
+	ret = tty_register_driver(driver);
 	if (ret) {
 		pr_err("ehv-bc: could not register tty driver (ret=%i)\n", ret);
 		goto err_put_tty_driver;
 	}
 
+	ehv_bc_driver = driver;
+
 	ret = platform_driver_register(&ehv_bc_tty_driver);
 	if (ret) {
 		pr_err("ehv-bc: could not register platform driver (ret=%i)\n",
@@ -803,9 +806,10 @@ static int __init ehv_bc_init(void)
 	return 0;
 
 err_deregister_tty_driver:
-	tty_unregister_driver(ehv_bc_driver);
+	ehv_bc_driver = NULL;
+	tty_unregister_driver(driver);
 err_put_tty_driver:
-	put_tty_driver(ehv_bc_driver);
+	put_tty_driver(driver);
 err_free_bcs:
 	kfree(bcs);
 
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index f0bc8e780051..bfde7b1936a5 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -1038,29 +1038,30 @@ static const struct tty_operations hvsi_ops = {
 
 static int __init hvsi_init(void)
 {
+	struct tty_driver *driver;
 	int i, ret;
 
-	hvsi_driver = alloc_tty_driver(hvsi_count);
-	if (!hvsi_driver)
+	driver = alloc_tty_driver(hvsi_count);
+	if (!driver)
 		return -ENOMEM;
 
-	hvsi_driver->driver_name = "hvsi";
-	hvsi_driver->name = "hvsi";
-	hvsi_driver->major = HVSI_MAJOR;
-	hvsi_driver->minor_start = HVSI_MINOR;
-	hvsi_driver->type = TTY_DRIVER_TYPE_SYSTEM;
-	hvsi_driver->init_termios = tty_std_termios;
-	hvsi_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL;
-	hvsi_driver->init_termios.c_ispeed = 9600;
-	hvsi_driver->init_termios.c_ospeed = 9600;
-	hvsi_driver->flags = TTY_DRIVER_REAL_RAW;
-	tty_set_operations(hvsi_driver, &hvsi_ops);
+	driver->driver_name = "hvsi";
+	driver->name = "hvsi";
+	driver->major = HVSI_MAJOR;
+	driver->minor_start = HVSI_MINOR;
+	driver->type = TTY_DRIVER_TYPE_SYSTEM;
+	driver->init_termios = tty_std_termios;
+	driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL;
+	driver->init_termios.c_ispeed = 9600;
+	driver->init_termios.c_ospeed = 9600;
+	driver->flags = TTY_DRIVER_REAL_RAW;
+	tty_set_operations(driver, &hvsi_ops);
 
 	for (i=0; i < hvsi_count; i++) {
 		struct hvsi_struct *hp = &hvsi_ports[i];
 		int ret = 1;
 
-		tty_port_link_device(&hp->port, hvsi_driver, i);
+		tty_port_link_device(&hp->port, driver, i);
 
 		ret = request_irq(hp->virq, hvsi_interrupt, 0, "hvsi", hp);
 		if (ret)
@@ -1069,12 +1070,14 @@ static int __init hvsi_init(void)
 	}
 	hvsi_wait = wait_for_state; /* irqs active now */
 
-	ret = tty_register_driver(hvsi_driver);
+	ret = tty_register_driver(driver);
 	if (ret) {
 		pr_err("Couldn't register hvsi console driver\n");
 		goto err_free_irq;
 	}
 
+	hvsi_driver = driver;
+
 	printk(KERN_DEBUG "HVSI: registered %i devices\n", hvsi_count);
 
 	return 0;
@@ -1085,7 +1088,7 @@ static int __init hvsi_init(void)
 
 		free_irq(hp->virq, hp);
 	}
-	tty_driver_kref_put(hvsi_driver);
+	tty_driver_kref_put(driver);
 
 	return ret;
 }
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index bffef8e47dac..c99917a07a96 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1445,51 +1445,53 @@ EXPORT_SYMBOL_GPL(gserial_resume);
 
 static int userial_init(void)
 {
+	struct tty_driver *driver;
 	unsigned			i;
 	int				status;
 
-	gs_tty_driver = alloc_tty_driver(MAX_U_SERIAL_PORTS);
-	if (!gs_tty_driver)
+	driver = alloc_tty_driver(MAX_U_SERIAL_PORTS);
+	if (!driver)
 		return -ENOMEM;
 
-	gs_tty_driver->driver_name = "g_serial";
-	gs_tty_driver->name = "ttyGS";
+	driver->driver_name = "g_serial";
+	driver->name = "ttyGS";
 	/* uses dynamically assigned dev_t values */
 
-	gs_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
-	gs_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	gs_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
-	gs_tty_driver->init_termios = tty_std_termios;
+	driver->type = TTY_DRIVER_TYPE_SERIAL;
+	driver->subtype = SERIAL_TYPE_NORMAL;
+	driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
+	driver->init_termios = tty_std_termios;
 
 	/* 9600-8-N-1 ... matches defaults expected by "usbser.sys" on
 	 * MS-Windows.  Otherwise, most of these flags shouldn't affect
 	 * anything unless we were to actually hook up to a serial line.
 	 */
-	gs_tty_driver->init_termios.c_cflag =
+	driver->init_termios.c_cflag =
 			B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	gs_tty_driver->init_termios.c_ispeed = 9600;
-	gs_tty_driver->init_termios.c_ospeed = 9600;
+	driver->init_termios.c_ispeed = 9600;
+	driver->init_termios.c_ospeed = 9600;
 
-	tty_set_operations(gs_tty_driver, &gs_tty_ops);
+	tty_set_operations(driver, &gs_tty_ops);
 	for (i = 0; i < MAX_U_SERIAL_PORTS; i++)
 		mutex_init(&ports[i].lock);
 
 	/* export the driver ... */
-	status = tty_register_driver(gs_tty_driver);
+	status = tty_register_driver(driver);
 	if (status) {
 		pr_err("%s: cannot register, err %d\n",
 				__func__, status);
 		goto fail;
 	}
 
+	gs_tty_driver = driver;
+
 	pr_debug("%s: registered %d ttyGS* device%s\n", __func__,
 			MAX_U_SERIAL_PORTS,
 			(MAX_U_SERIAL_PORTS == 1) ? "" : "s");
 
 	return status;
 fail:
-	put_tty_driver(gs_tty_driver);
-	gs_tty_driver = NULL;
+	put_tty_driver(driver);
 	return status;
 }
 module_init(userial_init);
-- 
2.32.0

