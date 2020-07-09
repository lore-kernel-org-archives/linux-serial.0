Return-Path: <SRS0=9J3d=AU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE84C433DF
	for <linux-serial@archiver.kernel.org>; Thu,  9 Jul 2020 07:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A882070E
	for <linux-serial@archiver.kernel.org>; Thu,  9 Jul 2020 07:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="DYCJ88jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGIHtA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:49:00 -0400
Received: from mail.intenta.de ([178.249.25.132]:26497 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgGIHtA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Jul 2020 03:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=TC3CKUv3GI3V1R9v1YaBRJSpUEXcqzJmrUEkquDu7SA=;
        b=DYCJ88jvCeXue0j0te2eOpKBXIFjC1hm1wunE3nX3uE/xSszxZ66JfUCa1j+U6dS0O65evYHpG/Xlp5dqvXgUvz802FkjC6GvDNVuukClHkwsLMBDr37pVYFTU0G4fUtWRyqgzt11Fb6jhygCn8+lOtbHHe5BpqXTi5oQ8ChONqGUXOArObEPOukSjzeqsIRvhgQGR+OnJsbPwFti7oY0JW4ihRnJ/SK0/m0MHLftG7izW42FEVmSOwkbbYdiU3r45Eltq6xaD+d33BxCY4sikVrhp66k99G0lDBytOSWrJcDT2kKXiLRHmgkYXPVDao12vHV+7oDGCVvvWsM9OXaA==;
Date:   Thu, 9 Jul 2020 09:48:53 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jan Kiszka <jan.kiszka@web.de>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] tty: xilinx_uartps: Really fix id assignment
Message-ID: <20200709074849.GA28968@laureti-dev>
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The problems started with the revert (18cc7ac8a28e28). The
cdns_uart_console.index is statically assigned -1. When the port is
registered, Linux assigns consecutive numbers to it. It turned out that
when using ttyPS1 as console, the index is not updated as we are reusing
the same cdns_uart_console instance for multiple ports. When registering
ttyPS0, it gets updated from -1 to 0, but when registering ttyPS1, it
already is 0 and not updated.

That led to 2ae11c46d5fdc4. It assigns the index prior to registering
the uart_driver once. Unfortunately, that ended up breaking the
situation where the probe order does not match the id order. When using
the same device tree for both uboot and linux, it is important that the
serial0 alias points to the console. So some boards reverse those
aliases. This was reported by Jan Kiszka. The proposed fix was reverting
the index assignment and going back to the previous iteration.

However such a reversed assignement (serial0 -> uart1, serial1 -> uart0)
was already partially broken by the revert (18cc7ac8a28e28). While the
ttyPS device works, the kmsg connection is already broken and kernel
messages go missing. Reverting the id assignment does not fix this.

From the xilinx_uartps driver pov (after reverting the refactoring
commits), there can be only one console. This manifests in static
variables console_pprt and cdns_uart_console. These variables are not
properly linked and can go out of sync. The cdns_uart_console.index is
important for uart_add_one_port. We call that function for each port -
one of which hopefully is the console. If it isn't, the CON_ENABLED flag
is not set and console_port is cleared. The next cdns_uart_probe call
then tries to register the next port using that same cdns_uart_console.

It is important that console_port and cdns_uart_console (and its index
in particular) stay in sync. The index assignment implemented by
Shubhrajyoti Datta is correct in principle. It just may have to happen a
second time if the first cdns_uart_probe call didn't encounter the
console device. And we shouldn't change the index once the console uart
is registered.

Reported-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Reported-by: Jan Kiszka <jan.kiszka@web.de>
Link: https://lore.kernel.org/linux-serial/f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com/
Fixes: 18cc7ac8a28e28 ("Revert "serial: uartps: Register own uart console and driver structures"")
Fixes: 2ae11c46d5fdc4 ("tty: xilinx_uartps: Fix missing id assignment to the console")
Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
---
 drivers/tty/serial/xilinx_uartps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b9d672af8b65..2833f1418d6d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1465,7 +1465,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS;
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 		cdns_uart_uart_driver.cons = &cdns_uart_console;
-		cdns_uart_console.index = id;
 #endif
 
 		rc = uart_register_driver(&cdns_uart_uart_driver);
@@ -1581,8 +1580,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * If register_console() don't assign value, then console_port pointer
 	 * is cleanup.
 	 */
-	if (!console_port)
+	if (!console_port) {
+		cdns_uart_console.index = id;
 		console_port = port;
+	}
 #endif
 
 	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
@@ -1595,8 +1596,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
 	if (console_port == port &&
-	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED))
+	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED)) {
 		console_port = NULL;
+		cdns_uart_console.index = -1;
+	}
 #endif
 
 	cdns_uart_data->cts_override = of_property_read_bool(pdev->dev.of_node,
-- 
2.20.1

