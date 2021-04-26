Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBE5C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 10:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE84460FE9
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 10:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhDZK4A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 06:56:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45932 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhDZKz7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 06:55:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1laytW-0000MK-G0; Mon, 26 Apr 2021 10:55:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: tegra: Fix a mask operation that is always true
Date:   Mon, 26 Apr 2021 11:55:14 +0100
Message-Id: <20210426105514.23268-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the expression lsr | UART_LSR_TEMT is always true and
this seems suspect. I believe the intent was to mask lsr with UART_LSR_TEMT
to check that bit, so the expression should be using the & operator
instead. Fix this.

Fixes: b9c2470fb150 ("serial: tegra: flush the RX fifo on frame error")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/serial-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index bbae072a125d..222032792d6c 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -338,7 +338,7 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 
 	do {
 		lsr = tegra_uart_read(tup, UART_LSR);
-		if ((lsr | UART_LSR_TEMT) && !(lsr & UART_LSR_DR))
+		if ((lsr & UART_LSR_TEMT) && !(lsr & UART_LSR_DR))
 			break;
 		udelay(1);
 	} while (--tmout);
-- 
2.30.2

