Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED9DC43462
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E262861440
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhDUJ4K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238561AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D66F6144D;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=lvwBKD97+NUIwzp6iuTX9dyTCtZuijRxUhqW74+TeWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzZU18GKmzQGtWSiF3u7PXq+tZoDUEEPqjdSlVbN0TinJZHKKp/3KqZbc7UX7kVX2
         S5IGXt6Eji0dk7Z25gxtwdZ/3EmQLeHjs0mibXxFSvaGjXc8Nw9qTTdKbicR3ZY/Mp
         YZgEsZBsCwGZMuoQ0dUd1K5opQ3QwmndGphFj2g2bPygKcEmNq4k6LBhsRpHGssE29
         /Jv0CoHWOpO2HpxnvsH9DeBN9A9buVwzo1UMhy7ft+FYU+JfXv6yU6YJWCNcGva7j9
         8qAENV+wQaxpFVpxrSZA45oC9WCtwRCW36WJd5M6rHdih/+rlLU0Ro36OEU0LMiB8S
         gkAKTkKYe9okw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000oY-4S; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 05/26] serial: amba-pl011: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:48 +0200
Message-Id: <20210421095509.3024-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit ead76f329f77 ("ARM: 6763/1: pl011: add optional RX DMA to PL011
v2") added RX DMA support and also reproduced the workaround for the
infamous low_latency behaviour of tty_flip_buffer_push() by dropping and
reacquiring the port lock during receive processing.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Note that the port lock is also dropped in the PIO path
(see pl011_rx_chars), but it is not clear whether this is still needed
by the DMA code added by the aforementioned commit.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/amba-pl011.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4ead0c9048a8..78682c12156a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -937,12 +937,10 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 		fifotaken = pl011_fifo_to_tty(uap);
 	}
 
-	spin_unlock(&uap->port.lock);
 	dev_vdbg(uap->port.dev,
 		 "Took %d chars from DMA buffer and %d chars from the FIFO\n",
 		 dma_count, fifotaken);
 	tty_flip_buffer_push(port);
-	spin_lock(&uap->port.lock);
 }
 
 static void pl011_dma_rx_irq(struct uart_amba_port *uap)
-- 
2.26.3

