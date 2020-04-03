Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58018C2D0E8
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5AA2073B
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="F+NlUIiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390633AbgDCJY5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37936 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390609AbgDCJY4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id f6so6897875wmj.3
        for <linux-serial@vger.kernel.org>; Fri, 03 Apr 2020 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhWqEH+ifcQR6EnThkSLLdxyOoCGOTp66XJ4WIDsRQM=;
        b=F+NlUIiv/8c5llpYNJLrPG1jwFWfs+1Ib4zLJd5JPX7VpAxwt2HuxrGLbf4mQSIfoI
         L9KAmYuJ5uTbLc6Cbpq89buRnEhSIakOjMahQj5WRHPGpzyfyXhEBvEvSYzCBtjha9Hs
         uPcn46Z2UqAuy+REiJTA5W/qX1B0l9N0QWz+YzgRHH1gnWf4fCT3ONkwyzPQJ42pm1lQ
         oL6vyLbDOiLMYyKWfziAKG1Vqc0QUSQSyg6k5QkxgG7a6n7k0b63bn33ccdSb2dc+Nro
         QB5xOgjuG6gLaN3K99VRQ8uWGdZTXBQMuSsipLMbQ16296SokAiG98gleOXbfzvKfqNx
         JeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IhWqEH+ifcQR6EnThkSLLdxyOoCGOTp66XJ4WIDsRQM=;
        b=gbjE3kh3a0HgdXk3uch3/iSHQt1lUw5uvyxS1hCakLi70NgR87nzyRAdw0+tI6l3U4
         MruqOsYN5v3lKm/hHVcOM8CzwdDSxY6Yi/j/pKLBqv7fKNeOKUjPWyvx+v69Kt1qCXym
         +PABgehQXmd7Cm6peV0UynK0GBj0vgig4Oit4SQZwflAK8ohRhQRYC9/MSAHZz1Q8roI
         cMWB83ARYac8h4lWyZ1MQmlt2wyKXOsmoYECqOrsPUQ/IbiDWqEjBr9+qO/IrMRBKVV4
         z+p76pXS2Gin67xqSyxpf6Fv/S+oxzUocFoVdpono66JXkUoNW3SQTcvFNfeSJlC8vBi
         t7fQ==
X-Gm-Message-State: AGi0PuawIiITxRa9brlUNxaAaijTy3+z6+BgMcbAaC0ht6eXq6P4cdn9
        Ej4ejzKiUSRFQH2XRYc5prDMWw==
X-Google-Smtp-Source: APiQypJm1SUyhExIFhsNSoRGaTQ+ETR8QzrrZcogS3Uwn33V4q/ATjdOeTQc8R1D8teAyU06BdsV0w==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr7405666wmj.3.1585905893625;
        Fri, 03 Apr 2020 02:24:53 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i2sm11239997wrx.22.2020.04.03.02.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:53 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 7/7] Revert "serial: uartps: Register own uart console and driver structures"
Date:   Fri,  3 Apr 2020 11:24:36 +0200
Message-Id: <1ee35667e36a8efddee381df5fe495ad65f4d15c.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 024ca329bfb9a948f76eaff3243e21b7e70182f2.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 95 +++++++++++++-----------------
 1 file changed, 40 insertions(+), 55 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 41d9c2f188f0..ac137b6a1dc1 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -27,6 +27,7 @@
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
+#define CDNS_UART_MINOR		0	/* works best with devtmpfs */
 #define CDNS_UART_NR_PORTS	16
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
@@ -1132,6 +1133,8 @@ static const struct uart_ops cdns_uart_ops = {
 #endif
 };
 
+static struct uart_driver cdns_uart_uart_driver;
+
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
  * cdns_uart_console_putchar - write the character to the FIFO buffer
@@ -1271,6 +1274,16 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
+
+static struct console cdns_uart_console = {
+	.name	= CDNS_UART_TTY_NAME,
+	.write	= cdns_uart_console_write,
+	.device	= uart_console_device,
+	.setup	= cdns_uart_console_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1, /* Specified on the cmdline (e.g. console=ttyPS ) */
+	.data	= &cdns_uart_uart_driver,
+};
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
 #ifdef CONFIG_PM_SLEEP
@@ -1402,6 +1415,9 @@ static const struct of_device_id cdns_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 
+/* Temporary variable for storing number of instances */
+static int instances;
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1415,11 +1431,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct cdns_uart *cdns_uart_data;
 	const struct of_device_id *match;
-	struct uart_driver *cdns_uart_uart_driver;
-	char *driver_name;
-#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-	struct console *cdns_uart_console;
-#endif
 
 	cdns_uart_data = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_data),
 			GFP_KERNEL);
@@ -1429,12 +1440,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	cdns_uart_uart_driver = devm_kzalloc(&pdev->dev,
-					     sizeof(*cdns_uart_uart_driver),
-					     GFP_KERNEL);
-	if (!cdns_uart_uart_driver)
-		return -ENOMEM;
-
 	/* Look for a serialN alias */
 	id = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (id < 0)
@@ -1445,50 +1450,25 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* There is a need to use unique driver name */
-	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
-				     CDNS_UART_NAME, id);
-	if (!driver_name)
-		return -ENOMEM;
-
-	cdns_uart_uart_driver->owner = THIS_MODULE;
-	cdns_uart_uart_driver->driver_name = driver_name;
-	cdns_uart_uart_driver->dev_name	= CDNS_UART_TTY_NAME;
-	cdns_uart_uart_driver->major = CDNS_UART_MAJOR;
-	cdns_uart_uart_driver->minor = id;
-	cdns_uart_uart_driver->nr = 1;
-
+	if (!cdns_uart_uart_driver.state) {
+		cdns_uart_uart_driver.owner = THIS_MODULE;
+		cdns_uart_uart_driver.driver_name = CDNS_UART_NAME;
+		cdns_uart_uart_driver.dev_name = CDNS_UART_TTY_NAME;
+		cdns_uart_uart_driver.major = CDNS_UART_MAJOR;
+		cdns_uart_uart_driver.minor = CDNS_UART_MINOR;
+		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS;
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-	cdns_uart_console = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_console),
-					 GFP_KERNEL);
-	if (!cdns_uart_console)
-		return -ENOMEM;
-
-	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
-		sizeof(cdns_uart_console->name));
-	cdns_uart_console->index = id;
-	cdns_uart_console->write = cdns_uart_console_write;
-	cdns_uart_console->device = uart_console_device;
-	cdns_uart_console->setup = cdns_uart_console_setup;
-	cdns_uart_console->flags = CON_PRINTBUFFER;
-	cdns_uart_console->data = cdns_uart_uart_driver;
-	cdns_uart_uart_driver->cons = cdns_uart_console;
+		cdns_uart_uart_driver.cons = &cdns_uart_console;
 #endif
 
-	rc = uart_register_driver(cdns_uart_uart_driver);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "Failed to register driver\n");
-		return rc;
+		rc = uart_register_driver(&cdns_uart_uart_driver);
+		if (rc < 0) {
+			dev_err(&pdev->dev, "Failed to register driver\n");
+			return rc;
+		}
 	}
 
-	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
-
-	/*
-	 * Setting up proper name_base needs to be done after uart
-	 * registration because tty_driver structure is not filled.
-	 * name_base is 0 by default.
-	 */
-	cdns_uart_uart_driver->tty_driver->name_base = id;
+	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
@@ -1566,6 +1546,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->ops	= &cdns_uart_ops;
 	port->fifosize	= CDNS_UART_FIFO_SIZE;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_XILINX_PS_UART_CONSOLE);
+	port->line	= id;
 
 	/*
 	 * Register the port.
@@ -1597,7 +1578,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = port;
 #endif
 
-	rc = uart_add_one_port(cdns_uart_uart_driver, port);
+	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
 	if (rc) {
 		dev_err(&pdev->dev,
 			"uart_add_one_port() failed; err=%i\n", rc);
@@ -1607,12 +1588,15 @@ static int cdns_uart_probe(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
 	if (console_port == port &&
-	    !(cdns_uart_uart_driver->cons->flags & CON_ENABLED))
+	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
 	cdns_uart_data->cts_override = of_property_read_bool(pdev->dev.of_node,
 							     "cts-override");
+
+	instances++;
+
 	return 0;
 
 err_out_pm_disable:
@@ -1628,8 +1612,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 err_out_clk_dis_pclk:
 	clk_disable_unprepare(cdns_uart_data->pclk);
 err_out_unregister_driver:
-	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
-
+	if (!instances)
+		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
 
@@ -1664,7 +1648,8 @@ static int cdns_uart_remove(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
-	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
+	if (!--instances)
+		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
 
-- 
2.26.0

