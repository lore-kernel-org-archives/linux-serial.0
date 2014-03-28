From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH] serial: mux: Align SUPPORT_SYSRQ behaviour with other drivers.
Date: Fri, 28 Mar 2014 11:41:38 +0000
Message-ID: <1396006898-31624-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34511 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbaC1LmN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Mar 2014 07:42:13 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so3416108wgh.3
        for <linux-serial@vger.kernel.org>; Fri, 28 Mar 2014 04:42:12 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, Daniel Thompson <daniel.thompson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>

The mux driver is anomalous among all the serial drivers that can
define SUPPORT_SYSRQ because it can, with some configs, set
SUPPORT_SYSRQ when SERIAL_CORE_CONSOLE is not set.

Not only does this impose a pointless (but tiny) runtime overhead for
such configs but, more significantly, it adds needless complexity when
doing a code review to check for unexpected side effects of any
changes to the serial core.

This is (cross-)compile tested only because I do not have any PA-RISC
hardware.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 7fd6aaa..9b27d34 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -29,7 +29,7 @@
 #include <asm/irq.h>
 #include <asm/parisc-device.h>
 
-#ifdef CONFIG_MAGIC_SYSRQ
+#if defined(CONFIG_SERIAL_MUX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #include <linux/sysrq.h>
 #define SUPPORT_SYSRQ
 #endif
-- 
1.9.0

