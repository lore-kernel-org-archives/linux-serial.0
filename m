Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B7C43618
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730AF6008E
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhDUJ4P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238604AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6752561469;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=M3Pf9wAJy/8y/JxadSNZvlF/wHl5gLPyQbG2/y5Chec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olJS+bQfx2QIzM5dhDM39QJZztvW69JcgeMS5+Cx19JjvKZ8/vqJxjQGNt5AZxPkY
         EMIRfpnRkKBYPwnn3lv4aqQSveQ3pym8K0+TgrVC5byJXTS1MyPOMA5/I26iT8qiZ4
         VQO9eBJdYLcV1pMgZFgSBWSTtuNSW4xrgaWLi35JHEFQRlHWt3Nh9cojg6g/lWxTnT
         Au3gBm0et0ZTEz1wousLmibJ8AmP75le25aMwuDkkfptkWKPB8QSj1wM5huAR7SGRl
         nTfQL3rmqeOSH91UjEWQMez6hnMAir4+HDTuE6XqGI9yRFYdWjV6A0cpAwiLSfTOit
         +/tZc8gkAdtIA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000or-KZ; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 11/26] serial: icom: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:54 +0200
Message-Id: <20210421095509.3024-12-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 5faf75d7fed2 ("tty: serial: icom: drop uart_port->lock before
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
 drivers/tty/serial/icom.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 94af7a5ea497..9e9abfc4824a 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -829,9 +829,7 @@ static void recv_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 	}
 	icom_port->next_rcv = rcv_buff;
 
-	spin_unlock(&icom_port->uart_port.lock);
 	tty_flip_buffer_push(port);
-	spin_lock(&icom_port->uart_port.lock);
 }
 
 static void process_interrupt(u16 port_int_reg,
-- 
2.26.3

