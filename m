Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5CAC433ED
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E2C61440
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhDUJ4R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238606AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8891061476;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=DCcpn8+8l2aLtK9AKW5k1cue+Hn6i+5BhnYqOqX865Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/Uqxr/3XQIK7l6SZGxOoi2Qz3BjbMM1tBBk3ygqwkm5ZCvVKQfCv0shfVEIGy97P
         5BAxBQY7xCiJ5U4urr3md0qK0LIc3KbZ31wemq31TTqUbqiF21YJq+im5WUXeG+AaM
         J6eeaeOiIfeJxExebHoY3pwDtONJLjoh+tul9eg1c9Bug+fdRCOhBCLsOG+0rgminC
         qgus81vH9TcC5A1qeOp3Zs63c2O3RyB66NRTPoRRVS11lHTfnhDMwo53sEtVHVYBqT
         SKX1+Ibozc1EbfFMA8geFqkLJXddJAdxZUShLAkrmcauV0QxP8uMKR3aLx7GXnfNDz
         vxTBEtY60gJSg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000ox-Qf; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 13/26] serial: mcf: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:56 +0200
Message-Id: <20210421095509.3024-14-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 5275ad70fed3 ("tty: serial: mcf: drop uart_port->lock before
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
 drivers/tty/serial/mcf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 09c88c48fb7b..c7cec7d03620 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -319,9 +319,7 @@ static void mcf_rx_chars(struct mcf_uart *pp)
 		uart_insert_char(port, status, MCFUART_USR_RXOVERRUN, ch, flag);
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
-	spin_lock(&port->lock);
 }
 
 /****************************************************************************/
-- 
2.26.3

