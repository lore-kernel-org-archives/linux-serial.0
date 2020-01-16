Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3CCC33CB1
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA7A20748
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgAPM0m (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:26:42 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:40381 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPM0m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 07:26:42 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 206511008C310;
        Thu, 16 Jan 2020 13:26:41 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id D379460AE1B8;
        Thu, 16 Jan 2020 13:26:40 +0100 (CET)
X-Mailbox-Line: From aea363c27fd541dba96d2ebfeee4f596c6d34932 Mon Sep 17 00:00:00 2001
Message-Id: <aea363c27fd541dba96d2ebfeee4f596c6d34932.1579175223.git.lukas@wunner.de>
In-Reply-To: <cover.1579175223.git.lukas@wunner.de>
References: <cover.1579175223.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 16 Jan 2020 13:14:06 +0100
Subject: [PATCH 6/6] serial: 8250_bcm2835aux: Document struct bcm2835aux_data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Martin Sperl <kernel@martin.sperl.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Document the driver private data of the BCM2835 auxiliary UART so that
upcoming commits may add further members with proper kerneldoc.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index d21460c9ef4b..e70e3cc30050 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -16,6 +16,11 @@
 
 #include "8250.h"
 
+/**
+ * struct bcm2835aux_data - driver private data of BCM2835 auxiliary UART
+ * @clk: clock producer of the port's uartclk
+ * @line: index of the port's serial8250_ports[] entry
+ */
 struct bcm2835aux_data {
 	struct clk *clk;
 	int line;
-- 
2.24.0

