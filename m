Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC7C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 11 Sep 2021 13:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1FC61153
	for <linux-serial@archiver.kernel.org>; Sat, 11 Sep 2021 13:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhIKNXq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Sep 2021 09:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237247AbhIKNVj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Sep 2021 09:21:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 742C361153;
        Sat, 11 Sep 2021 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631366425;
        bh=uBS6z2kpKZAxkYk/i40/4ZfBY9GbBSjJVHSkEn8KARA=;
        h=From:To:Cc:Subject:Date:From;
        b=UocxJ7ZlfwMj7ol7WkDG6ZlzXlhHnzqioyQbGz3Aqi+8foenvDRPPI/x8P4Puzbey
         JGnqozH5bGbXRY9wKCmFmxuWe1qukTDflCX0N9MRn40/VzcRKjcaasAjNtMS+x1ESv
         QUiVWAEP/G5NNhkieD3SSWUMbjnnAnTDmJOsT7Z22tj93ABdUrJokDbzQbs6yJgvf+
         Le+sC1wyPQb1pK7Yb3Anwi0CSAGIVes9qWbrXxxeVrUNM0hZduaHoMIpbZ9dLnt76g
         1dQHZkpwmAPXACP6MwQpg3QpTLAnPfQyq4WAO/bdXHgTwub5JSvyKsku2gmKy8suuv
         325dcChTDvOMQ==
Received: by pali.im (Postfix)
        id F208788D; Sat, 11 Sep 2021 15:20:22 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: mvebu-uart: fix driver's tx_empty callback
Date:   Sat, 11 Sep 2021 15:20:17 +0200
Message-Id: <20210911132017.25505-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Driver's tx_empty callback should signal when the transmit shift register
is empty. So when the last character has been sent.

STAT_TX_FIFO_EMP bit signals only that HW transmit FIFO is empty, which
happens when the last byte is loaded into transmit shift register.

STAT_TX_EMP bit signals when the both HW transmit FIFO and transmit shift
register are empty.

So replace STAT_TX_FIFO_EMP check by STAT_TX_EMP in mvebu_uart_tx_empty()
callback function.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700 serial port")
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 590f58176dc3..56ba7180f66d 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -191,7 +191,7 @@ static unsigned int mvebu_uart_tx_empty(struct uart_port *port)
 	st = readl(port->membase + UART_STAT);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	return (st & STAT_TX_FIFO_EMP) ? TIOCSER_TEMT : 0;
+	return (st & STAT_TX_EMP) ? TIOCSER_TEMT : 0;
 }
 
 static unsigned int mvebu_uart_get_mctrl(struct uart_port *port)
-- 
2.20.1

