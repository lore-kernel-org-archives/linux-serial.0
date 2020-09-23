Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B392BC4727E
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 16:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0AC208E4
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIWQUH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:20:07 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40290 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIWQUB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 12:20:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C0796803086A;
        Wed, 23 Sep 2020 16:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M6bFa9JfLHjy; Wed, 23 Sep 2020 19:19:55 +0300 (MSK)
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
Subject: [PATCH 3/3] serial: 8250_dw: Fix clk-notifier/port suspend deadlock
Date:   Wed, 23 Sep 2020 19:19:50 +0300
Message-ID: <20200923161950.6237-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
References: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It has been discovered that there is a potential deadlock between
the clock-change-notifier thread and the UART port suspending one:

   CPU0 (suspend CPU/UART)   CPU1 (update clock)
            ----                    ----
   lock(&port->mutex);
                             lock((work_completion)(&data->clk_work));
                             lock(&port->mutex);
   lock((work_completion)(&data->clk_work));

   *** DEADLOCK ***

The best way to fix this is to eliminate the CPU0
port->mutex/work-completion scenario. So we suggest to register and
unregister the clock-notifier during the DW APB UART port probe/remove
procedures, instead of doing that at the points of the port
startup/shutdown.

Link: https://lore.kernel.org/linux-serial/f1cd5c75-9cda-6896-a4e2-42c5bfc3f5c3@redhat.com

Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/tty/serial/8250/8250_dw.c | 54 +++++++++++--------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 87f450b7c177..9e204f9b799a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -373,39 +373,6 @@ static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
 	serial8250_do_set_ldisc(p, termios);
 }
 
-static int dw8250_startup(struct uart_port *p)
-{
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	int ret;
-
-	/*
-	 * Some platforms may provide a reference clock shared between several
-	 * devices. In this case before using the serial port first we have to
-	 * make sure that any clock state change is known to the UART port at
-	 * least post factum.
-	 */
-	if (d->clk) {
-		ret = clk_notifier_register(d->clk, &d->clk_notifier);
-		if (ret)
-			dev_warn(p->dev, "Failed to set the clock notifier\n");
-	}
-
-	return serial8250_do_startup(p);
-}
-
-static void dw8250_shutdown(struct uart_port *p)
-{
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-
-	serial8250_do_shutdown(p);
-
-	if (d->clk) {
-		clk_notifier_unregister(d->clk, &d->clk_notifier);
-
-		flush_work(&d->clk_work);
-	}
-}
-
 /*
  * dw8250_fallback_dma_filter will prevent the UART from getting just any free
  * channel on platforms that have DMA engines, but don't have any channels
@@ -501,8 +468,6 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->serial_out	= dw8250_serial_out;
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
-	p->startup	= dw8250_startup;
-	p->shutdown	= dw8250_shutdown;
 
 	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
 	if (!p->membase)
@@ -622,6 +587,19 @@ static int dw8250_probe(struct platform_device *pdev)
 		goto err_reset;
 	}
 
+	/*
+	 * Some platforms may provide a reference clock shared between several
+	 * devices. In this case any clock state change must be known to the
+	 * UART port at least post factum.
+	 */
+	if (data->clk) {
+		err = clk_notifier_register(data->clk, &data->clk_notifier);
+		if (err)
+			dev_warn(p->dev, "Failed to set the clock notifier\n");
+		else
+			queue_work(system_unbound_wq, &data->clk_work);
+	}
+
 	platform_set_drvdata(pdev, data);
 
 	pm_runtime_set_active(dev);
@@ -648,6 +626,12 @@ static int dw8250_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
+	if (data->clk) {
+		clk_notifier_unregister(data->clk, &data->clk_notifier);
+
+		flush_work(&data->clk_work);
+	}
+
 	serial8250_unregister_port(data->data.line);
 
 	reset_control_assert(data->rst);
-- 
2.27.0

