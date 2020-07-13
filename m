Return-Path: <SRS0=GPH0=AY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F47CC433E1
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jul 2020 07:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B857206F0
	for <linux-serial@archiver.kernel.org>; Mon, 13 Jul 2020 07:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="O2mUO1JG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgGMHcd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:32:33 -0400
Received: from mail.intenta.de ([178.249.25.132]:33487 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgGMHcd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Jul 2020 03:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=FSVKKh1K3meJ2NLE68XU6nTptr/hNpfqhkvhx31taXA=;
        b=O2mUO1JGdL4/AbtHEfauBDNtzEgysjWjoTAEjYR9au4rNCkW7R8lB9Q/eObE95p1qFy4Nvlt11xS//A49bE25U9v84DKexywB7ZALe8rW42MRY12IDYLSEtw2vN7OS+r5aJ41Rqo71NGjJCSd0R7XZo1mFAHRhi8ELY94jbhH6Dsyn9YFruncKOs1dKOqr33BCNQSCPNfJkM79OcUyQrpJe+KVmQIpokuYL5LbEOTIialSpFkjoJUA/tZotFzzeMIOo0Nn2c/oMM+41E7Kbe28JguRa41a56o0R9jm9ErYslM66EpjkJTAXfDJHr0XKryqZvQpYDt0LOdPo5CImSUg==;
Date:   Mon, 13 Jul 2020 09:32:28 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jan Kiszka <jan.kiszka@web.de>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] tty: xilinx_uartps: Really fix id assignment
Message-ID: <20200713073227.GA3805@laureti-dev>
References: <20200710124535.GA1584780@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200710124535.GA1584780@kroah.com>
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
Fixes: 76ed2e10579671 ("Revert "tty: xilinx_uartps: Fix missing id assignment to the console"")
Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
---
 drivers/tty/serial/xilinx_uartps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Changes since v1:
 * This patch was meant to replace 76ed2e10579671. Since it is part of
   gregkh/tty-linus already, rebase this patch onto it.

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 672cfa075e28..2833f1418d6d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1580,8 +1580,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
@@ -1594,8 +1596,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
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

