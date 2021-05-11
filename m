Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177E5C43603
	for <linux-serial@archiver.kernel.org>; Tue, 11 May 2021 20:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D616061433
	for <linux-serial@archiver.kernel.org>; Tue, 11 May 2021 20:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhEKUDN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 May 2021 16:03:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41649 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhEKUDM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 May 2021 16:03:12 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 60FA722276;
        Tue, 11 May 2021 22:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620763324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZTjCem//lORsrW2aZZoL2zcRsJc/XV9BfrVa5PsRBI=;
        b=hHxWv6YV92fZn+rC9QP1lob/Jr3OhT3DhKB9PJTedMG8bOi/Ohjpz3W/ufXDDewjVeGvVI
        q4n7fUlaUOEnv3qgVR/FzDjqb7KZDBRP1mI8Zxc3QlOKFqWx5WVGQPOKn4HXMobUtRF3uA
        efLbbWb1nSQ5oBUNHfd8FUBfOcRTBR4=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 6/8] serial: fsl_lpuart: remove manual RTSCTS control from 8-bit LPUART
Date:   Tue, 11 May 2021 22:01:46 +0200
Message-Id: <20210511200148.11934-7-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511200148.11934-1-michael@walle.cc>
References: <20210511200148.11934-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The LPUART doesn't have the ability to control the RTS or CTS line
manually. Instead it will set it automatically when data is send or
handle it when data is received. Thus drop the wrong code in set_mctrl.
For the 32 bit version this was already done in the commit 2b30efe2e88a
("tty: serial: lpuart: Remove unnecessary code from set_mctrl"). Keep
the 8-bit version in sync and remove it there, too.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 74c04dba02d4..19714047d571 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1403,17 +1403,7 @@ static int lpuart32_config_rs485(struct uart_port *port,
 
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
-	unsigned int temp = 0;
-	unsigned char reg;
-
-	reg = readb(port->membase + UARTMODEM);
-	if (reg & UARTMODEM_TXCTSE)
-		temp |= TIOCM_CTS;
-
-	if (reg & UARTMODEM_RXRTSE)
-		temp |= TIOCM_RTS;
-
-	return temp;
+	return 0;
 }
 
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
@@ -1423,23 +1413,7 @@ static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 
 static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	unsigned char temp;
-	struct lpuart_port *sport = container_of(port,
-				struct lpuart_port, port);
-
-	/* Make sure RXRTSE bit is not set when RS485 is enabled */
-	if (!(sport->port.rs485.flags & SER_RS485_ENABLED)) {
-		temp = readb(sport->port.membase + UARTMODEM) &
-			~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
-
-		if (mctrl & TIOCM_RTS)
-			temp |= UARTMODEM_RXRTSE;
 
-		if (mctrl & TIOCM_CTS)
-			temp |= UARTMODEM_TXCTSE;
-
-		writeb(temp, port->membase + UARTMODEM);
-	}
 }
 
 static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
-- 
2.20.1

