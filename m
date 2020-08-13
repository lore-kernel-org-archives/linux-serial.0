Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869C7C433E1
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 10:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEAE20771
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 10:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMK77 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMK7s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 06:59:48 -0400
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Aug 2020 03:59:48 PDT
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D224C061757
        for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2020 03:59:47 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id C7E9D10189947;
        Thu, 13 Aug 2020 12:52:41 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 8FAFF603DA32;
        Thu, 13 Aug 2020 12:52:41 +0200 (CEST)
X-Mailbox-Line: From f827ff09da55b8c57d316a1b008a137677b58921 Mon Sep 17 00:00:00 2001
Message-Id: <f827ff09da55b8c57d316a1b008a137677b58921.1597315557.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 13 Aug 2020 12:52:40 +0200
Subject: [PATCH] serial: pl011: Fix oops on -EPROBE_DEFER
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org,
        Aleksey Makarov <amakarov@marvell.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Christopher Covington <cov@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If probing of a pl011 gets deferred until after free_initmem(), an oops
ensues because pl011_console_match() is called which has been freed.

Fix by removing the __init attribute from the function and those it
calls.

Commit 10879ae5f12e ("serial: pl011: add console matching function")
introduced pl011_console_match() not just for early consoles but
regular preferred consoles, such as those added by acpi_parse_spcr().
Regular consoles may be registered after free_initmem() for various
reasons, one being deferred probing, another being dynamic enablement
of serial ports using a DeviceTree overlay.

Thus, pl011_console_match() must not be declared __init and the
functions it calls mustn't either.

Stack trace for posterity:

Unable to handle kernel paging request at virtual address 80c38b58
Internal error: Oops: 8000000d [#1] PREEMPT SMP ARM
PC is at pl011_console_match+0x0/0xfc
LR is at register_console+0x150/0x468
[<80187004>] (register_console)
[<805a8184>] (uart_add_one_port)
[<805b2b68>] (pl011_register_port)
[<805b3ce4>] (pl011_probe)
[<80569214>] (amba_probe)
[<805ca088>] (really_probe)
[<805ca2ec>] (driver_probe_device)
[<805ca5b0>] (__device_attach_driver)
[<805c8060>] (bus_for_each_drv)
[<805c9dfc>] (__device_attach)
[<805ca630>] (device_initial_probe)
[<805c90a8>] (bus_probe_device)
[<805c95a8>] (deferred_probe_work_func)

Fixes: 10879ae5f12e ("serial: pl011: add console matching function")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.10+
Cc: Aleksey Makarov <amakarov@marvell.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Christopher Covington <cov@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c010f639298d..cd1ba8d8b0e6 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2241,9 +2241,8 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	clk_disable(uap->clk);
 }
 
-static void __init
-pl011_console_get_options(struct uart_amba_port *uap, int *baud,
-			     int *parity, int *bits)
+static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
+				      int *parity, int *bits)
 {
 	if (pl011_read(uap, REG_CR) & UART01x_CR_UARTEN) {
 		unsigned int lcr_h, ibrd, fbrd;
@@ -2276,7 +2275,7 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 	}
 }
 
-static int __init pl011_console_setup(struct console *co, char *options)
+static int pl011_console_setup(struct console *co, char *options)
 {
 	struct uart_amba_port *uap;
 	int baud = 38400;
@@ -2344,8 +2343,8 @@ static int __init pl011_console_setup(struct console *co, char *options)
  *
  *	Returns 0 if console matches; otherwise non-zero to use default matching
  */
-static int __init pl011_console_match(struct console *co, char *name, int idx,
-				      char *options)
+static int pl011_console_match(struct console *co, char *name, int idx,
+			       char *options)
 {
 	unsigned char iotype;
 	resource_size_t addr;
-- 
2.27.0

