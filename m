Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0761CC433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 10:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C161861249
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 10:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhDZKLy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 06:11:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44777 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhDZKLv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 06:11:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1layCo-0003XV-9l; Mon, 26 Apr 2021 10:11:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: meson: remove redundant initialization of variable id
Date:   Mon, 26 Apr 2021 11:11:06 +0100
Message-Id: <20210426101106.9122-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable id being initialized with a value that is never read
and it is being updated later with a new value. The initialization is
redundant and can be removed. Since id is just being used in a for-loop
inside a local scope, move the declaration of id to that scope.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/meson_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 529cd0289056..d7f55031b2cf 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -716,12 +716,13 @@ static int meson_uart_probe(struct platform_device *pdev)
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
 	int ret = 0;
-	int id = -1;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
 
 	if (pdev->id < 0) {
+		int id;
+
 		for (id = AML_UART_PORT_OFFSET; id < AML_UART_PORT_NUM; id++) {
 			if (!meson_ports[id]) {
 				pdev->id = id;
-- 
2.30.2

