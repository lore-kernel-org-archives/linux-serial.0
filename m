Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532EEC33CB1
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3108820748
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgAPM2P (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:28:15 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:42423 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgAPM2P (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 07:28:15 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 64BD5102F35D2;
        Thu, 16 Jan 2020 13:20:41 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id EF39E60AE1B8;
        Thu, 16 Jan 2020 13:20:40 +0100 (CET)
X-Mailbox-Line: From 912ccf553c5258135c6d7e8f404a101ef320f0f4 Mon Sep 17 00:00:00 2001
Message-Id: <912ccf553c5258135c6d7e8f404a101ef320f0f4.1579175223.git.lukas@wunner.de>
In-Reply-To: <cover.1579175223.git.lukas@wunner.de>
References: <cover.1579175223.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 16 Jan 2020 13:14:01 +0100
Subject: [PATCH 1/6] serial: 8250_bcm2835aux: Fix line mismatch on driver
 unbind
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Martin Sperl <kernel@martin.sperl.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Unbinding the bcm2835aux UART driver raises the following error if the
maximum number of 8250 UARTs is set to 1 (via the 8250.nr_uarts module
parameter or CONFIG_SERIAL_8250_RUNTIME_UARTS):

(NULL device *): Removing wrong port: a6f80333 != fa20408b

That's because bcm2835aux_serial_probe() retrieves UART line number 1
from the devicetree and stores it in data->uart.port.line, while
serial8250_register_8250_port() instead uses UART line number 0,
which is stored in data->line.

On driver unbind, bcm2835aux_serial_remove() uses data->uart.port.line,
which contains the wrong number.  Fix it.

The issue does not occur if the maximum number of 8250 UARTs is >= 2.

Fixes: bdc5f3009580 ("serial: bcm2835: add driver for bcm2835-aux-uart")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.6+
Cc: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 8ce700c1a7fc..4997c519ebb3 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -113,7 +113,7 @@ static int bcm2835aux_serial_remove(struct platform_device *pdev)
 {
 	struct bcm2835aux_data *data = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(data->uart.port.line);
+	serial8250_unregister_port(data->line);
 	clk_disable_unprepare(data->clk);
 
 	return 0;
-- 
2.24.0

