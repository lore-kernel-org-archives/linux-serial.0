Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9810C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 00:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9060923100
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 00:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394701AbgLKA6c (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Dec 2020 19:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394684AbgLKA60 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 19:58:26 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A80C0613D3
        for <linux-serial@vger.kernel.org>; Thu, 10 Dec 2020 16:57:46 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g18so5997850pgk.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Dec 2020 16:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MTuxwf9KusT/ntlnVCF0gMBlWlskbWARxkaUDrHOkdo=;
        b=ra/WyZQoH+AGVlTrKDauhvPdiS00/pxJvs9pj4d37efoZQNZVc+YC1W+GtSV7wDQMv
         3Mvpwy7tvnA3/aqi6p8jyeGn0RiTWUQzE26nqhAEyR6TfToOa6tfqR/WnOi+SIx2rSjl
         /Ps0Va+qa275/zgoJ4ATYKXWrjKpbYdpMxcm7iLqoC+1WKuYLh4B3j95Cz1dvR3hEXEw
         AqPD+8q9+w7dwHS9riwHOjGYOsr05T3IFKZkynpELZtrlObf0jCMlMw/2M4ICCJQGYxr
         d5hGfjj7Q2LHqEf0FebkxA0WQ+JAXOeSrNEh8ZScYqFJn8LIUmGoyRRvZHSe6LWnB/dn
         EVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MTuxwf9KusT/ntlnVCF0gMBlWlskbWARxkaUDrHOkdo=;
        b=ThvZPUvdv62rfAbBSiCAKvoHCJ4o3aiuB5cDATXKKSb74bj3eQf82BLscFatQiAfcS
         QeI6+QwINQl6sg8ar5UYXVzlbctrTb2tp1Yv+nxgMc77L6HNmflAfbor7OvrSJGqhkvR
         BSC6zPaSZtNfkZstuedhx2bprgwedfPqkljelmSWsjCLn7wwILXbfwecItb2Z6XWVGVJ
         SzhNLtQI3kUuDHJlcXD6VMEwiCm3N8gijNyg8Ke+xhOIt6JQlP1nMqPX+xGCNQmAD9Sf
         TvvasDkkhM3iUT2Ow1SrYKQDhK0zwwdcpN95pZdJV2QqfBZKe/VmXccMBqeo/RHJcD2f
         Gnzg==
X-Gm-Message-State: AOAM533hMzSHTWMNFcHiCfGYsXoX8OKDJcWAwuLJFSB/04rnpdwVeLOd
        Rnhg7/n174ww23OwGl0qtIFxzwBH/cBPM3PW
X-Google-Smtp-Source: ABdhPJzfz9YK0z5xQjgX+uIRBOh+PmftuTdjF5WTgFEIpGyktmdOqbLubqsI53pFf5YA0q7+42Rq2g==
X-Received: by 2002:a65:518a:: with SMTP id h10mr9153953pgq.340.1607648265788;
        Thu, 10 Dec 2020 16:57:45 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x6sm6829532pgr.20.2020.12.10.16.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 16:57:45 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support)
Subject: [PATCH] tty: serial: meson: enable console as module
Date:   Thu, 10 Dec 2020 16:57:44 -0800
Message-Id: <20201211005744.12855-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Enable serial driver to be built as a module.  To do so, init the
console support on driver/module load instead of using
console_initcall().

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Yes, I'm well aware that having the serial console as a module makes
devices hard to debug, so I'm not changing any default behavior.  The
goal is just to enable building as a module for environments where
serial debug is not available or needed.

 drivers/tty/serial/Kconfig      | 2 +-
 drivers/tty/serial/meson_uart.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1044fc387691..c3fa78e63357 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -206,7 +206,7 @@ config SERIAL_MESON
 
 config SERIAL_MESON_CONSOLE
 	bool "Support for console on meson"
-	depends on SERIAL_MESON=y
+	depends on SERIAL_MESON
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index d2c08b760f83..69eeef9edfa5 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -604,7 +604,6 @@ static int __init meson_serial_console_init(void)
 	register_console(&meson_serial_console);
 	return 0;
 }
-console_initcall(meson_serial_console_init);
 
 static void meson_serial_early_console_write(struct console *co,
 					     const char *s,
@@ -634,6 +633,9 @@ OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
+static int __init meson_serial_console_init(void) {
+	return 0;
+}
 #define MESON_SERIAL_CONSOLE	NULL
 #endif
 
@@ -824,6 +826,10 @@ static int __init meson_uart_init(void)
 {
 	int ret;
 
+	ret = meson_serial_console_init();
+	if (ret)
+		return ret;
+	
 	ret = uart_register_driver(&meson_uart_driver);
 	if (ret)
 		return ret;
-- 
2.29.2

