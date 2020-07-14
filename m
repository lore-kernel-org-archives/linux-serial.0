Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99170C433E3
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 12:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D052242C
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 12:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGNMsR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:48:17 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33070 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGNMsQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jul 2020 08:48:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 894A3803202D;
        Tue, 14 Jul 2020 12:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QahHFbfq1Bc7; Tue, 14 Jul 2020 15:48:12 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Maxime Ripard <mripard@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-mips@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 3/4] serial: 8250_dw: Pass the same rate to the clk round and set rate methods
Date:   Tue, 14 Jul 2020 15:48:06 +0300
Message-ID: <20200714124808.21493-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200714124808.21493-1-Sergey.Semin@baikalelectronics.ru>
References: <20200714124808.21493-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Indeed according to the clk API if clk_round_rate() has successfully
accepted a rate, then in order setup the clock with value returned by the
clk_round_rate() the clk_set_rate() method must be called with the
original rate value.

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v8:
- This is a new patch created by the Russell King suggestion.
---
 drivers/tty/serial/8250/8250_dw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 12866083731d..c1511f9244bb 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -275,15 +275,15 @@ dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 			       struct ktermios *old)
 {
-	unsigned int baud = tty_termios_baud_rate(termios);
+	unsigned long newrate = tty_termios_baud_rate(termios) * 16;
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
 	long rate;
 	int ret;
 
 	clk_disable_unprepare(d->clk);
-	rate = clk_round_rate(d->clk, baud * 16);
+	rate = clk_round_rate(d->clk, newrate);
 	if (rate > 0) {
-		ret = clk_set_rate(d->clk, rate);
+		ret = clk_set_rate(d->clk, newrate);
 		if (!ret)
 			p->uartclk = rate;
 	}
-- 
2.26.2

