Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F4DC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CB960EBD
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhGWHCv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:02:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59148 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbhGWHCt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:02:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 85D8A1FF64;
        Fri, 23 Jul 2021 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627026201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHHqgSA+5+vJdxCMl6tUjSj6k9Xer6y3hN4cn+5i+Ig=;
        b=jBIPTJbYGNR20NPo495yvhQS4dd0qoAmxkLjweLz4A6ajgAuSReucZr6z40mn+pPQUR4JH
        V4Rcd+d15HvEDe01KktN+QqY03S7NU6bFO/M+R7axmYaIRAy+3YOK/Wl/imIIoqZfO6o0T
        G9L3F/r/RU71xnsqcgEbhnMzRrRwP6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627026201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHHqgSA+5+vJdxCMl6tUjSj6k9Xer6y3hN4cn+5i+Ig=;
        b=7R1GujrtwpMOc+UnCe1sKvCChYneDiV2wWnetrwH+sL8U0lhPqVon6ts/U1VEqpZ+IYvPb
        AKQA+S/uC4OmfcAw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AB53FA3B93;
        Fri, 23 Jul 2021 07:43:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 7/8] tty: drop put_tty_driver
Date:   Fri, 23 Jul 2021 09:43:16 +0200
Message-Id: <20210723074317.32690-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723074317.32690-1-jslaby@suse.cz>
References: <20210723074317.32690-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

put_tty_driver() is an alias for tty_driver_kref_put(). There is no need
for two exported identical functions, therefore switch all users of
old put_tty_driver() to new tty_driver_kref_put() and remove the former
for good.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Lin <dtwlin@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
---
 arch/alpha/kernel/srmcons.c            | 2 +-
 arch/m68k/emu/nfcon.c                  | 4 ++--
 arch/um/drivers/line.c                 | 2 +-
 arch/xtensa/platforms/iss/console.c    | 2 +-
 drivers/char/pcmcia/synclink_cs.c      | 4 ++--
 drivers/char/ttyprintk.c               | 4 ++--
 drivers/ipack/devices/ipoctal.c        | 4 ++--
 drivers/isdn/capi/capi.c               | 4 ++--
 drivers/misc/bcm-vk/bcm_vk_tty.c       | 8 ++++----
 drivers/mmc/core/sdio_uart.c           | 4 ++--
 drivers/net/usb/hso.c                  | 4 ++--
 drivers/s390/char/con3215.c            | 4 ++--
 drivers/s390/char/sclp_tty.c           | 8 ++++----
 drivers/s390/char/sclp_vt220.c         | 2 +-
 drivers/s390/char/tty3270.c            | 4 ++--
 drivers/staging/fwserial/fwserial.c    | 8 ++++----
 drivers/staging/gdm724x/gdm_tty.c      | 4 ++--
 drivers/staging/greybus/uart.c         | 4 ++--
 drivers/tty/amiserial.c                | 8 ++++----
 drivers/tty/ehv_bytechan.c             | 6 +++---
 drivers/tty/goldfish.c                 | 4 ++--
 drivers/tty/hvc/hvc_console.c          | 2 +-
 drivers/tty/hvc/hvcs.c                 | 4 ++--
 drivers/tty/ipwireless/tty.c           | 4 ++--
 drivers/tty/mips_ejtag_fdc.c           | 2 +-
 drivers/tty/moxa.c                     | 4 ++--
 drivers/tty/mxser.c                    | 4 ++--
 drivers/tty/n_gsm.c                    | 4 ++--
 drivers/tty/nozomi.c                   | 4 ++--
 drivers/tty/serial/kgdb_nmi.c          | 4 ++--
 drivers/tty/serial/serial_core.c       | 4 ++--
 drivers/tty/synclink_gt.c              | 4 ++--
 drivers/tty/tty_io.c                   | 6 ------
 drivers/tty/ttynull.c                  | 4 ++--
 drivers/tty/vcc.c                      | 4 ++--
 drivers/usb/class/cdc-acm.c            | 6 +++---
 drivers/usb/gadget/function/u_serial.c | 4 ++--
 drivers/usb/host/xhci-dbgtty.c         | 4 ++--
 drivers/usb/serial/usb-serial.c        | 4 ++--
 include/linux/tty_driver.h             | 1 -
 net/bluetooth/rfcomm/tty.c             | 4 ++--
 41 files changed, 82 insertions(+), 89 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index d0a1b08d851d..90635ef5dafa 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -221,7 +221,7 @@ srmcons_init(void)
 		tty_port_link_device(&srmcons_singleton.port, driver, 0);
 		err = tty_register_driver(driver);
 		if (err) {
-			put_tty_driver(driver);
+			tty_driver_kref_put(driver);
 			tty_port_destroy(&srmcons_singleton.port);
 			return err;
 		}
diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index b3b64d03bad6..557d60867f98 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -144,7 +144,7 @@ static int __init nfcon_init(void)
 	res = tty_register_driver(driver);
 	if (res) {
 		pr_err("failed to register nfcon tty driver\n");
-		put_tty_driver(driver);
+		tty_driver_kref_put(driver);
 		tty_port_destroy(&nfcon_tty_port);
 		return res;
 	}
@@ -161,7 +161,7 @@ static void __exit nfcon_exit(void)
 {
 	unregister_console(&nf_console);
 	tty_unregister_driver(nfcon_tty_driver);
-	put_tty_driver(nfcon_tty_driver);
+	tty_driver_kref_put(nfcon_tty_driver);
 	tty_port_destroy(&nfcon_tty_port);
 }
 
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 0d8f4ee6335d..8febf95da96e 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -568,7 +568,7 @@ int register_lines(struct line_driver *line_driver,
 	if (err) {
 		printk(KERN_ERR "register_lines : can't register %s driver\n",
 		       line_driver->name);
-		put_tty_driver(driver);
+		tty_driver_kref_put(driver);
 		for (i = 0; i < nlines; i++)
 			tty_port_destroy(&lines[i].port);
 		return err;
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 0b8a0565cdfd..81f988914d9a 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -178,7 +178,7 @@ static int __init rs_init(void)
 static __exit void rs_exit(void)
 {
 	tty_unregister_driver(serial_driver);
-	put_tty_driver(serial_driver);
+	tty_driver_kref_put(serial_driver);
 	tty_port_destroy(&serial_port);
 }
 
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 6eaefea0520e..fd78d5856841 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -2841,7 +2841,7 @@ static int __init synclink_cs_init(void)
 err_unreg_tty:
 	tty_unregister_driver(serial_driver);
 err_put_tty:
-	put_tty_driver(serial_driver);
+	tty_driver_kref_put(serial_driver);
 err:
 	return rc;
 }
@@ -2850,7 +2850,7 @@ static void __exit synclink_cs_exit(void)
 {
 	pcmcia_unregister_driver(&mgslpc_driver);
 	tty_unregister_driver(serial_driver);
-	put_tty_driver(serial_driver);
+	tty_driver_kref_put(serial_driver);
 }
 
 module_init(synclink_cs_init);
diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 230b2c9b3e3c..adf941c47506 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -198,7 +198,7 @@ static int __init ttyprintk_init(void)
 	return 0;
 
 error:
-	put_tty_driver(ttyprintk_driver);
+	tty_driver_kref_put(ttyprintk_driver);
 	tty_port_destroy(&tpk_port.port);
 	return ret;
 }
@@ -206,7 +206,7 @@ static int __init ttyprintk_init(void)
 static void __exit ttyprintk_exit(void)
 {
 	tty_unregister_driver(ttyprintk_driver);
-	put_tty_driver(ttyprintk_driver);
+	tty_driver_kref_put(ttyprintk_driver);
 	tty_port_destroy(&tpk_port.port);
 }
 
diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index be6d11f46e62..c14e65a5d38f 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -371,7 +371,7 @@ static int ipoctal_inst_slot(struct ipoctal *ipoctal, unsigned int bus_nr,
 	res = tty_register_driver(tty);
 	if (res) {
 		dev_err(&ipoctal->dev->dev, "Can't register tty driver.\n");
-		put_tty_driver(tty);
+		tty_driver_kref_put(tty);
 		return res;
 	}
 
@@ -696,7 +696,7 @@ static void __ipoctal_remove(struct ipoctal *ipoctal)
 	}
 
 	tty_unregister_driver(ipoctal->tty_drv);
-	put_tty_driver(ipoctal->tty_drv);
+	tty_driver_kref_put(ipoctal->tty_drv);
 	kfree(ipoctal);
 }
 
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 32abf4d15450..0f00be62438d 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1290,7 +1290,7 @@ static int __init capinc_tty_init(void)
 
 	err = tty_register_driver(drv);
 	if (err) {
-		put_tty_driver(drv);
+		tty_driver_kref_put(drv);
 		kfree(capiminors);
 		printk(KERN_ERR "Couldn't register capi_nc driver\n");
 		return err;
@@ -1302,7 +1302,7 @@ static int __init capinc_tty_init(void)
 static void __exit capinc_tty_exit(void)
 {
 	tty_unregister_driver(capinc_tty_driver);
-	put_tty_driver(capinc_tty_driver);
+	tty_driver_kref_put(capinc_tty_driver);
 	kfree(capiminors);
 }
 
diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
index dae9eeed84a2..1b6076a89ca6 100644
--- a/drivers/misc/bcm-vk/bcm_vk_tty.c
+++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
@@ -249,7 +249,7 @@ int bcm_vk_tty_init(struct bcm_vk *vk, char *name)
 	tty_drv->name = kstrdup(name, GFP_KERNEL);
 	if (!tty_drv->name) {
 		err = -ENOMEM;
-		goto err_put_tty_driver;
+		goto err_tty_driver_kref_put;
 	}
 	tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
 	tty_drv->subtype = SERIAL_TYPE_NORMAL;
@@ -295,8 +295,8 @@ int bcm_vk_tty_init(struct bcm_vk *vk, char *name)
 	kfree(tty_drv->name);
 	tty_drv->name = NULL;
 
-err_put_tty_driver:
-	put_tty_driver(tty_drv);
+err_tty_driver_kref_put:
+	tty_driver_kref_put(tty_drv);
 
 	return err;
 }
@@ -317,7 +317,7 @@ void bcm_vk_tty_exit(struct bcm_vk *vk)
 	kfree(vk->tty_drv->name);
 	vk->tty_drv->name = NULL;
 
-	put_tty_driver(vk->tty_drv);
+	tty_driver_kref_put(vk->tty_drv);
 }
 
 void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk)
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 04a57832e486..04c0823e0359 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -1165,7 +1165,7 @@ static int __init sdio_uart_init(void)
 err2:
 	tty_unregister_driver(tty_drv);
 err1:
-	put_tty_driver(tty_drv);
+	tty_driver_kref_put(tty_drv);
 	return ret;
 }
 
@@ -1173,7 +1173,7 @@ static void __exit sdio_uart_exit(void)
 {
 	sdio_unregister_driver(&sdio_uart_driver);
 	tty_unregister_driver(sdio_uart_tty_driver);
-	put_tty_driver(sdio_uart_tty_driver);
+	tty_driver_kref_put(sdio_uart_tty_driver);
 }
 
 module_init(sdio_uart_init);
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 29df4b34e002..d4cc5bc425c3 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -3282,7 +3282,7 @@ static int __init hso_init(void)
 err_unreg_tty:
 	tty_unregister_driver(tty_drv);
 err_free_tty:
-	put_tty_driver(tty_drv);
+	tty_driver_kref_put(tty_drv);
 	return result;
 }
 
@@ -3293,7 +3293,7 @@ static void __exit hso_exit(void)
 	tty_unregister_driver(tty_drv);
 	/* deregister the usb driver */
 	usb_deregister(&hso_driver);
-	put_tty_driver(tty_drv);
+	tty_driver_kref_put(tty_drv);
 }
 
 /* Module definitions */
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 3818a89aef5c..f356607835d8 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -1082,7 +1082,7 @@ static int __init tty3215_init(void)
 
 	ret = ccw_driver_register(&raw3215_ccw_driver);
 	if (ret) {
-		put_tty_driver(driver);
+		tty_driver_kref_put(driver);
 		return ret;
 	}
 	/*
@@ -1104,7 +1104,7 @@ static int __init tty3215_init(void)
 	tty_set_operations(driver, &tty3215_ops);
 	ret = tty_register_driver(driver);
 	if (ret) {
-		put_tty_driver(driver);
+		tty_driver_kref_put(driver);
 		return ret;
 	}
 	tty3215_driver = driver;
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 48790f8fb3b1..971fbb52740b 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -509,14 +509,14 @@ sclp_tty_init(void)
 
 	rc = sclp_rw_init();
 	if (rc) {
-		put_tty_driver(driver);
+		tty_driver_kref_put(driver);
 		return rc;
 	}
 	/* Allocate pages for output buffering */
 	for (i = 0; i < MAX_KMEM_PAGES; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 		if (page == NULL) {
-			put_tty_driver(driver);
+			tty_driver_kref_put(driver);
 			return -ENOMEM;
 		}
 		list_add_tail((struct list_head *) page, &sclp_tty_pages);
@@ -532,7 +532,7 @@ sclp_tty_init(void)
 
 	rc = sclp_register(&sclp_input_event);
 	if (rc) {
-		put_tty_driver(driver);
+		tty_driver_kref_put(driver);
 		return rc;
 	}
 
@@ -552,7 +552,7 @@ sclp_tty_init(void)
 	tty_port_link_device(&sclp_port, driver, 0);
 	rc = tty_register_driver(driver);
 	if (rc) {
-		put_tty_driver(driver);
+		tty_driver_kref_put(driver);
 		tty_port_destroy(&sclp_port);
 		return rc;
 	}
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index c6a7ea32aa5c..29a6a0099f83 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -763,7 +763,7 @@ static int __init sclp_vt220_tty_init(void)
 out_init:
 	__sclp_vt220_cleanup();
 out_driver:
-	put_tty_driver(driver);
+	tty_driver_kref_put(driver);
 	return rc;
 }
 __initcall(sclp_vt220_tty_init);
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index adc33846bf8e..5c83f71c1d0e 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1935,7 +1935,7 @@ static int __init tty3270_init(void)
 	tty_set_operations(driver, &tty3270_ops);
 	ret = tty_register_driver(driver);
 	if (ret) {
-		put_tty_driver(driver);
+		tty_driver_kref_put(driver);
 		return ret;
 	}
 	tty3270_driver = driver;
@@ -1952,7 +1952,7 @@ tty3270_exit(void)
 	driver = tty3270_driver;
 	tty3270_driver = NULL;
 	tty_unregister_driver(driver);
-	put_tty_driver(driver);
+	tty_driver_kref_put(driver);
 	tty3270_del_views();
 }
 
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 38a280e876c2..e8fa7f53cd5e 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -2852,11 +2852,11 @@ static int __init fwserial_init(void)
 		tty_unregister_driver(fwloop_driver);
 put_loop:
 	if (create_loop_dev)
-		put_tty_driver(fwloop_driver);
+		tty_driver_kref_put(fwloop_driver);
 unregister_driver:
 	tty_unregister_driver(fwtty_driver);
 put_tty:
-	put_tty_driver(fwtty_driver);
+	tty_driver_kref_put(fwtty_driver);
 remove_debugfs:
 	debugfs_remove_recursive(fwserial_debugfs);
 
@@ -2871,10 +2871,10 @@ static void __exit fwserial_exit(void)
 	kmem_cache_destroy(fwtty_txn_cache);
 	if (create_loop_dev) {
 		tty_unregister_driver(fwloop_driver);
-		put_tty_driver(fwloop_driver);
+		tty_driver_kref_put(fwloop_driver);
 	}
 	tty_unregister_driver(fwtty_driver);
-	put_tty_driver(fwtty_driver);
+	tty_driver_kref_put(fwtty_driver);
 	debugfs_remove_recursive(fwserial_debugfs);
 }
 
diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 918575417264..04df6f9f5403 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -299,7 +299,7 @@ int register_lte_tty_driver(void)
 
 		ret = tty_register_driver(tty_driver);
 		if (ret) {
-			put_tty_driver(tty_driver);
+			tty_driver_kref_put(tty_driver);
 			return ret;
 		}
 
@@ -318,7 +318,7 @@ void unregister_lte_tty_driver(void)
 		tty_driver = gdm_driver[i];
 		if (tty_driver) {
 			tty_unregister_driver(tty_driver);
-			put_tty_driver(tty_driver);
+			tty_driver_kref_put(tty_driver);
 		}
 	}
 }
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 73f01ed1e5b7..e6d860a9678e 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -973,7 +973,7 @@ static int gb_tty_init(void)
 	return 0;
 
 fail_put_gb_tty:
-	put_tty_driver(gb_tty_driver);
+	tty_driver_kref_put(gb_tty_driver);
 fail_unregister_dev:
 	return retval;
 }
@@ -981,7 +981,7 @@ static int gb_tty_init(void)
 static void gb_tty_exit(void)
 {
 	tty_unregister_driver(gb_tty_driver);
-	put_tty_driver(gb_tty_driver);
+	tty_driver_kref_put(gb_tty_driver);
 	idr_destroy(&tty_minors);
 }
 
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 50f1a54ef35a..1e60dbef676c 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1519,7 +1519,7 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 
 	error = tty_register_driver(driver);
 	if (error)
-		goto fail_put_tty_driver;
+		goto fail_tty_driver_kref_put;
 
 	printk(KERN_INFO "ttyS0 is the amiga builtin serial port\n");
 
@@ -1566,9 +1566,9 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	free_irq(IRQ_AMIGA_TBE, state);
 fail_unregister:
 	tty_unregister_driver(driver);
-fail_put_tty_driver:
+fail_tty_driver_kref_put:
 	tty_port_destroy(&state->tport);
-	put_tty_driver(driver);
+	tty_driver_kref_put(driver);
 	return error;
 }
 
@@ -1577,7 +1577,7 @@ static int __exit amiga_serial_remove(struct platform_device *pdev)
 	struct serial_state *state = platform_get_drvdata(pdev);
 
 	tty_unregister_driver(serial_driver);
-	put_tty_driver(serial_driver);
+	tty_driver_kref_put(serial_driver);
 	tty_port_destroy(&state->tport);
 
 	free_irq(IRQ_AMIGA_TBE, state);
diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index f580a5de3c98..19d32cb6af84 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -791,7 +791,7 @@ static int __init ehv_bc_init(void)
 	ret = tty_register_driver(driver);
 	if (ret) {
 		pr_err("ehv-bc: could not register tty driver (ret=%i)\n", ret);
-		goto err_put_tty_driver;
+		goto err_tty_driver_kref_put;
 	}
 
 	ehv_bc_driver = driver;
@@ -808,8 +808,8 @@ static int __init ehv_bc_init(void)
 err_deregister_tty_driver:
 	ehv_bc_driver = NULL;
 	tty_unregister_driver(driver);
-err_put_tty_driver:
-	put_tty_driver(driver);
+err_tty_driver_kref_put:
+	tty_driver_kref_put(driver);
 err_free_bcs:
 	kfree(bcs);
 
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 853083fcebb8..d24af649a8bb 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -274,7 +274,7 @@ static int goldfish_tty_create_driver(void)
 	return 0;
 
 err_tty_register_driver_failed:
-	put_tty_driver(tty);
+	tty_driver_kref_put(tty);
 err_tty_alloc_driver_failed:
 	kfree(goldfish_ttys);
 	goldfish_ttys = NULL;
@@ -285,7 +285,7 @@ static int goldfish_tty_create_driver(void)
 static void goldfish_tty_delete_driver(void)
 {
 	tty_unregister_driver(goldfish_tty_driver);
-	put_tty_driver(goldfish_tty_driver);
+	tty_driver_kref_put(goldfish_tty_driver);
 	goldfish_tty_driver = NULL;
 	kfree(goldfish_ttys);
 	goldfish_ttys = NULL;
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 9215dd4bd9f0..7b30d5a05e2f 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -1063,7 +1063,7 @@ static int hvc_init(void)
 	kthread_stop(hvc_task);
 	hvc_task = NULL;
 put_tty:
-	put_tty_driver(drv);
+	tty_driver_kref_put(drv);
 out:
 	return err;
 }
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 23aebc964201..245da1dfd818 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1509,7 +1509,7 @@ static int hvcs_initialize(void)
 register_fail:
 	hvcs_free_index_list();
 index_fail:
-	put_tty_driver(hvcs_tty_driver);
+	tty_driver_kref_put(hvcs_tty_driver);
 	hvcs_tty_driver = NULL;
 	mutex_unlock(&hvcs_init_mutex);
 	return rc;
@@ -1562,7 +1562,7 @@ static void __exit hvcs_module_exit(void)
 
 	hvcs_free_index_list();
 
-	put_tty_driver(hvcs_tty_driver);
+	tty_driver_kref_put(hvcs_tty_driver);
 
 	printk(KERN_INFO "HVCS: driver module removed.\n");
 }
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index d24404c222e0..9edd5ae17580 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -585,7 +585,7 @@ int ipwireless_tty_init(void)
 	if (result) {
 		printk(KERN_ERR IPWIRELESS_PCCARD_NAME
 		       ": failed to register tty driver\n");
-		put_tty_driver(ipw_tty_driver);
+		tty_driver_kref_put(ipw_tty_driver);
 		return result;
 	}
 
@@ -595,7 +595,7 @@ int ipwireless_tty_init(void)
 void ipwireless_tty_release(void)
 {
 	tty_unregister_driver(ipw_tty_driver);
-	put_tty_driver(ipw_tty_driver);
+	tty_driver_kref_put(ipw_tty_driver);
 }
 
 int ipwireless_tty_is_modem(struct ipw_tty *tty)
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 3b5915b94fac..02c10a968de1 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -1042,7 +1042,7 @@ static int mips_ejtag_fdc_tty_probe(struct mips_cdmm_device *dev)
 		dport = &priv->ports[nport];
 		tty_port_destroy(&dport->port);
 	}
-	put_tty_driver(priv->driver);
+	tty_driver_kref_put(priv->driver);
 	return ret;
 }
 
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 64b18177c790..776f78de0f82 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1053,7 +1053,7 @@ static int __init moxa_init(void)
 
 	if (tty_register_driver(moxaDriver)) {
 		printk(KERN_ERR "can't register MOXA Smartio tty driver!\n");
-		put_tty_driver(moxaDriver);
+		tty_driver_kref_put(moxaDriver);
 		return -1;
 	}
 
@@ -1119,7 +1119,7 @@ static void __exit moxa_exit(void)
 	del_timer_sync(&moxaTimer);
 
 	tty_unregister_driver(moxaDriver);
-	put_tty_driver(moxaDriver);
+	tty_driver_kref_put(moxaDriver);
 }
 
 module_init(moxa_init);
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 650fc6fac88e..335e4e50d679 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2008,7 +2008,7 @@ static int __init mxser_module_init(void)
 err_unr:
 	tty_unregister_driver(mxvar_sdriver);
 err_put:
-	put_tty_driver(mxvar_sdriver);
+	tty_driver_kref_put(mxvar_sdriver);
 	return retval;
 }
 
@@ -2016,7 +2016,7 @@ static void __exit mxser_module_exit(void)
 {
 	pci_unregister_driver(&mxser_driver);
 	tty_unregister_driver(mxvar_sdriver);
-	put_tty_driver(mxvar_sdriver);
+	tty_driver_kref_put(mxvar_sdriver);
 }
 
 module_init(mxser_module_init);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0308669c21c6..1d92d2a84889 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3279,7 +3279,7 @@ static int __init gsm_init(void)
 			gsm_tty_driver->major, gsm_tty_driver->minor_start);
 	return 0;
 err_put_driver:
-	put_tty_driver(gsm_tty_driver);
+	tty_driver_kref_put(gsm_tty_driver);
 err_unreg_ldisc:
 	tty_unregister_ldisc(&tty_ldisc_packet);
 	return status;
@@ -3289,7 +3289,7 @@ static void __exit gsm_exit(void)
 {
 	tty_unregister_ldisc(&tty_ldisc_packet);
 	tty_unregister_driver(gsm_tty_driver);
-	put_tty_driver(gsm_tty_driver);
+	tty_driver_kref_put(gsm_tty_driver);
 }
 
 module_init(gsm_init);
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index f3eb0aaec79b..0454c78deee6 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1857,7 +1857,7 @@ static __init int nozomi_init(void)
 unr_tty:
 	tty_unregister_driver(ntty_driver);
 free_tty:
-	put_tty_driver(ntty_driver);
+	tty_driver_kref_put(ntty_driver);
 	return ret;
 }
 
@@ -1865,7 +1865,7 @@ static __exit void nozomi_exit(void)
 {
 	pci_unregister_driver(&nozomi_driver);
 	tty_unregister_driver(ntty_driver);
-	put_tty_driver(ntty_driver);
+	tty_driver_kref_put(ntty_driver);
 }
 
 module_init(nozomi_init);
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 9209573a7e37..55c3c9db7462 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -355,7 +355,7 @@ int kgdb_register_nmi_console(void)
 
 	return 0;
 err_drv_reg:
-	put_tty_driver(kgdb_nmi_tty_driver);
+	tty_driver_kref_put(kgdb_nmi_tty_driver);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kgdb_register_nmi_console);
@@ -373,7 +373,7 @@ int kgdb_unregister_nmi_console(void)
 		return ret;
 
 	tty_unregister_driver(kgdb_nmi_tty_driver);
-	put_tty_driver(kgdb_nmi_tty_driver);
+	tty_driver_kref_put(kgdb_nmi_tty_driver);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b03a883a21c5..17a6c2f4d806 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2560,7 +2560,7 @@ int uart_register_driver(struct uart_driver *drv)
 
 	for (i = 0; i < drv->nr; i++)
 		tty_port_destroy(&drv->state[i].port);
-	put_tty_driver(normal);
+	tty_driver_kref_put(normal);
 out_kfree:
 	kfree(drv->state);
 out:
@@ -2582,7 +2582,7 @@ void uart_unregister_driver(struct uart_driver *drv)
 	unsigned int i;
 
 	tty_unregister_driver(p);
-	put_tty_driver(p);
+	tty_driver_kref_put(p);
 	for (i = 0; i < drv->nr; i++)
 		tty_port_destroy(&drv->state[i].port);
 	kfree(drv->state);
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 525f3a568c32..c89f7de38d12 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3650,7 +3650,7 @@ static void slgt_cleanup(void)
 		for (info=slgt_device_list ; info != NULL ; info=info->next_device)
 			tty_unregister_device(serial_driver, info->line);
 		tty_unregister_driver(serial_driver);
-		put_tty_driver(serial_driver);
+		tty_driver_kref_put(serial_driver);
 	}
 
 	/* reset devices */
@@ -3712,7 +3712,7 @@ static int __init slgt_init(void)
 	tty_set_operations(serial_driver, &ops);
 	if ((rc = tty_register_driver(serial_driver)) < 0) {
 		DBGERR(("%s can't register serial driver\n", driver_name));
-		put_tty_driver(serial_driver);
+		tty_driver_kref_put(serial_driver);
 		serial_driver = NULL;
 		goto error;
 	}
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 16e3fce6f88d..e8532006e960 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3438,12 +3438,6 @@ void tty_driver_kref_put(struct tty_driver *driver)
 }
 EXPORT_SYMBOL(tty_driver_kref_put);
 
-void put_tty_driver(struct tty_driver *d)
-{
-	tty_driver_kref_put(d);
-}
-EXPORT_SYMBOL(put_tty_driver);
-
 /*
  * Called by a tty driver to register itself.
  */
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index af3311a24917..1d4438472442 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -84,7 +84,7 @@ static int __init ttynull_init(void)
 
 	ret = tty_register_driver(driver);
 	if (ret < 0) {
-		put_tty_driver(driver);
+		tty_driver_kref_put(driver);
 		tty_port_destroy(&ttynull_port);
 		return ret;
 	}
@@ -99,7 +99,7 @@ static void __exit ttynull_exit(void)
 {
 	unregister_console(&ttynull_console);
 	tty_unregister_driver(ttynull_driver);
-	put_tty_driver(ttynull_driver);
+	tty_driver_kref_put(ttynull_driver);
 	tty_port_destroy(&ttynull_port);
 }
 
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index d06bcc3b4c07..e11383ae1e7e 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -1028,7 +1028,7 @@ static int vcc_tty_init(void)
 	rv = tty_register_driver(vcc_tty_driver);
 	if (rv) {
 		pr_err("VCC: TTY driver registration failed\n");
-		put_tty_driver(vcc_tty_driver);
+		tty_driver_kref_put(vcc_tty_driver);
 		vcc_tty_driver = NULL;
 		return rv;
 	}
@@ -1041,7 +1041,7 @@ static int vcc_tty_init(void)
 static void vcc_tty_exit(void)
 {
 	tty_unregister_driver(vcc_tty_driver);
-	put_tty_driver(vcc_tty_driver);
+	tty_driver_kref_put(vcc_tty_driver);
 	vccdbg("VCC: TTY driver unregistered\n");
 
 	vcc_tty_driver = NULL;
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index c19b59583d9f..8bbd8e29e60d 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -2044,14 +2044,14 @@ static int __init acm_init(void)
 
 	retval = tty_register_driver(acm_tty_driver);
 	if (retval) {
-		put_tty_driver(acm_tty_driver);
+		tty_driver_kref_put(acm_tty_driver);
 		return retval;
 	}
 
 	retval = usb_register(&acm_driver);
 	if (retval) {
 		tty_unregister_driver(acm_tty_driver);
-		put_tty_driver(acm_tty_driver);
+		tty_driver_kref_put(acm_tty_driver);
 		return retval;
 	}
 
@@ -2064,7 +2064,7 @@ static void __exit acm_exit(void)
 {
 	usb_deregister(&acm_driver);
 	tty_unregister_driver(acm_tty_driver);
-	put_tty_driver(acm_tty_driver);
+	tty_driver_kref_put(acm_tty_driver);
 	idr_destroy(&acm_minors);
 }
 
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 74289f68a2ab..72961c1beeef 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1491,7 +1491,7 @@ static int userial_init(void)
 
 	return status;
 fail:
-	put_tty_driver(driver);
+	tty_driver_kref_put(driver);
 	return status;
 }
 module_init(userial_init);
@@ -1499,7 +1499,7 @@ module_init(userial_init);
 static void userial_cleanup(void)
 {
 	tty_unregister_driver(gs_tty_driver);
-	put_tty_driver(gs_tty_driver);
+	tty_driver_kref_put(gs_tty_driver);
 	gs_tty_driver = NULL;
 }
 module_exit(userial_cleanup);
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index bef104511352..6e784f2fc26d 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -541,7 +541,7 @@ static int dbc_tty_init(void)
 	ret = tty_register_driver(dbc_tty_driver);
 	if (ret) {
 		pr_err("Can't register dbc tty driver\n");
-		put_tty_driver(dbc_tty_driver);
+		tty_driver_kref_put(dbc_tty_driver);
 	}
 	return ret;
 }
@@ -550,7 +550,7 @@ static void dbc_tty_exit(void)
 {
 	if (dbc_tty_driver) {
 		tty_unregister_driver(dbc_tty_driver);
-		put_tty_driver(dbc_tty_driver);
+		tty_driver_kref_put(dbc_tty_driver);
 		dbc_tty_driver = NULL;
 	}
 }
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 2f7855da645f..090a78c948f2 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1366,7 +1366,7 @@ static int __init usb_serial_init(void)
 
 exit_bus:
 	pr_err("%s - returning with error %d\n", __func__, result);
-	put_tty_driver(usb_serial_tty_driver);
+	tty_driver_kref_put(usb_serial_tty_driver);
 	return result;
 }
 
@@ -1378,7 +1378,7 @@ static void __exit usb_serial_exit(void)
 	usb_serial_generic_deregister();
 
 	tty_unregister_driver(usb_serial_tty_driver);
-	put_tty_driver(usb_serial_tty_driver);
+	tty_driver_kref_put(usb_serial_tty_driver);
 	bus_unregister(&usb_serial_bus_type);
 	idr_destroy(&serial_minors);
 }
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 6092ce9180aa..c20431d8def8 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -329,7 +329,6 @@ extern struct list_head tty_drivers;
 
 extern struct tty_driver *__tty_alloc_driver(unsigned int lines,
 		struct module *owner, unsigned long flags);
-extern void put_tty_driver(struct tty_driver *driver);
 extern struct tty_driver *tty_find_polling_driver(char *name, int *line);
 
 extern void tty_driver_kref_put(struct tty_driver *driver);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 8ec0600cd927..ebd78fdbd6e8 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -1146,7 +1146,7 @@ int __init rfcomm_init_ttys(void)
 	error = tty_register_driver(rfcomm_tty_driver);
 	if (error) {
 		BT_ERR("Can't register RFCOMM TTY driver");
-		put_tty_driver(rfcomm_tty_driver);
+		tty_driver_kref_put(rfcomm_tty_driver);
 		return error;
 	}
 
@@ -1158,5 +1158,5 @@ int __init rfcomm_init_ttys(void)
 void rfcomm_cleanup_ttys(void)
 {
 	tty_unregister_driver(rfcomm_tty_driver);
-	put_tty_driver(rfcomm_tty_driver);
+	tty_driver_kref_put(rfcomm_tty_driver);
 }
-- 
2.32.0

