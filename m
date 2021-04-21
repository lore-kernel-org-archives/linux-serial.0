Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873BBC43600
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5664E61449
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbhDUJ4L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238572AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19EF861451;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=cURs5qeivDO5gSpr3eXq9wzmT4dyWiefnPZY7i1667s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+KYjIEvH9GgdfxZNZcO1DDWyZcnv8ddmk5RhHUdm6aSSIfNCEl9dSMUcPLgOageL
         6IOlDbO0Qd3zBKHrDwQJYvUu5bULwmIazEH5oifM0WTISWEhcuS2gqAly+kY4yotZ7
         L/j0ldBynmpxM7dLkvcnmk00bZdfonccanPiLEyEOgndL7/ZGNz0Sg7b0V3TtpxEZm
         3JlcMmovw/f+I1Lk1rs0rIAtY1v7tRNZgwVp122u4n8vKuRfUoIsEjavj0ycmhXtFP
         HxXrzm4W1+j25Lu+qkvIh+XEBCBgIFyCdpPJHrnnPp8LYl5wEtL842xx7jHKSiTNfg
         MZi7rk96MtPlA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a6-0000oR-Uu; Wed, 21 Apr 2021 11:55:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 03/26] serial: altera_uart: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:46 +0200
Message-Id: <20210421095509.3024-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit dd085ed8ef6c ("tty: serial: altera: drop uart_port->lock before
calling tty_flip_buffer_push()") claimed to address a locking
issue but only provided a dubious lockdep splat from an unrelated
driver, which in the end turned out to be due a broken local change
carried by the author.

Unfortunately these patches were merged before the issue had been
analysed properly so the commit messages makes no sense whatsoever.

The real issue was first seen on RT which at the time effectively always
set the low_latency flag for all serial drivers by patching
tty_flip_buffer_push(). This in turn revealed that many drivers did not
handle the infamous low_latency behaviour which meant that data was
pushed immediately to the line discipline instead of being deferred to a
work queue.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks
around.

Link: https://lore.kernel.org/linux-serial/cover.1376923198.git.viresh.kumar@linaro.org/
Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/altera_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 0e487ce091ac..7c5f4e966b59 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -243,9 +243,7 @@ static void altera_uart_rx_chars(struct altera_uart *pp)
 				 flag);
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
-	spin_lock(&port->lock);
 }
 
 static void altera_uart_tx_chars(struct altera_uart *pp)
-- 
2.26.3

