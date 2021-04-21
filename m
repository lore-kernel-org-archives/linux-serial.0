Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5025C4363C
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A774E61440
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbhDUJ4T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238640AbhDUJ4K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11FCF61581;
        Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998937;
        bh=YKMnP0+4p6GKexVrNEN7sv2xmhyZgFqSF1QOLT/GVgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uL9yfpCPXLBNkbfnvYL+7d8+lEQIo7kRyvRKzPgiiZmsKe50beZDA5i7+HfVzpdtV
         72ziLDAsCe1eiJAPNFGVjwdyvAhv2wO0F8dRRerOdJi4Lrtu07rftNPOj2YC+7+nfo
         u8rI8UZeXZavmpnGq/hDcv1goSXtL+zyiZWd+fhTgDJohsEHRd28rKynVhIQ8LYcKb
         mIy3gV8es3gb1s70+ZG63dwgXdxZJV3DsdftXM3GRZAU7sXhYJez/NOvwJ8fi86yUf
         AH7Z1B3pQULBUxph/CoSdS4QDjCn0GlvCdi+VWdfYl5BXgh4F4pmLiNyWD6KVzIfUL
         u5319UUw4TwPQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000pF-AW; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 19/26] serial: rp2: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:55:02 +0200
Message-Id: <20210421095509.3024-20-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit de7053c77123 ("tty: serial: rp2: drop uart_port->lock before
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
Cc: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/rp2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 5690c09cc041..d60abffab70e 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -424,9 +424,7 @@ static void rp2_rx_chars(struct rp2_uart_port *up)
 		up->port.icount.rx++;
 	}
 
-	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(port);
-	spin_lock(&up->port.lock);
 }
 
 static void rp2_tx_chars(struct rp2_uart_port *up)
-- 
2.26.3

