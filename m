Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E125BC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD5361108
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhJOLQv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 07:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238318AbhJOLQu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 07:16:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FD21610E8;
        Fri, 15 Oct 2021 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634296484;
        bh=J6rILMKj++wRYFa5xWLGbLwpa2qNvrGLxi9bb4GHa7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QqsHd/MQdvT7v6YvFkvY7xeR8CuUoW+O20uSLDU/VGENoeoYVBjS5s9DUORTaOoVH
         aKWhGYbN9dzrPoqwbT6LA4Vqun4ITJxykrB9D4GPxiGb0rWyGeniCKtSV0Ccyp28Ns
         KbgxVYQ/z98kgSINTLMqk3NVDP1RpuF6+AEN/2FW2dBxQG9y6xVUvcUMjG8K6TUA6p
         woJgUdqpGBrXfXZGlVpQZkJ4KrgxxYEhftoSh/VczONYoUMoNEf22Iz+TfNA+2Uk+p
         2oMNIgsihMeMkF8NSNcqrQt7F0FoQnYgbxO6nF4Jt1ybvXXRsltF/oRxCeHcYcGtfO
         QBzFW3zmXh7zg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mbLAc-0000HY-9B; Fri, 15 Oct 2021 13:14:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] serial: 8250_dw: drop bogus uartclk optimisation
Date:   Fri, 15 Oct 2021 13:14:22 +0200
Message-Id: <20211015111422.1027-4-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211015111422.1027-1-johan@kernel.org>
References: <20211015111422.1027-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver was updating the port uartclk before setting the new rate in
an attempt to avoid having the clock notifier redundantly update the
divisors.

The set_termios() callback is however called under the termios semaphore
and tty-port mutex so the worker scheduled by the clock notifier will
block in serial8250_update_uartclk() until the uartclk and divisors have
been updated anyway.

Drop the unnecessary swaps and incorrect comment and simply update the
uartclk field if the clock-rate change was successful.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a3a0154da567..52e03dd0eb3b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -338,15 +338,12 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	rate = clk_round_rate(d->clk, newrate);
 	if (rate > 0) {
 		/*
-		 * Premilinary set the uartclk to the new clock rate so the
-		 * clock update event handler caused by the clk_set_rate()
-		 * calling wouldn't actually update the UART divisor since
-		 * we about to do this anyway.
+		 * Note that any clock-notifer worker will block in
+		 * serial8250_update_uartclk() until we are done.
 		 */
-		swap(p->uartclk, rate);
 		ret = clk_set_rate(d->clk, newrate);
-		if (ret)
-			swap(p->uartclk, rate);
+		if (!ret)
+			p->uartclk = rate;
 	}
 	clk_prepare_enable(d->clk);
 
-- 
2.32.0

