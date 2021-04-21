Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B527C43617
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2419D61448
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbhDUJ4N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238583AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CB6A6144F;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=dLdHsb0G5vHHwinxbCFbMP5LZuwkh8IRJ8RB0D4Yqzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5riJqE6OIsWtN/+3NKWPNr9jKi1Gj43LxlGFNQN1T60or2LGD0HiUSQAfVi6v3CE
         YV45JGK2dsRqBu6zQsyS+gxfILfis/j9uNH0f1yfX2z2654qob8uMaeRAT6Tc/l0MR
         ogh/wI97yp5WlaVBcvUsfgZIBfgD+mYevx2IqUXTOQTLy7sA5bTTsX6neaL++ZaSIW
         c/G+pjsugHpFs7ZZKAI5+K4zYyzvpfBGKR+3Z1/jPWQ7vcz47fGNUcuHWzMeTp+4Ub
         8Ep6tP+GOgjxLLG5TU4U++OqmGYV3219MYPxUDOn3e/9GtT1iHbs/4g9a7phDVHWWP
         3OFScldzFMxUA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000oe-9s; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 07/26] serial: ar933x: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:50 +0200
Message-Id: <20210421095509.3024-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit b16c8e3eed12 ("tty: serial: ar933x: drop uart_port->lock before
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
 drivers/tty/serial/ar933x_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index c2be7cf91399..4379ca4842ae 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -385,9 +385,7 @@ static void ar933x_uart_rx_chars(struct ar933x_uart_port *up)
 			tty_insert_flip_char(port, ch, TTY_NORMAL);
 	} while (max_count-- > 0);
 
-	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(port);
-	spin_lock(&up->port.lock);
 }
 
 static void ar933x_uart_tx_chars(struct ar933x_uart_port *up)
-- 
2.26.3

