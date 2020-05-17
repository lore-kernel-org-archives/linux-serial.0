Return-Path: <SRS0=Hdmd=67=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D06C433DF
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D35207D8
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgEQV4e (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 May 2020 17:56:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45118 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgEQV4e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 17:56:34 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaRGe-0002am-9B; Sun, 17 May 2020 23:56:20 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 1/5] serial: 8520_port: Fix function param documentation
Date:   Sun, 17 May 2020 23:56:06 +0200
Message-Id: <20200517215610.2131618-2-heiko@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517215610.2131618-1-heiko@sntech.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The parameter is named p while the documentation talks about up.
Fix the doc to be in line with the code.

Fixes: 058bc104f7ca ("serial: 8250: Generalize rs485 software emulation")
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 9c0457e74d21..6975bd3ecb7d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1437,7 +1437,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 
 /**
  * serial8250_em485_stop_tx() - generic ->rs485_stop_tx() callback
- * @up: uart 8250 port
+ * @p: uart 8250 port
  *
  * Generic callback usable by 8250 uart drivers to stop rs485 transmission.
  */
-- 
2.25.1

