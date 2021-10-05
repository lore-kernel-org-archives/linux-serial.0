Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763B0C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 14:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBC06113A
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 14:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhJEOQJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 10:16:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:52559 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhJEOPR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 10:15:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="206561907"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="206561907"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 06:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="439516770"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Oct 2021 06:45:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB78A291; Tue,  5 Oct 2021 16:45:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 2/2] serial: 8250_dw: Fix the trivial typo in the comment
Date:   Tue,  5 Oct 2021 16:45:29 +0300
Message-Id: <20211005134529.23256-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005134529.23256-1-andriy.shevchenko@linux.intel.com>
References: <20211005134529.23256-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix the trivial typo in the comment: Premilinary --> Preliminary.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 792389acf9f6..5a2ff843ec5d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -338,7 +338,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	rate = clk_round_rate(d->clk, newrate);
 	if (rate > 0) {
 		/*
-		 * Premilinary set the uartclk to the new clock rate so the
+		 * Preliminary set the uartclk to the new clock rate so the
 		 * clock update event handler caused by the clk_set_rate()
 		 * calling wouldn't actually update the UART divisor since
 		 * we about to do this anyway.
-- 
2.33.0

