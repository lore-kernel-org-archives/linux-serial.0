Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73ACC43460
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B230F61584
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhDUJ4J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236658AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0863E61449;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=VDY8bT7ZtIVa5rbi0AREGhMpOoStmEZTySzaL8SpSY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgfOiJEApY8BJ52tzHEsOO1DppxksDEmgge+mDEgf6Lugl28WGiubjIeC6rsKo6qr
         iS/j4ebgcKcO30vg1eLgW/e4rPSg9MJJoXD87Wm885FhMMvGpEyhV21W29KZ1uUU18
         vyHxZ0s8u6X+JsfXP6fNfitDJJrgWxe4m7G8QP1soLC2s0Tr5Bm86t53dX9xm/3iLv
         bD7ny5z5xe62ig+ya87DosOPKMxha2OqnV6Ubp9j55UIgla6xwPPQOz0OfA91ukWTE
         OJUYlsJvjE2820BqVsuI1bHp65/TTUjHrNWN+99yxWGYtEMSaHU1D8hLi2EDKBI8Vf
         AIp/hPVRXiQ1w==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a6-0000oP-SG; Wed, 21 Apr 2021 11:55:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 02/26] serial: altera_jtaguart: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:45 +0200
Message-Id: <20210421095509.3024-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 53dd0ba7a6f4 ("tty: serial: altera_jtag: drop uart_port->lock
before calling tty_flip_buffer_push()") claimed to address a locking
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
 drivers/tty/serial/altera_jtaguart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index d0ca9cf29b62..23c4e0e79694 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -131,9 +131,7 @@ static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
 		uart_insert_char(port, 0, 0, ch, flag);
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
-	spin_lock(&port->lock);
 }
 
 static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
-- 
2.26.3

