Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6083C43461
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FF86145E
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbhDUJ4Q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238623AbhDUJ4K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D31FE614A7;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=jAhal48nUBkxNr/OI/8m0GEk9l4t0uKOfM2maeSP+18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXoUqifiL8XidX2+Gpm10yapgoL5Y8Otb7iHgWgPT8LAPwMQnIJ99vP9laCo0pcnq
         qQqFQ+gk47TCo7XDebjao+7YBBB9tgeCY6E8YbF+YOKmzkCZAB2wdOe1b3VJGLZPxL
         impnXFIzgZLlpo1fjO5KxebuAHbPJVygQykZzzItDCjq7jjycKFXNK/AHuFRyDFAUX
         a41X5Y3utiEJSSA/4FrkqNo+32q7kiroaT+caFGorHTyn4rKq6JJukWsvg/uyuqZh2
         OBuAtDiHv+EonKEQ5TSKJiJIOyhUR/lEiQBVcaC8BWutrn0qW08K//PjWjuzdCXsDS
         3X6Wo5XRp7aug==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000pA-5R; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 17/26] serial: owl: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:55:00 +0200
Message-Id: <20210421095509.3024-18-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The owl driver has always carried an unnecessary workaround for the
infamous low_latency behaviour of tty_flip_buffer_push(), which had
been removed years before the driver was added by commit fc60a8b675bd
("tty: serial: owl: Implement console driver").

Specifically, since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/owl-uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index abc6042f0378..91f1eb0058d7 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -247,9 +247,7 @@ static void owl_uart_receive_chars(struct uart_port *port)
 		stat = owl_uart_read(port, OWL_UART_STAT);
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
-	spin_lock(&port->lock);
 }
 
 static irqreturn_t owl_uart_irq(int irq, void *dev_id)
-- 
2.26.3

