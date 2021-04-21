Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE2FC43603
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435986143D
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhDUJ4S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238635AbhDUJ4K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC0706144B;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998937;
        bh=GVPfk0mAo7vQ7QjS+H2k7vwU1xfsL+gPVDRgR1gJDKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAFyDP98w31evAM3oupoz3JbyFfMn6JwJEySs4Jx6/UCDv41LBRcki3To9QyXtjSt
         E2AzZTrw5x40Nz7iYQIbe8b450tJg2Bv4Pkk5l8+iaQbzHhnqvQ+gP2qSG1md1VdUt
         3JSLDQUY32gQ04g+rKtPhsq5XHyeUP+afa0aVoFRizMjyuv81vhoNGSC16eqm50hFO
         hNUAJbRdCE15F4wsheh+abpYJR5Wf5eD6TNGWW1Yw7s/THJIoB0elNEzGQm6NLJxre
         Y1Q3LqNeztvqZnC+6IUJNK38mYs/kcXI5QdTiyxzBLlPyC3PWqsOWP0VFor5pUrdrQ
         qd314QtYqjp+A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000pC-7x; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 18/26] serial: rda: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:55:01 +0200
Message-Id: <20210421095509.3024-19-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The rda driver has always carried an unnecessary workaround for the
infamous low_latency behaviour of tty_flip_buffer_push(), which had
been removed years before the driver was added by commit c10b13325ced
("tty: serial: Add RDA8810PL UART driver").

Specifically, since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/rda-uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 85366e059258..d550d8fa2fab 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -398,9 +398,7 @@ static void rda_uart_receive_chars(struct uart_port *port)
 		status = rda_uart_read(port, RDA_UART_STATUS);
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
-	spin_lock(&port->lock);
 }
 
 static irqreturn_t rda_interrupt(int irq, void *dev_id)
-- 
2.26.3

