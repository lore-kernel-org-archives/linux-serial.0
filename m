Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240CBC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 30 Nov 2022 10:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiK3K42 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Nov 2022 05:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiK3K40 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Nov 2022 05:56:26 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC81758B
        for <linux-serial@vger.kernel.org>; Wed, 30 Nov 2022 02:56:22 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6495E3F326
        for <linux-serial@vger.kernel.org>; Wed, 30 Nov 2022 10:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669805780;
        bh=DyimTsGicnIOXyJxTp612vWAngQAXfJDawR7jdgxSVE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=EV8QM5qpTtj4mCdLCOpXIMF8+fnd3PewyfX7a9AhERKUrX7Ng6tVbpTGE9C12OceL
         j8FVxZgX2E+12M6ifbe5j5W251ET+bAsRNovPKqBvwP3rAtFE5RQDn/L4u7iAAGbfd
         mkrHvC1cM4IM3dq1Epz0rkmMHKcmPaCBn+KsNtdHblBbYmyscjQI/G6Fq7OxMVddPv
         3HAnt3ge15U5B4tAVblNer0gR5/avyaWFqzzb6fZSE+obnOsBrgdhQ5Y7WQ42ru6g3
         szaTbY/PKkrzUncp9wh+w5950BE1ecvx4p/W1kQ+YvnQKRiES4esD+Fck2h1gv83OO
         ncXA5yRdQH+FQ==
Received: by mail-ed1-f72.google.com with SMTP id x4-20020a05640226c400b0046bca29215eso366635edd.7
        for <linux-serial@vger.kernel.org>; Wed, 30 Nov 2022 02:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyimTsGicnIOXyJxTp612vWAngQAXfJDawR7jdgxSVE=;
        b=OaWdkJ54EfFE5naqy1GmLht2a9B+C6MwEVSifjRGCu1kRGd5/Wr5w1/arW2Woz8f9M
         DFC+RdHmBEy3wy3mDUTdVB3DBRtV8FH0XRYbTe6+vUl0/7RdtrsIKKAOPsQBDBCGWzBo
         4huYbw+r0z8EHfwddjzNWs7mW9ivk7ktm0IoueXoANnmPL66+KLAxZCmfJk1nmLTA2Ns
         M/HvBUTlltQ6My1nqirAGbSq0VbNQyI458tID2PKsAylRtV5gLjH0/OA5dYXZEdaFOLJ
         J1wN4AqwNdmaUZGl9230BsMzRp3dqJF5J6jPeMLTy4VmCpkRsii6VPtecXHwndYz4r/3
         8JRA==
X-Gm-Message-State: ANoB5pliiooSXW1OFn50gs+2dY9CKP+PfJ+nhjg6YMNDlsKNCFZofWsf
        NM92nfQhxsvhu+OFmEyni/mYnFKfBY1zqQWSq/hXMumTm08WAlxV2AJHH8v5B3h/71rrYM9g22E
        6m3mb7DJ+2Bxg7hGGiCYYC2rh+TplY8sD+rJTP7K3FA==
X-Received: by 2002:a17:907:11c5:b0:7b1:316c:38f7 with SMTP id va5-20020a17090711c500b007b1316c38f7mr52813401ejb.387.1669805779859;
        Wed, 30 Nov 2022 02:56:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7AEfKvCO4mUUHPLkMKip3v0WPDpcafAk3qN3uzgOhRCsG8xOanG+HE2L3zpdHE4w+q5Naamw==
X-Received: by 2002:a17:907:11c5:b0:7b1:316c:38f7 with SMTP id va5-20020a17090711c500b007b1316c38f7mr52813388ejb.387.1669805779528;
        Wed, 30 Nov 2022 02:56:19 -0800 (PST)
Received: from localhost.localdomain (cm-2096.cable.globalnet.hr. [213.149.62.97])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090632c200b0078db18d7972sm496903ejk.117.2022.11.30.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:56:19 -0800 (PST)
From:   Isaac True <isaac.true@canonical.com>
To:     linux-serial@vger.kernel.org
Cc:     Isaac True <isaac.true@canonical.com>,
        Wen-chien Jesse Sung <jesse.sung@canonical.com>
Subject: [PATCH] serial: sc16is7xx: setup GPIO controller later in probe
Date:   Wed, 30 Nov 2022 11:55:30 +0100
Message-Id: <20221130105529.698385-1-isaac.true@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The GPIO controller component of the sc16is7xx driver is setup too
early, which can result in a race condition where another device tries
to utilise the GPIO lines before the sc16is7xx device has finished
initialising.

This issue manifests itself as an Oops when the GPIO lines are configured:

    Unable to handle kernel read from unreadable memory at virtual address
    ...
    pc : sc16is7xx_gpio_direction_output+0x68/0x108 [sc16is7xx]
    lr : sc16is7xx_gpio_direction_output+0x4c/0x108 [sc16is7xx]
    ...
    Call trace:
    sc16is7xx_gpio_direction_output+0x68/0x108 [sc16is7xx]
    gpiod_direction_output_raw_commit+0x64/0x318
    gpiod_direction_output+0xb0/0x170
    create_gpio_led+0xec/0x198
    gpio_led_probe+0x16c/0x4f0
    platform_drv_probe+0x5c/0xb0
    really_probe+0xe8/0x448
    driver_probe_device+0xe8/0x138
    __device_attach_driver+0x94/0x118
    bus_for_each_drv+0x8c/0xe0
    __device_attach+0x100/0x1b8
    device_initial_probe+0x28/0x38
    bus_probe_device+0xa4/0xb0
    deferred_probe_work_func+0x90/0xe0
    process_one_work+0x1c4/0x480
    worker_thread+0x54/0x430
    kthread+0x138/0x150
    ret_from_fork+0x10/0x1c

This patch moves the setup of the GPIO controller functions to later in the
probe function, ensuring the sc16is7xx device has already finished
initialising by the time other devices try to make use of the GPIO lines.
The error handling has also been reordered to reflect the new
initialisation order.

Co-developed-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Signed-off-by: Isaac True <isaac.true@canonical.com>
---
 drivers/tty/serial/sc16is7xx.c | 51 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 524921360ca7..93cf5f788817 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1426,25 +1426,6 @@ static int sc16is7xx_probe(struct device *dev,
 	}
 	sched_set_fifo(s->kworker_task);
 
-#ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio) {
-		/* Setup GPIO cotroller */
-		s->gpio.owner		 = THIS_MODULE;
-		s->gpio.parent		 = dev;
-		s->gpio.label		 = dev_name(dev);
-		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
-		s->gpio.get		 = sc16is7xx_gpio_get;
-		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
-		s->gpio.set		 = sc16is7xx_gpio_set;
-		s->gpio.base		 = -1;
-		s->gpio.ngpio		 = devtype->nr_gpio;
-		s->gpio.can_sleep	 = 1;
-		ret = gpiochip_add_data(&s->gpio, s);
-		if (ret)
-			goto out_thread;
-	}
-#endif
-
 	/* reset device, purging any pending irq / data */
 	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
 			SC16IS7XX_IOCONTROL_SRESET_BIT);
@@ -1521,6 +1502,25 @@ static int sc16is7xx_probe(struct device *dev,
 				s->p[u].irda_mode = true;
 	}
 
+#ifdef CONFIG_GPIOLIB
+	if (devtype->nr_gpio) {
+		/* Setup GPIO cotroller */
+		s->gpio.owner		 = THIS_MODULE;
+		s->gpio.parent		 = dev;
+		s->gpio.label		 = dev_name(dev);
+		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
+		s->gpio.get		 = sc16is7xx_gpio_get;
+		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
+		s->gpio.set		 = sc16is7xx_gpio_set;
+		s->gpio.base		 = -1;
+		s->gpio.ngpio		 = devtype->nr_gpio;
+		s->gpio.can_sleep	 = 1;
+		ret = gpiochip_add_data(&s->gpio, s);
+		if (ret)
+			goto out_thread;
+	}
+#endif
+
 	/*
 	 * Setup interrupt. We first try to acquire the IRQ line as level IRQ.
 	 * If that succeeds, we can allow sharing the interrupt as well.
@@ -1540,18 +1540,19 @@ static int sc16is7xx_probe(struct device *dev,
 	if (!ret)
 		return 0;
 
-out_ports:
-	for (i--; i >= 0; i--) {
-		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
-		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
-	}
-
 #ifdef CONFIG_GPIOLIB
 	if (devtype->nr_gpio)
 		gpiochip_remove(&s->gpio);
 
 out_thread:
 #endif
+
+out_ports:
+	for (i--; i >= 0; i--) {
+		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
+		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
+	}
+
 	kthread_stop(s->kworker_task);
 
 out_clk:
-- 
2.37.2

