Return-Path: <SRS0=PQGG=7S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC0EC433E0
	for <linux-serial@archiver.kernel.org>; Fri,  5 Jun 2020 15:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEB9206A2
	for <linux-serial@archiver.kernel.org>; Fri,  5 Jun 2020 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gaireg.de header.i=@gaireg.de header.b="yyocm+GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgFEPHl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgFEPHk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Jun 2020 11:07:40 -0400
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Jun 2020 08:07:40 PDT
Received: from gaireg.de (gaireg.de [IPv6:2a03:4000:9:30::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06DAC08C5C2;
        Fri,  5 Jun 2020 08:07:40 -0700 (PDT)
Received: from tyr.bvd.indurad.x (unknown [194.8.217.178])
        by gaireg.de (Postfix) with ESMTPSA id D235C6A774E5;
        Fri,  5 Jun 2020 16:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gaireg.de; s=mail;
        t=1591369083; bh=at3sSlZvH4UsehI1oWFk8XESC8Y4Pf9dlbAMy8oNaps=;
        h=From:To:Cc:Subject:Date;
        b=yyocm+GDlU5JjRzWJcdgxzWKJWFpjfoEvorCdUe+Widox+nBvCMavW0ZGllRYpgCY
         pw2cbQ/TIuRO7O3iYcHAcBXH/tvDhP0Hsg8ChrCPj/sNF890aHp9OjD7fGW8ZrXm5i
         MN1BDdPyzagdhcL2ZqmyddAZUB6HC8aJ3lUs+ySc=
From:   =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>
To:     Laxman Dewangan <ldewangan@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>
Subject: [PATCH] serial: serial-tegra: reduce irq-latency after rx errors
Date:   Fri,  5 Jun 2020 16:57:14 +0200
Message-Id: <20200605145714.9964-1-gaireg@gaireg.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since dev_err() calls can lead to synchronous writes to another serial
console these calls can provide significant latency during irq-handling
in tegra_uart_isr(). With this latency another interrupt is likely to
apper during handling of the first interrupt, which might lock up the
kernel completely.

These errors are reported to the error counters so converting the
dev_err() to dev_dbg() is appropriate.

Signed-off-by: Randolph Maaßen <gaireg@gaireg.de>
---
 drivers/tty/serial/serial-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 8de8bac9c6c7..d3fef5ab289a 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -439,16 +439,16 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
 			/* Overrrun error */
 			flag = TTY_OVERRUN;
 			tup->uport.icount.overrun++;
-			dev_err(tup->uport.dev, "Got overrun errors\n");
+			dev_dbg(tup->uport.dev, "Got overrun errors\n");
 		} else if (lsr & UART_LSR_PE) {
 			/* Parity error */
 			flag = TTY_PARITY;
 			tup->uport.icount.parity++;
-			dev_err(tup->uport.dev, "Got Parity errors\n");
+			dev_dbg(tup->uport.dev, "Got Parity errors\n");
 		} else if (lsr & UART_LSR_FE) {
 			flag = TTY_FRAME;
 			tup->uport.icount.frame++;
-			dev_err(tup->uport.dev, "Got frame errors\n");
+			dev_dbg(tup->uport.dev, "Got frame errors\n");
 		} else if (lsr & UART_LSR_BI) {
 			/*
 			 * Break error
-- 
2.11.0

