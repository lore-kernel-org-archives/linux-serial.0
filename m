Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C56C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 30 Dec 2021 10:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhL3KW7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Dec 2021 05:22:59 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:36405 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhL3KW7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Dec 2021 05:22:59 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Thu, 30 Dec 2021
 18:22:56 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V3 5/6] tty: serial: meson: meson_uart_shutdown omit clear AML_UART_TX_EN bit
Date:   Thu, 30 Dec 2021 18:21:09 +0800
Message-ID: <20211230102110.3861-6-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211230102110.3861-1-yu.tu@amlogic.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This change is an improvement. The meson_uart_shutdown function
should have the opposite operation to the meson_uart_startup
function, but the meson_uart_shutdown of AML_UART_TX_EN is logically
missing.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 07eb1f40aaaa..45e41f20cba3 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -140,7 +140,7 @@ static void meson_uart_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 
 	val = readl(port->membase + AML_UART_CONTROL);
-	val &= ~AML_UART_RX_EN;
+	val &= ~(AML_UART_RX_EN | AML_UART_TX_EN);
 	val &= ~(AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
 	writel(val, port->membase + AML_UART_CONTROL);
 
-- 
2.33.1

