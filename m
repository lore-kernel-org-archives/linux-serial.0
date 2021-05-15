Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53309C433B4
	for <linux-serial@archiver.kernel.org>; Sat, 15 May 2021 08:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1858A613FC
	for <linux-serial@archiver.kernel.org>; Sat, 15 May 2021 08:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhEOIrN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 15 May 2021 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhEOIrL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 15 May 2021 04:47:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D54C06174A;
        Sat, 15 May 2021 01:45:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso966551pjb.5;
        Sat, 15 May 2021 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/aSzYmi9eBplfwSyp+NOkErXHwBc1HDaHzhChk6wmcA=;
        b=TBrM/n3id8SsgZR/0/FCWcfrf/FIgxUfwGWcNi8zP4a8zKrEct9decs2RECylMWrj7
         0nkNI8zl/5PCqtHISQ5XlzA1hB03OKOJuZ9BADrlOIQfwvU4I1YxoABpdhs6Md3LRcTk
         9rkdDM78nmVcba0khi4ibj4M9CYxown4bixeJDemTMS0dEVZQLJ/j28LA4gG9CmNdCF7
         3OD8tuMQcf7iNgnTPcoFBbSjJCuWwp0rqtM/cL4z3/h21honjm4PPaUrOb7FHeB+j34j
         1LpMx0zdpnW3z/Mu5iDCSM5l4XysFqj8M4DmZ6i/md3st/gXGxvdmgUVmSCV3pAa90Q7
         CfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/aSzYmi9eBplfwSyp+NOkErXHwBc1HDaHzhChk6wmcA=;
        b=Zdgr5aU+juzdPlcP0LlRfVIE7TKoNDlibbS5ngFnKCUiJ//NhxQqMB2zMXBmcQsUq4
         xDgOqrsLLOKenVuaaCHd/3VqSBXdJjK47F1X7xVMkmr+/N7EYBdpShWgGyypuCZIl+cq
         nnQynBSEQxEIoRQaMZzf7RW/e5Npq71hEE8OFNlrVm6qF5t7vfAO7Hzw/UmQQoj+fsTl
         yqK4AbQjDcmgKKlCowZFaTxZwqImhpVforg2vbM0oz0YcYdwbzMq+N15CRJ/rlQygXeJ
         i4jxsmW4yOIkrog+YD5RTXQH19AoA0h82HuSd/tKU4ejp13LQmfQEwnNU4H9flabfm+X
         BL+w==
X-Gm-Message-State: AOAM5335l4R6sKgQtL3klVDuBBVMJrMJx3fZnMv8tkCSvHzrn9+F7xhq
        3FTVc1m7evyr/QGAVGl8VbRdEfsC9JsaEA==
X-Google-Smtp-Source: ABdhPJww03+7cSzkFTvaXoxlBEf8dNYZPUEoHsutLOQM12Lpng1F9S48bYdAA/wFfmZIF/bcmuaUTA==
X-Received: by 2002:a17:902:904a:b029:ef:9058:7314 with SMTP id w10-20020a170902904ab02900ef90587314mr15437126plz.12.1621068339809;
        Sat, 15 May 2021 01:45:39 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id z16sm10746737pjq.42.2021.05.15.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 01:45:39 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        "Gabriel L . Somlo" <gsomlo@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] serial/liteuart; Add support for earlycon
Date:   Sat, 15 May 2021 17:45:18 +0900
Message-Id: <20210515084519.167343-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Most litex boards using RISC-V soft cores us the sbi earlycon, however
this is not available for non RISC-V litex SoC.  This patch enables
earlycon for liteuart which is available on all Litex SoC's making
support for earycon debugging more widely available.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Cc: Florent Kermarrec <florent@enjoy-digital.fr>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Gabriel L. Somlo <gsomlo@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/tty/serial/Kconfig                    |  1 +
 drivers/tty/serial/liteuart.c                 | 31 +++++++++++++++++++
 3 files changed, 37 insertions(+)

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
index 0c4cd4a348f4..9ceffe6ab6fd 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1531,6 +1531,7 @@ config SERIAL_LITEUART
 	depends on OF || COMPILE_TEST
 	depends on LITEX
 	select SERIAL_CORE
+	select SERIAL_EARLYCON
 	help
 	  This driver is for the FPGA-based LiteUART serial controller from LiteX
 	  SoC builder.
diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 64842f3539e1..38c472487e68 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -372,6 +372,37 @@ static int __init liteuart_console_init(void)
 console_initcall(liteuart_console_init);
 #endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
 
+#ifdef CONFIG_SERIAL_EARLYCON
+static void early_liteuart_putc(struct uart_port *port, int c)
+{
+	while (litex_read8(port->membase + OFF_TXFULL))
+		cpu_relax();
+
+	litex_write8(port->membase + OFF_RXTX, c);
+}
+
+static void early_liteuart_write(struct console *console, const char *s,
+				    unsigned int count)
+{
+	struct earlycon_device *device = console->data;
+	struct uart_port *port = &device->port;
+
+	uart_console_write(port, s, count, early_liteuart_putc);
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
+#endif /* CONFIG_SERIAL_EARLYCON */
+
 static int __init liteuart_init(void)
 {
 	int res;
-- 
2.31.1

