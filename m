Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C80DC2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F336120719
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 16:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgIWQUB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:20:01 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40268 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIWQT6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 12:19:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 218AA8030719;
        Wed, 23 Sep 2020 16:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m6R3l9TBVYAc; Wed, 23 Sep 2020 19:19:55 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] serial: 8250: Skip uninitialized TTY port baud rate update
Date:   Wed, 23 Sep 2020 19:19:49 +0300
Message-ID: <20200923161950.6237-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
References: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is erroneous to update the TTY port baud rate if it hasn't been
initialized yet, because in that case the TTY struct isn't set. So there
is no termios structure to get and re-calculate the baud if the current
baud can't be reached. Let's skip the baud rate update then until the port
is fully initialized.

Note the update UART clock method still sets the uartclk member with a new
ref clock value even if the port is turned off. The new UART ref clock
rate will be used later on the port starting up procedure.

Fixes: 868f3ee6e452 ("serial: 8250: Add 8250 port clock update method")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1259fb6b66b3..b0af13074cd3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2653,6 +2653,10 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 		goto out_lock;
 
 	port->uartclk = uartclk;
+
+	if (!tty_port_initialized(&port->state->port))
+		goto out_lock;
+
 	termios = &port->state->port.tty->termios;
 
 	baud = serial8250_get_baud_rate(port, termios, NULL);
-- 
2.27.0

