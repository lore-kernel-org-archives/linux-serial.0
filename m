Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7132C38A2D
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 07:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiJYHkM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Oct 2022 03:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiJYHkD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Oct 2022 03:40:03 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C181BC780
        for <linux-serial@vger.kernel.org>; Tue, 25 Oct 2022 00:40:01 -0700 (PDT)
Received: from xps.skovby (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id 23DBF57B60;
        Tue, 25 Oct 2022 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1666683598; bh=qZrSlc6MMwTOB3mI09iVZFthHD/6RQ4/UnCZviOYtcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mbMtJ6vpEbBeDCUlwP34o3oiGNlnAq+JzEgiz3atgxTWSYPbJZfCBxgaapRtfIkJ3
         y41ssRtPXe1i0vbx56JBXkO4Y20J5xH5g8HMS8BtE5+z/JxbABUY5bkFy8B3PtYWvu
         yZfG3Ugns5W9tnriybPIeHoylCPqEATbvN+N5rlyUVgFJV0ZZLnWCFPtzt+Z48/xLl
         egVx4xXOl6ZDsYRLjOdwEypBm3WZ5adLP1DYgylut7LYb9kfQDU7uOVvrtlk1mtZwE
         g+0OTnxyGTqFMvoskmu8QAaHwSETPuSiX8la2OIwTtN/9hHfVRxr3cbMvvTRgaBh29
         LVtsK/xtXPOCQ==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 4/4] tty: 8250: update description of RUNTIME_PORTS / nr_uarts
Date:   Tue, 25 Oct 2022 09:39:44 +0200
Message-Id: <20221025073944.102437-4-martin@geanix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025073944.102437-1-martin@geanix.com>
References: <20221025073944.102437-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 8250 module has been updated allow configurations with zero builtin
UART ports, so change the description of the parameter to reflect that.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---

Change since v2:
 * new patch

 drivers/tty/serial/8250/8250_core.c |  3 ++-
 drivers/tty/serial/8250/Kconfig     | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a8fbc2325244..3d8bf0296080 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1257,7 +1257,8 @@ module_param_hw(share_irqs, uint, other, 0644);
 MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
 
 module_param(nr_uarts, uint, 0644);
-MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
+MODULE_PARM_DESC(nr_uarts, "Number of built-in (non-discoverable) UARTs to initialize. (1-"
+		_MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
 
 module_param(skip_txen_test, uint, 0644);
 MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d0b49e15fbf5..65ef03553146 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -191,15 +191,15 @@ config SERIAL_8250_NR_UARTS
 	  via hot-plug, or any ISA multi-port serial cards.
 
 config SERIAL_8250_RUNTIME_UARTS
-	int "Number of 8250/16550 serial ports to register at runtime"
+	int "Number of built-in (non-discoverable) UARTs to initialize at boot time"
 	depends on SERIAL_8250
 	range 0 SERIAL_8250_NR_UARTS
 	default "4"
 	help
-	  Set this to the maximum number of serial ports you want
-	  the kernel to register at boot time.  This can be overridden
-	  with the module parameter "nr_uarts", or boot-time parameter
-	  8250.nr_uarts
+	  Set this to the maximum number of built-in (non-discoverable) serial
+	  ports you want the kernel to initialize at boot time.  This can be
+	  overridden with the module parameter "nr_uarts", or boot-time
+	  parameter 8250.nr_uarts
 
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
-- 
2.38.1

