Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB9C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 11:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D996F611BD
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 11:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhEQL4e (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 07:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhEQL4d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 07:56:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C0C061573;
        Mon, 17 May 2021 04:55:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so5421839pjb.2;
        Mon, 17 May 2021 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofjIyFEqH+7WozIJCmE480eSgTaWZPmeSBdcRECXJis=;
        b=mXO7ZhJSPfKtHLNKVr4WDbaAtD3yrYXItsdqwovHZLBQocO8KZfsR0ipDkbzw+DJLn
         wddLb82NK8mf4owZm3C05Q1Fz9PY0Feb7O4GcyYjnok6RRzBZhgaKpJZvpdWE+WEaB36
         04UvBwhgf4FJMuxnmRzN59Zb5C2prGWlRiBAoutaMWiOZIWph7MqUV/mZYWtK3V4AbVc
         WVzLki5u2g4lzEMjPrREOyu73aDdaiuwDksQL47ePsT8GnUoErl7QkzqnmMgcn041iEn
         HSTZ+SQsAUXc+RMxP9qPy+LnJJc8KtysIpJTHCgLWZdzrBec3q7KyPm2lk0Fft18X04T
         q1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofjIyFEqH+7WozIJCmE480eSgTaWZPmeSBdcRECXJis=;
        b=E0LrSH2Qj/YW1AkE2TkHXUOb7VHprQ7YGT020Ttl/gH5tM8kTNySyv/NGpWdyIRyMx
         MJpw9+i09R+hTd31pdQf5aAJQNBbUukbXs0ll19PH31hkE1TxoruFqd1iIboaEIL2NGu
         ox/pKr4v6RFl0pT/Rv1E4dP2QJFQFcKs0QDiN1B1VGhJKOWYY8XQBfxL1RAV8AfOpBoQ
         1AqFwPQ2J/HMzwarsdTyUhmGvC6iIg9oOyOJ0Xk66wS8XrCTidVLbBTvNyTE9DAsSetw
         SNqhNvbciRLc0dP4D2s45tcKTryFJL6sbjEFkFJ3vbby21EUtUcKVr1QdsBoOuKkta03
         LR/g==
X-Gm-Message-State: AOAM530A5pCY2fPOY87yGCCaD/oz5wgSWfymOzm/Brb3IaQCyAZ10Yt+
        EZ6cZ5V+8R12cJ5gwTH7p2yH323fcC4SWw==
X-Google-Smtp-Source: ABdhPJxb7dGfS/9MSFW7k9eaStxevFWdaq8ErD2qNHtOT9Hyj1xP+ujvKramZmfeRAPGo2+oZK7iPQ==
X-Received: by 2002:a17:903:20cc:b029:f0:cc11:51c2 with SMTP id i12-20020a17090320ccb02900f0cc1151c2mr9847849plb.32.1621252516720;
        Mon, 17 May 2021 04:55:16 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id e1sm10534600pgl.25.2021.05.17.04.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 04:55:16 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     jirislaby@kernel.org, Stafford Horne <shorne@gmail.com>,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        "Gabriel L . Somlo" <gsomlo@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karol Gugala <kgugala@antmicro.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2] serial: liteuart: Add support for earlycon
Date:   Mon, 17 May 2021 20:54:52 +0900
Message-Id: <20210517115453.24365-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Most litex boards using RISC-V soft cores us the sbi earlycon, however
this is not available for non RISC-V litex SoC's.  This patch enables
earlycon for liteuart which is available on all Litex SoC's making
support for earycon debugging more widely available.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Cc: Florent Kermarrec <florent@enjoy-digital.fr>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Gabriel L. Somlo <gsomlo@gmail.com>
Reviewed-and-tested-by: Gabriel Somlo <gsomlo@gmail.com>
---
Changes since v1:
 - Fixed subject
 - Fixed ifdef and config issues pointed out by Jiri
 - Use liteuart_putchar instead of early_liteuart_putc

 .../admin-guide/kernel-parameters.txt         |  5 +++++
 drivers/tty/serial/Kconfig                    |  1 +
 drivers/tty/serial/liteuart.c                 | 21 +++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..2d4a43af8de2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1084,6 +1084,11 @@
 			the driver will use only 32-bit accessors to read/write
 			the device registers.
 
+		liteuart,<addr>
+			Start an early console on a litex serial port at the
+			specified address. The serial port must already be
+			setup and configured. Options are not yet supported.
+
 		meson,<addr>
 			Start an early, polled-mode console on a meson serial
 			port at the specified address. The serial port must
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0c4cd4a348f4..af41e534483c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1550,6 +1550,7 @@ config SERIAL_LITEUART_CONSOLE
 	bool "LiteUART serial port console support"
 	depends on SERIAL_LITEUART=y
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  Say 'Y' or 'M' here if you wish to use the FPGA-based LiteUART serial
 	  controller from LiteX SoC builder as the system console
diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 64842f3539e1..1b75a4bf7c56 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -370,6 +370,27 @@ static int __init liteuart_console_init(void)
 	return 0;
 }
 console_initcall(liteuart_console_init);
+
+static void early_liteuart_write(struct console *console, const char *s,
+				    unsigned int count)
+{
+	struct earlycon_device *device = console->data;
+	struct uart_port *port = &device->port;
+
+	uart_console_write(port, s, count, liteuart_putchar);
+}
+
+static int __init early_liteuart_setup(struct earlycon_device *device,
+				       const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = early_liteuart_write;
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(liteuart, "litex,liteuart", early_liteuart_setup);
 #endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
 
 static int __init liteuart_init(void)
-- 
2.31.1

