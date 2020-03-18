Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8118C5ACD6
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27F120772
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCRO1A (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:27:00 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37356 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgCRO1A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 10:27:00 -0400
Received: from [94.134.91.63] (helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jEZen-0004YX-Ay; Wed, 18 Mar 2020 15:26:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 1/7] serial: 8250: Make em485_rts_after_send() set mctrl according to rts state.
Date:   Wed, 18 Mar 2020 15:26:34 +0100
Message-Id: <20200318142640.982763-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318142640.982763-1-heiko@sntech.de>
References: <20200318142640.982763-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

When rs485 enabled and RTS_AFTER_SEND set on startup, need to preserve
mctrl status, because later functions will call set_mctrl passing
port->mctrl=0 overriding rts status, resulting in rts pin in
transmission when idle.

Make mctrl reflect rts pin state.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8407166610ce..67aa3a2a9afa 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -565,10 +565,13 @@ static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
-	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
+	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND) {
 		mcr |= UART_MCR_RTS;
-	else
+		p->port.mctrl |= TIOCM_RTS;
+	} else {
 		mcr &= ~UART_MCR_RTS;
+		p->port.mctrl &= ~TIOCM_RTS;
+	}
 	serial8250_out_MCR(p, mcr);
 }
 
-- 
2.24.1

