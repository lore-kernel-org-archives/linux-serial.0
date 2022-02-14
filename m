Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A9C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 14 Feb 2022 22:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiBNWHj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Feb 2022 17:07:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBNWHi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Feb 2022 17:07:38 -0500
X-Greylist: delayed 2213 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 14:07:30 PST
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B013C391
        for <linux-serial@vger.kernel.org>; Mon, 14 Feb 2022 14:07:29 -0800 (PST)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nJivO-00AkGx-Ej; Mon, 14 Feb 2022 21:30:22 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] serial: imx: leave IRTS disabled if using modem-control CTS
Date:   Mon, 14 Feb 2022 13:30:20 -0800
Message-Id: <20220214213020.685-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If using modem-control gpios for CTS we must leave IRTS disabled
as otherwise the hardware will only transmit based on the internal RTS
pin routed to it.

This allows hardware flow control to be used with cts-gpios.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/tty/serial/imx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index df8a0c8b8b29..bf2bb987a51f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -201,6 +201,7 @@ struct imx_port {
 	unsigned int		old_status;
 	unsigned int		have_rtscts:1;
 	unsigned int		have_rtsgpio:1;
+	unsigned int		have_ctsgpio:1;
 	unsigned int		dte_mode:1;
 	unsigned int		inverted_tx:1;
 	unsigned int		inverted_rx:1;
@@ -1674,8 +1675,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (ucr2 & UCR2_CTS)
 			ucr2 |= UCR2_CTSC;
 	}
-
-	if (termios->c_cflag & CRTSCTS)
+	if (!sport->have_ctsgpio && termios->c_cflag & CRTSCTS)
 		ucr2 &= ~UCR2_IRTS;
 	if (termios->c_cflag & CSTOPB)
 		ucr2 |= UCR2_STPB;
@@ -2227,6 +2227,9 @@ static int imx_uart_probe(struct platform_device *pdev)
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode = 1;
 
+	if (of_get_property(np, "cts-gpios", NULL))
+		sport->have_ctsgpio = 1;
+
 	if (of_get_property(np, "rts-gpios", NULL))
 		sport->have_rtsgpio = 1;
 
-- 
2.17.1

