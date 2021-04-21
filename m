Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39676C43470
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079836008E
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhDUJ4O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238601AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2834D61440;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=aru/Ih0Av7GxzcZcazb+Ui9kYy6sVxdsNzB3eD0DMVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StWhLcMAqMUJ8fHHL5DcwDmNGq/ksYveAqWKnvBEj9MPYPPVHXBWvL3Q2VeLOcGTv
         CMd++XaVrW1qbZP8AXHuZkqEsOuBTTYj8oqMpx4fYjbbaKMamn2Mror9+FTViL040f
         PTN72rr8dqZR9gs+8xjDd7bhJRT+YNoUJTBwUXFtsU/u0Ryzxp/HOSm8h4P+3dJILj
         sYdx5NVU0q6rKGeq3c21pJuFMzOZbJVsW2y5Fo+xZxJ0BruFiVLZSwraZTA1xy8nsn
         11aMZvByRtOrkMABdHzgRUlYQiVxSsq9TNyV6sJZwQDxIF1NYAkKaUEgGjONtzUv1G
         z8n8eCqfLJ0Ew==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000oh-Ca; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 08/26] serial: arc_uart: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:51 +0200
Message-Id: <20210421095509.3024-9-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 3fa1200851c7 ("tty: serial: arc: drop uart_port->lock before
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
Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/arc_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 17c3fc398fc6..1a9444b6b57e 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -236,9 +236,7 @@ static void arc_serial_rx_chars(struct uart_port *port, unsigned int status)
 		if (!(uart_handle_sysrq_char(port, ch)))
 			uart_insert_char(port, status, RXOERR, ch, flg);
 
-		spin_unlock(&port->lock);
 		tty_flip_buffer_push(&port->state->port);
-		spin_lock(&port->lock);
 	} while (!((status = UART_GET_STATUS(port)) & RXEMPTY));
 }
 
-- 
2.26.3

