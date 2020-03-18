Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA97C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E835E20772
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 14:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCRO1B (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:27:01 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37366 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgCRO1B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 10:27:01 -0400
Received: from [94.134.91.63] (helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jEZep-0004YX-BN; Wed, 18 Mar 2020 15:26:55 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 5/7] serial: 8250: handle DTR in rs485 emulation
Date:   Wed, 18 Mar 2020 15:26:38 +0100
Message-Id: <20200318142640.982763-6-heiko@sntech.de>
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

While in a lot of cases only RTS is needed as DE signal, sometimes the
RE signals is to be controlled separately, as DTR pin.

So add necessary control functions for it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_port.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3d1d8490bc42..f8e5c096ed51 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -572,6 +572,10 @@ static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
 		mcr &= ~UART_MCR_RTS;
 		p->port.mctrl &= ~TIOCM_RTS;
 	}
+
+	mcr |= UART_MCR_DTR;
+	p->port.mctrl |= TIOCM_DTR;
+
 	serial8250_out_MCR(p, mcr);
 }
 
@@ -1558,6 +1562,13 @@ static inline void start_tx_rs485(struct uart_port *port)
 	em485->active_timer = NULL;
 
 	mcr = serial8250_in_MCR(up);
+
+	/* in rx_during_tx mode keep DTR active, to receive data */
+	if (up->port.rs485.flags & SER_RS485_RX_DURING_TX)
+		mcr |= UART_MCR_DTR;
+	else
+		mcr &= ~UART_MCR_DTR;
+
 	if (!!(up->port.rs485.flags & SER_RS485_RTS_ON_SEND) !=
 	    !!(mcr & UART_MCR_RTS)) {
 		if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
@@ -1572,6 +1583,8 @@ static inline void start_tx_rs485(struct uart_port *port)
 					 up->port.rs485.delay_rts_before_send);
 			return;
 		}
+	} else {
+		serial8250_out_MCR(up, mcr);
 	}
 
 	__start_tx(port);
-- 
2.24.1

