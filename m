Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E42C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F4361456
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhDUJ4T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238644AbhDUJ4K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1925C61582;
        Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998937;
        bh=Ksv9YjFjtrxObzx24ubHLCHYQzR97rDs6O9O5M32Y9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xo+gdLo0wZl88+ZIU9ETD9DQj6nAHMGqRZR2vfMBWax16YBxqPkVI5VMNVSWs4qnK
         Zd4TWxWiHjicP+wl+WqBseoTfB4K21KLh3erQaiCWT/opq0Ek42jQzGJ9C2ipNBZ4x
         mSImIylqi+06i72GoMQ74cmWFMJLCP/Jlxyv5bz0qpboJvHV67JhAQW3w6eQPKYShW
         t99UXt06Pdfx3CcuXE5kzQlSvJkCZsA4Jv1n+PEJR5a/cqXgJ18FPaOHZif8jZhNdV
         05T6y+XIcK+EA9GMTMDaaJhbaI5ZIEYxWTOnQtOqKMi6KAajDBNdKlYJz5j3VEoI3K
         cxsKw49p2AxRQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000on-Hf; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 10/26] serial: bcm63xx: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:53 +0200
Message-Id: <20210421095509.3024-11-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit b4d499241c34 ("tty: serial: bcm63xx: drop uart_port->lock before
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
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/bcm63xx_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 5674da2b76f0..5fb0e84f7fd1 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -294,9 +294,7 @@ static void bcm_uart_do_rx(struct uart_port *port)
 
 	} while (--max_count);
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tty_port);
-	spin_lock(&port->lock);
 }
 
 /*
-- 
2.26.3

