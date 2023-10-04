Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27A5E8FDDD
	for <linux-serial@archiver.kernel.org>; Wed,  4 Oct 2023 08:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjJDIzj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Oct 2023 04:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJDIzi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Oct 2023 04:55:38 -0400
Received: from muru.com (unknown [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90EF3A6;
        Wed,  4 Oct 2023 01:55:32 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7C273810D;
        Wed,  4 Oct 2023 08:55:15 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: Check for valid console index
Date:   Wed,  4 Oct 2023 11:55:10 +0300
Message-ID: <20231004085511.42645-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Let's not allow negative numbers for console index.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -611,7 +611,7 @@ static int univ8250_console_setup(struct console *co, char *options)
 	 * if so, search for the first available port that does have
 	 * console support.
 	 */
-	if (co->index >= UART_NR)
+	if (co->index < 0 || co->index >= UART_NR)
 		co->index = 0;
 
 	/*
-- 
2.42.0
