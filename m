Return-Path: <SRS0=GYIK=3A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B567C33CA2
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jan 2020 02:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B74F2072E
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jan 2020 02:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgAKCZU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:25:20 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48827 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgAKCZT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 21:25:19 -0500
X-Originating-IP: 50.39.173.182
Received: from localhost (50-39-173-182.bvtn.or.frontiernet.net [50.39.173.182])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8F8E1240004;
        Sat, 11 Jan 2020 02:25:15 +0000 (UTC)
Date:   Fri, 10 Jan 2020 18:25:13 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: Support disabling mdelay-filled probes of
 16550A variants
Message-ID: <20200111022513.GA166267@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 8250 driver can probe for many variants of the venerable 16550A
serial port. Some of those probes involve long (20ms) mdelay calls,
which delay system boot. Modern systems and virtual machines don't have
those variants.

Provide a Kconfig option to disable probes for 16550A variants.
Disabling this speeds up the boot of a virtual machine with a serial
console by more than 20ms (a substantial fraction of the ~100ms needed
to boot a carefully configured VM).

Before:
[  +0.021919] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
After:
[  +0.000097] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/tty/serial/8250/8250_port.c |  3 +++
 drivers/tty/serial/8250/Kconfig     | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 90655910b0c7..925bc26d3f15 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1001,6 +1001,9 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	up->port.type = PORT_16550A;
 	up->capabilities |= UART_CAP_FIFO;
 
+	if (!IS_ENABLED(CONFIG_SERIAL_8250_16550A_VARIANTS))
+		return;
+
 	/*
 	 * Check for presence of the EFR when DLAB is set.
 	 * Only ST16C650V1 UARTs pass this test.
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index fab3d4f20667..ffd167e886ae 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -60,6 +60,16 @@ config SERIAL_8250_PNP
 	  This builds standard PNP serial support. You may be able to
 	  disable this feature if you only need legacy serial support.
 
+config SERIAL_8250_16550A_VARIANTS
+	bool "Support for variants of the 16550A serial port"
+	depends on SERIAL_8250
+	help
+	  The 8250 driver can probe for many variants of the venerable 16550A
+	  serial port. Doing so takes additional time at boot.
+
+	  On modern systems, especially those using serial only for a simple
+	  console, you can say N here.
+
 config SERIAL_8250_FINTEK
 	bool "Support for Fintek F81216A LPC to 4 UART RS485 API"
 	depends on SERIAL_8250
-- 
2.25.0.rc2

