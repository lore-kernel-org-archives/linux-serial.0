Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EB1C33CB1
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547A920748
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgAPMXP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:23:15 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:35809 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPMXO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 07:23:14 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 395E21008C54C;
        Thu, 16 Jan 2020 13:23:13 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id F129B60AE1B8;
        Thu, 16 Jan 2020 13:23:12 +0100 (CET)
X-Mailbox-Line: From 6aea0eacf3bfa73fe2d81082cc723265413410c8 Mon Sep 17 00:00:00 2001
Message-Id: <6aea0eacf3bfa73fe2d81082cc723265413410c8.1579175223.git.lukas@wunner.de>
In-Reply-To: <cover.1579175223.git.lukas@wunner.de>
References: <cover.1579175223.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 16 Jan 2020 13:14:03 +0100
Subject: [PATCH 3/6] serial: 8250_bcm2835aux: Suppress register_port error on
 -EPROBE_DEFER
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Martin Sperl <kernel@martin.sperl.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Suppress a gratuitous error message if serial8250_register_8250_port()
returns -EPROBE_DEFER.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 33da68341c3a..fb850d0ad643 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -95,8 +95,9 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	/* register the port */
 	ret = serial8250_register_8250_port(&data->uart);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "unable to register 8250 port - %d\n",
-			ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"unable to register 8250 port - %d\n", ret);
 		goto dis_clk;
 	}
 	data->line = ret;
-- 
2.24.0

