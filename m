Return-Path: <SRS0=gGpx=DC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1FAC4363D
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8EF208A9
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 08:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Ndz2p70T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgIYId3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Sep 2020 04:33:29 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:60904 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYId2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Sep 2020 04:33:28 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 04:33:28 EDT
IronPort-SDR: oukt6M82CajUSxmUI3NFGy+/eRMaQNpCdyRFjRXdYhvcXH+yPZNxZqv/9mDpWDEj/FS3ZQUoAO
 5x3Z2HDIcow8spsV3lHRjho++hR80/EBfPVQlEEUT8axsGruIzYF6ULT4vqXwA147V5sVvTXRc
 L4lJtfJillK8mrS7gTf22lzNsyWFFpWaLZLYKGodOZtXVIB+iiHvuuLBqiWWVLB1VtnjJ0z7ro
 3bbEuQqTmoKNsC2+nn3rHYs9PBIpTAg7FeCtRF0ESrI0mBSaw9gaoV5JYUMSncZa4wqpOiQ3SG
 4dU=
X-IronPort-AV: E=Sophos;i="5.77,301,1596492000"; 
   d="scan'208";a="14020024"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Sep 2020 10:26:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 25 Sep 2020 10:26:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 25 Sep 2020 10:26:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1601022379; x=1632558379;
  h=from:to:cc:subject:date:message-id;
  bh=wa4VDC7nYhm5Z0O3jCNMttNKrenLGZ76s9lR1PPSFmk=;
  b=Ndz2p70TJxcP/HF+mJCDKAnS9exTlUWaZba0QMxZSo06G0DlX7OsiSC0
   Ep9Jv6q1X9BupahCBqeFfPxB+75i5YKo0DWZ15R/BgOhtu6zMDCzD6CyM
   4kC8Amr8oSeAoP+k8teu5ggq+9pxOiCJTOVjOi8DLQeOqpN3HFSey/wxN
   0IUBcEhe6zx3XmcMFm+qgw1KXS9+todCJ92wJHcPrLiwveDMDQERUKzxT
   SEZ/LtYutHV38/+uncqoNYQ7xaXWNHer1RZvbsNs0EhJAWOe8bl1pI5MD
   DzCvNxMhJo6xPQRD5mzJnPBn/9EVw85eVXZrZ5GHM00NYYsoxEsBx0t9C
   g==;
IronPort-SDR: WOXDDWsnRCO4+uDrIDHyKZ5W0HGF4eNYnH3SogLviEQcXGb+xihJQgo/wf1N6D5GoZWYekR32j
 5ClPcid/rnmYWzk66AgoojnEwhooxHw1qWSuM5iBuq+XpIzZGPCKhltWQHgDsU8OB8Do1p/c09
 UqYBB7GtMQdqo+sbwDsQgr8OEYTMMNKMt6c8R1aEQT7QVa3v/QR3nAVKFopZ6YN1lxKj5nUWwU
 FF5saJ3TiFy+jvrgw/Ut1Dzuvgj4l4edpKKO8ndLJ1S4DBblKjLjZ+nQUHbmGXBp5/BLCoFpDD
 43w=
X-IronPort-AV: E=Sophos;i="5.77,301,1596492000"; 
   d="scan'208";a="14020023"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Sep 2020 10:26:19 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id D3CDB280070;
        Fri, 25 Sep 2020 10:26:18 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] tty: serial: imx: disable TXDC IRQ in imx_uart_shutdown() to avoid IRQ storm
Date:   Fri, 25 Sep 2020 10:24:12 +0200
Message-Id: <20200925082412.12960-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The IPG clock is disabled at the end of imx_uart_shutdown(); we really
don't want to run any IRQ handlers after this point.

At least on i.MX8MN, the UART will happily continue to generate interrupts
even with its clocks disabled, but in this state, all register writes are
ignored (which will cause the shadow registers to differ from the actual
register values, resulting in all kinds of weirdness).

In a transfer without DMA, this could lead to the following sequence of
events:

- The UART finishes its transmission while imx_uart_shutdown() is run,
  triggering the TXDC interrupt (we can trigger this fairly reliably by
  writing a single byte to the TTY and closing it right away)
- imx_uart_shutdown() finishes, disabling the UART clocks
- imx_uart_int() -> imx_uart_transmit_buffer() -> imx_uart_stop_tx()

imx_uart_stop_tx() should now clear UCR4_TCEN to disable the TXDC
interrupt, but this register write is ineffective. This results in an
interrupt storm.

To disable all interrupts in the same place, and to avoid setting UCR4
twice, clearing UCR4_OREN is moved below del_timer_sync() as well; this
should be harmless.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

While debugging this, I found one more instance of register writes with
disabled clock: The IPG clock is disabled before calling
uart_add_one_port() at the end of imx_uart_probe(). This results in the
following call stack:

    imx_uart_writel+0x168/0x188
    imx_uart_set_mctrl+0x3c/0xb8
    uart_add_one_port+0x394/0x4c8
    imx_uart_probe+0x530/0x810

Fortunately, in this case the register already matches the value that is
written, so no inconsistent state results. I assume we'll have to do
something about the way we handle the clocks in this driver to fix
this...


 drivers/tty/serial/imx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4e6ead1f650e..1731d9728865 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1552,10 +1552,6 @@ static void imx_uart_shutdown(struct uart_port *port)
 	ucr2 = imx_uart_readl(sport, UCR2);
 	ucr2 &= ~(UCR2_TXEN | UCR2_ATEN);
 	imx_uart_writel(sport, ucr2, UCR2);
-
-	ucr4 = imx_uart_readl(sport, UCR4);
-	ucr4 &= ~UCR4_OREN;
-	imx_uart_writel(sport, ucr4, UCR4);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	/*
@@ -1568,10 +1564,15 @@ static void imx_uart_shutdown(struct uart_port *port)
 	 */
 
 	spin_lock_irqsave(&sport->port.lock, flags);
+
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN | UCR1_RXDMAEN | UCR1_ATDMAEN);
-
 	imx_uart_writel(sport, ucr1, UCR1);
+
+	ucr4 = imx_uart_readl(sport, UCR4);
+	ucr4 &= ~(UCR4_OREN | UCR4_TCEN);
+	imx_uart_writel(sport, ucr4, UCR4);
+
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	clk_disable_unprepare(sport->clk_per);
-- 
2.17.1

