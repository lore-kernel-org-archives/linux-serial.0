Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF3AEB64DA
	for <linux-serial@archiver.kernel.org>; Sat, 24 Jun 2023 21:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjFXVJO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 24 Jun 2023 17:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFXVJN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 24 Jun 2023 17:09:13 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Jun 2023 14:09:11 PDT
Received: from mail.unseenlabs.fr (mail.unseenlabs.fr [51.91.207.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA01715
        for <linux-serial@vger.kernel.org>; Sat, 24 Jun 2023 14:09:11 -0700 (PDT)
Received: from localhost.localdomain (130.93.94.147) by S1014830.EX1014830.lan
 (51.91.207.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.30; Sat, 24 Jun
 2023 23:04:00 +0200
From:   Julien Malik <julien.malik@unseenlabs.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>,
        Julien Malik <julien.malik@unseenlabs.fr>
Subject: [PATCH] serial: xilinx_uartps: unset STOPBRK when setting STARTBRK
Date:   Sat, 24 Jun 2023 23:03:23 +0200
Message-ID: <20230624210323.88455-1-julien.malik@unseenlabs.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [130.93.94.147]
X-ClientProxiedBy: S1014830.EX1014830.lan (51.91.207.241) To
 S1014830.EX1014830.lan (51.91.207.241)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Zynq UG585 states, in chapter B.33, for XUARTPS_CR_STARTBRK:
It can only be set if STPBRK (Stop transmitter break) is not high

This fixes tcsendbreak, which otherwise does not actually break.

Signed-Off-By: Julien Malik <julien.malik@unseenlabs.fr>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8e521c69a959..2e69fceaa792 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -657,7 +657,7 @@ static void cdns_uart_break_ctl(struct uart_port *port, int ctl)
 	status = readl(port->membase + CDNS_UART_CR);
 
 	if (ctl == -1)
-		writel(CDNS_UART_CR_STARTBRK | status,
+		writel(CDNS_UART_CR_STARTBRK | (~CDNS_UART_CR_STOPBRK & status),
 				port->membase + CDNS_UART_CR);
 	else {
 		if ((status & CDNS_UART_CR_STOPBRK) == 0)
-- 
2.25.1

