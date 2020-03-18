Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452B8C5ACD7
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA7520774
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCRO1T (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:27:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37362 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgCRO1A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 10:27:00 -0400
Received: from [94.134.91.63] (helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jEZeo-0004YX-VA; Wed, 18 Mar 2020 15:26:55 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 4/7] serial: 8250: Start rs485 after registering port if rs485 is enabled in probe
Date:   Wed, 18 Mar 2020 15:26:37 +0100
Message-Id: <20200318142640.982763-5-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318142640.982763-1-heiko@sntech.de>
References: <20200318142640.982763-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Before registering a port 8250 drivers may read devicetree information
regarding rs485 emulation, but starting the em485 emulation at that point
would only keep the em485 structure in the template uart port.

Also at that point before the port is registered possible gpios for
rts/dtr are not acquired yet as well.

So simply check after acquiring the port if the rs485-enable flag is set
and start the config callback in that case.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e682390ce0de..beab1c22b34d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1068,6 +1068,15 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (up->dl_write)
 			uart->dl_write = up->dl_write;
 
+		if (uart->port.rs485_config &&
+		    (uart->port.rs485.flags & SER_RS485_ENABLED)) {
+			dev_dbg(uart->port.dev, "starting in rs485 mode\n");
+			ret = uart->port.rs485_config(&uart->port,
+						      &uart->port.rs485);
+			if (ret < 0)
+				goto out_unlock;
+		}
+
 		if (uart->port.type != PORT_8250_CIR) {
 			if (serial8250_isa_config != NULL)
 				serial8250_isa_config(0, &uart->port,
-- 
2.24.1

