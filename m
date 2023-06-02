Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBFC7EE24
	for <linux-serial@archiver.kernel.org>; Fri,  2 Jun 2023 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjFBNb0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjFBNbC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Jun 2023 09:31:02 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175D1E6B;
        Fri,  2 Jun 2023 06:30:49 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QXkQr3j0wz9sZS;
        Fri,  2 Jun 2023 15:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernhard-seibold.de;
        s=MBO0001; t=1685712644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pxR9asucUbPnHQ2rd0x8odzYWEoyPJpGshrHAYKT8gg=;
        b=WpcOU4pzPb3QdfSG7kEkwTgflk0rwNkXKP0qR87pCOYwaiiqz+z7TQWEuExvPPfu0Mwi31
        QUw7OEMZKVeIuyN/V+A0lWr7KFUAiwOF+Md3An9384lDPe/Qnc12vVK6j92PCeeVHuiobe
        YhHT3sPYRCay6mCjGBhDbALqB2jNGGA2kZryXDYTyABuOua4yJERHTaq/lmNj1bUu4jj4D
        haApex67hkJV9GmARwLgpeuUcJnNHKmbrfidhzElYhUQ09jaUoZwO5PbeIx0K2hF0y4abx
        Z5xj+8jNopze4F7te+WaqZ0vhr/2Ii2b2x3S9nA1PozjF5krIMd5v7833AbZUQ==
From:   Bernhard Seibold <mail@bernhard-seibold.de>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        stable@vger.kernel.org
Subject: [PATCH] serial: lantiq: add missing interrupt ack
Date:   Fri,  2 Jun 2023 15:30:29 +0200
Message-Id: <20230602133029.546-1-mail@bernhard-seibold.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QXkQr3j0wz9sZS
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently, the error interrupt is never acknowledged, so once active it
will stay active indefinitely, causing the handler to be called in an
infinite loop.

Fixes: 2f0fc4159a6a ("SERIAL: Lantiq: Add driver for MIPS Lantiq SOCs.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
---
 drivers/tty/serial/lantiq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index a58e9277dfad..f1387f1024db 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -250,6 +250,7 @@ lqasc_err_int(int irq, void *_port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 
 	spin_lock_irqsave(&ltq_port->lock, flags);
+	__raw_writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
 	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
-- 
2.34.1

