From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] serial/arc-uart: Fix section mistmatch
Date: Wed, 16 Jan 2013 13:47:23 +0530
Message-ID: <1358324243-20239-1-git-send-email-vgupta@synopsys.com>
References: <50f64ecc.OeYe/XYB1UqhO87E%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:37205 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758188Ab3APITK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 03:19:10 -0500
In-Reply-To: <50f64ecc.OeYe/XYB1UqhO87E%fengguang.wu@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, fengguang.wu@intel.com

Commit "serial/arc-uart: split probe from probe_earlyprintk" introduced
a build time warning:

"WARNING: vmlinux.o(.data+0x5baa0): Section mismatch in reference from
the variable early_arc_platform_driver to the function
.init.text:arc_serial_probe_earlyprintk()"

While at it - fixed another incorrectly placed initdata annotation.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: fengguang.wu@intel.com
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/arc_uart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index da73422..6f7eadc 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -659,7 +659,7 @@ static __init void early_serial_write(struct console *con, const char *s,
 	}
 }
 
-static struct __initdata console arc_early_serial_console = {
+static struct console arc_early_serial_console __initdata = {
 	.name = "early_ARCuart",
 	.write = early_serial_write,
 	.flags = CON_PRINTBUFFER | CON_BOOT,
@@ -731,7 +731,7 @@ static struct platform_driver arc_platform_driver = {
 
 #ifdef CONFIG_SERIAL_ARC_CONSOLE
 
-static struct platform_driver early_arc_platform_driver = {
+static struct platform_driver early_arc_platform_driver __initdata = {
 	.probe = arc_serial_probe_earlyprintk,
 	.remove = arc_serial_remove,
 	.driver = {
-- 
1.7.4.1

