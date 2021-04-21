Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B69C43619
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11AC61440
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbhDUJ4P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238605AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 734816143D;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=Xai30bPlo7ZkE9R0WT11XxAtQnG6hlhEwzXdh169xmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILjwThCJse63WRaNAKPK8maYE2RXBUt7zxNsB7XX6+MuCXQos3rHyG9EyROja2VYh
         9dwWDP7v8jQLk0qcUbJTILB3oklyVh+OfUUkLHue3LWjhSdio0d9j2HACkkR4D6i2p
         6ObE9g2/Z+fRyH91xmRufDB+aHLeGCr3Pj8hbu3pdDtiYHyR2put4WuDV+ZIhaS1WV
         DOG42B8Nz0EX0ndAJn8jgBpjVsVTwpCmXHYb2ruOytEuGAwRPAB65V/Npx+WL1mfle
         36ueGzsN6i5hH7mPk8yjAGO8zhlPqVsTDV+Wj4cmSD9MNTqGoa73/m4TTTGPAyqoUy
         4Qq0HiU1scpDg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000ou-Nd; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 12/26] serial: lpc32xx_hs: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:55 +0200
Message-Id: <20210421095509.3024-13-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit ec128510905c ("tty: serial: lpc32xx_hs: drop uart_port->lock
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
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/lpc32xx_hs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 1fa098d7aec4..b199d7859961 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -273,9 +273,7 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 		tmp = readl(LPC32XX_HSUART_FIFO(port->membase));
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 }
 
 static void __serial_lpc32xx_tx(struct uart_port *port)
-- 
2.26.3

