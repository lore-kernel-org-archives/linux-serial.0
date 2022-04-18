Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3599DC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 18 Apr 2022 09:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiDRJqg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiDRJqf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Apr 2022 05:46:35 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B01658F
        for <linux-serial@vger.kernel.org>; Mon, 18 Apr 2022 02:43:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [123.112.71.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CFE0F3F73C;
        Mon, 18 Apr 2022 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650275034;
        bh=mnuzZewD1ei3cC6dgyJPWZKZ32AIAIpJQ9wyJZC4Pz4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=B5bg9XvyIX+uWG1Ytx7R5HVidDijD0y5hbC1PGrrPdQ86RfRdsZ5lxysntXAWDfug
         DVZ+9O5Aj4DotIOhOJqPxx1HFIqxITJ7AnM0aX7yMoFawxmcY37IHJhtPmtHm9w8Wj
         kLe9t4e+eOiZTCy6M4ZPsJ8LIeQt+cLYKIJQ4ddBVfR6bp69QP4o+00LFdS1/3qYO2
         FOHnJbDy1XOnp3YLN5r1p1hi/8dao+lWURdrbvv7/lRXk98BgV77w3h79XHUhOq/hk
         Q6BpK1WdLHEuPgdWRmmLqUISq8rsUullGoRUY1hr6bXLivxg7a+QjbnvtT/j0LIf0c
         zzL2/pzeAK+nQ==
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     jringle@gridpoint.com, u.kleine-koenig@pengutronix.de,
        hui.wang@canonical.com
Subject: [PATCH] Revert "serial: sc16is7xx: Clear RS485 bits in the shutdown"
Date:   Mon, 18 Apr 2022 17:43:39 +0800
Message-Id: <20220418094339.678144-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 927728a34f11b5a27f4610bdb7068317d6fdc72a.

Once the uart_port->rs485->flag is set to SER_RS485_ENABLED, the port
should always work in RS485 mode. If users want the port to leave
RS485 mode, they need to call ioctl() to clear SER_RS485_ENABLED.

So here we shouldn't clear the RS485 bits in the shutdown().

Fixes: 927728a34f11 ("serial: sc16is7xx: Clear RS485 bits in the shutdown")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/tty/serial/sc16is7xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e857fb61efbf..5fb201c1b563 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1238,12 +1238,10 @@ static void sc16is7xx_shutdown(struct uart_port *port)
 
 	/* Disable all interrupts */
 	sc16is7xx_port_write(port, SC16IS7XX_IER_REG, 0);
-	/* Disable TX/RX, clear auto RS485 and RTS invert */
+	/* Disable TX/RX */
 	sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG,
 			      SC16IS7XX_EFCR_RXDISABLE_BIT |
-			      SC16IS7XX_EFCR_TXDISABLE_BIT |
-			      SC16IS7XX_EFCR_AUTO_RS485_BIT |
-			      SC16IS7XX_EFCR_RTS_INVERT_BIT,
+			      SC16IS7XX_EFCR_TXDISABLE_BIT,
 			      SC16IS7XX_EFCR_RXDISABLE_BIT |
 			      SC16IS7XX_EFCR_TXDISABLE_BIT);
 
-- 
2.25.1

