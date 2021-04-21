Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D14CC4360C
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A75F61449
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhDUJ4M (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238597AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C43161457;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=i9atm7wmPJeQwTfhi8Aqvj/HCbBa43kwL5SDOxWMer0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4I+IO5bhSqd9MtqHtgdL4fswqpXZuYFI6Yxe9t04apuJc0MJ7nbNw4Zq1SqqRM2E
         lklwSKlJMYkVw/a/u8P4S6Kj+HSLH+sN20lmaP4F/TkNrXDyFk23blzISUzH50fPqu
         DqAnfnIT9/K3+Y8C2YDLcaaRP4ia3SP5H5fefz6VxBFQJT1s1WWdtubGVu31vRzXZF
         qMKZSJc1bDC/wAlkqpAlLJUslu9N458JwvqjDvs5kpMOrfQQRgBXSKBaHMEnZb0t+l
         LHaMFZp+5xQgG77H9kfjri26rj7sWG6NtFraZ4T0eJFSYeSZTS2hbqvI3Uii53KxMe
         OiYTqWvJ53sug==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000ok-FL; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 09/26] serial: atmel_serial: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:52 +0200
Message-Id: <20210421095509.3024-10-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 1ecc26bd2789 ("atmel_serial: split the interrupt handler") worked
around the infamous low_latency behaviour of tty_flip_buffer_push() by
dropping and reacquiring the port lock in the tasklet callback.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Cc: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/atmel_serial.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a24e5c2b30bc..058886d9045b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1178,13 +1178,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 			       1,
 			       DMA_FROM_DEVICE);
 
-	/*
-	 * Drop the lock here since it might end up calling
-	 * uart_start(), which takes the lock.
-	 */
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 
 	atmel_uart_writel(port, ATMEL_US_IER, ATMEL_US_TIMEOUT);
 }
@@ -1576,13 +1570,7 @@ static void atmel_rx_from_ring(struct uart_port *port)
 		uart_insert_char(port, status, ATMEL_US_OVRE, c.ch, flg);
 	}
 
-	/*
-	 * Drop the lock here since it might end up calling
-	 * uart_start(), which takes the lock.
-	 */
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
-	spin_lock(&port->lock);
 }
 
 static void atmel_release_rx_pdc(struct uart_port *port)
@@ -1667,13 +1655,7 @@ static void atmel_rx_from_pdc(struct uart_port *port)
 		}
 	} while (head >= pdc->dma_size);
 
-	/*
-	 * Drop the lock here since it might end up calling
-	 * uart_start(), which takes the lock.
-	 */
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 
 	atmel_uart_writel(port, ATMEL_US_IER,
 			  ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
-- 
2.26.3

