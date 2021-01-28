Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B213C433E6
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA0964E05
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 17:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhA1Rcz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Jan 2021 12:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhA1Rcf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Jan 2021 12:32:35 -0500
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Jan 2021 09:31:33 PST
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:8d8e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC16C061573
        for <linux-serial@vger.kernel.org>; Thu, 28 Jan 2021 09:31:33 -0800 (PST)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 028AD15360;
        Thu, 28 Jan 2021 17:22:54 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id C69D121A3C6; Thu, 28 Jan 2021 17:22:53 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: add option to disable registration of legacy ISA ports
Date:   Thu, 28 Jan 2021 17:22:44 +0000
Message-Id: <20210128172244.22859-1-mans@mansr.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On systems that do not have the traditional PC ISA serial ports, the
8250 driver still creates non-functional device nodes.  This change
makes only ports that actually exist (PCI, DT, ...) get device nodes.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/tty/serial/8250/8250_core.c | 26 ++++++++++++++++++++------
 drivers/tty/serial/8250/Kconfig     |  5 +++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index cae61d1ebec5..49695dd3677c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -555,6 +555,7 @@ static void __init serial8250_isa_init_ports(void)
 	}
 }
 
+#ifdef CONFIG_SERIAL_8250_ISA
 static void __init
 serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 {
@@ -575,6 +576,7 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 		uart_add_one_port(drv, &up->port);
 	}
 }
+#endif
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
@@ -797,6 +799,7 @@ void serial8250_resume_port(int line)
 }
 EXPORT_SYMBOL(serial8250_resume_port);
 
+#ifdef CONFIG_SERIAL_8250_ISA
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -907,6 +910,7 @@ static struct platform_driver serial8250_isa_driver = {
  * in the table in include/asm/serial.h
  */
 static struct platform_device *serial8250_isa_devs;
+#endif
 
 /*
  * serial8250_register_8250_port and serial8250_unregister_port allows for
@@ -1149,6 +1153,8 @@ void serial8250_unregister_port(int line)
 	}
 
 	uart_remove_one_port(&serial8250_reg, &uart->port);
+	uart->port.dev = NULL;
+#ifdef CONFIG_SERIAL_8250_ISA
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		uart->port.type = PORT_UNKNOWN;
@@ -1156,9 +1162,8 @@ void serial8250_unregister_port(int line)
 		uart->capabilities = 0;
 		serial8250_apply_quirks(uart);
 		uart_add_one_port(&serial8250_reg, &uart->port);
-	} else {
-		uart->port.dev = NULL;
 	}
+#endif
 	mutex_unlock(&serial_mutex);
 }
 EXPORT_SYMBOL(serial8250_unregister_port);
@@ -1188,6 +1193,7 @@ static int __init serial8250_init(void)
 	if (ret)
 		goto unreg_uart_drv;
 
+#ifdef CONFIG_SERIAL_8250_ISA
 	serial8250_isa_devs = platform_device_alloc("serial8250",
 						    PLAT8250_DEV_LEGACY);
 	if (!serial8250_isa_devs) {
@@ -1202,26 +1208,33 @@ static int __init serial8250_init(void)
 	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
 
 	ret = platform_driver_register(&serial8250_isa_driver);
-	if (ret == 0)
-		goto out;
+	if (ret)
+		goto del_dev;
+#endif
 
+out:
+	return ret;
+
+#ifdef CONFIG_SERIAL_8250_ISA
+del_dev:
 	platform_device_del(serial8250_isa_devs);
 put_dev:
 	platform_device_put(serial8250_isa_devs);
 unreg_pnp:
 	serial8250_pnp_exit();
+#endif
 unreg_uart_drv:
 #ifdef CONFIG_SPARC
 	sunserial_unregister_minors(&serial8250_reg, UART_NR);
 #else
 	uart_unregister_driver(&serial8250_reg);
 #endif
-out:
-	return ret;
+	goto out;
 }
 
 static void __exit serial8250_exit(void)
 {
+#ifdef CONFIG_SERIAL_8250_ISA
 	struct platform_device *isa_dev = serial8250_isa_devs;
 
 	/*
@@ -1233,6 +1246,7 @@ static void __exit serial8250_exit(void)
 
 	platform_driver_unregister(&serial8250_isa_driver);
 	platform_device_unregister(isa_dev);
+#endif
 
 	serial8250_pnp_exit();
 
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 603137da4736..683f81675a77 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -52,6 +52,11 @@ config SERIAL_8250_DEPRECATED_OPTIONS
 	  If you did not notice yet and/or you have userspace from pre-3.7, it
 	  is safe (and recommended) to say N here.
 
+config SERIAL_8250_ISA
+	bool "8250/16550 ISA device support" if EXPERT
+	depends on SERIAL_8250
+	default y
+
 config SERIAL_8250_PNP
 	bool "8250/16550 PNP device support" if EXPERT
 	depends on SERIAL_8250 && PNP
-- 
2.30.0

