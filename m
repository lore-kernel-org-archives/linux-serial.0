Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7532C43618
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1CE56143D
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbhDUJ4W (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238675AbhDUJ4K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8930E61462;
        Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998937;
        bh=JTOTZI6bMv68wR3qvzPPxYqwOcSxCiswzBee2Px7PgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DReJHcPysNeVifagY895TiF+h/2Zp6ioz4yTvg9tBr83wvF8cSx6hd4+zhbIQeaAb
         gWcaooTTNPRx1clPm1BZpluTZvUJtkNmhzzHm/6fXdMydcb2VRq3O9sMMtLBhKJhGU
         Mkb7myXJ/k7xuIksaV0msXrI9yrUyUJVxvdkUZJltZi7kNLuedrTIM0DfD44nvNtS6
         oQJ02b4Cpc9BOqQ7vjdONUwS0Y5697+gM9TpJawkiz6inH4pH+v6b1/dsEMDLGntDU
         BnzlZgtPc4GJmDUX6+Gr+a3OKighfOCkXkphNu8z6OBauc2RK590cO8guaTukzM29D
         xpheRL5qWFzMw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000ph-Pe; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH 25/26] serial: vt8500: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:55:08 +0200
Message-Id: <20210421095509.3024-26-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit de49df58366f ("tty: serial: vt8500: drop uart_port->lock before
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
Cc: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/vt8500_serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 764e992438b2..c5edd56ff830 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -184,9 +184,7 @@ static void handle_rx(struct uart_port *port)
 			tty_insert_flip_char(tport, c, flag);
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 }
 
 static void handle_tx(struct uart_port *port)
-- 
2.26.3

