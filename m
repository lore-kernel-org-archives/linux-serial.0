Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F57C4361A
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090A261449
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbhDUJ4S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238620AbhDUJ4K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6E206145B;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=rpTrUwy38tMF4LXHWp5J+Jv1V+4HlHiORTormNkoodU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvWf0IoKfhZ+hNZQ24jntnjzzoOv1G8xte4bMStk7WAmXLPCb1DUIEXzAOZizz7Xf
         HVeofCpUtWdDiyYjhJP1hCYhx0a6ncoXIcLMof4XT3s6aCEkmcsUShg1BUY9Q1XH5M
         cx12uy7NX5R9d3cnrdlTRVm5gdbjy4KgGJZIp16FLE/XuKc4fshO8nTBJTLkXVxX4O
         w6hu7yLNCiLyd0Ax4AW4KjJIg7WPxKbMHUUR34h7lpMB5gXCzDP0CdQh2N4J0rCJ8L
         HexyA08lOb/K+w3K0qJC2bu+XJx9uhy9nh2jXGTMyhs1fl8uuuM4abLXemSdtMwgJb
         o1O89ga9ZjXRw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000p3-0B; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 15/26] serial: mpc52xx_uart: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:58 +0200
Message-Id: <20210421095509.3024-16-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit fbe543b412ce ("Fix a potential issue in mpc52xx uart driver")
worked around the infamous low_latency behaviour of
tty_flip_buffer_push() by simply dropping and reacquiring the port lock
in the interrupt handler.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/mpc52xx_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index af1700445251..2704dc988e4a 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1421,9 +1421,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		}
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 
 	return psc_ops->raw_rx_rdy(port);
 }
-- 
2.26.3

