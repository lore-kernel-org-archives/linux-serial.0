Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38B2C433F5
	for <linux-serial@archiver.kernel.org>; Thu,  7 Apr 2022 08:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbiDGIdi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Apr 2022 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243091AbiDGIdh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Apr 2022 04:33:37 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E9C1B6959;
        Thu,  7 Apr 2022 01:31:34 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Thu, 7 Apr 2022
 16:15:28 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH 3/3] tty: serial: meson: Added S4 SOC compatibility
Date:   Thu, 7 Apr 2022 16:13:55 +0800
Message-ID: <20220407081355.13602-4-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220407081355.13602-1-yu.tu@amlogic.com>
References: <20220407081355.13602-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Make UART driver compatible with S4 SOC UART. Meanwhile, the S4 SOC
UART uses 12MHz as the clock source for baud rate calculations.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 7e77693a1318..03c9a305d805 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -803,6 +803,10 @@ static const struct of_device_id meson_uart_dt_match[] = {
 	{ .compatible = "amlogic,meson8-uart" },
 	{ .compatible = "amlogic,meson8b-uart" },
 	{ .compatible = "amlogic,meson-gx-uart" },
+	{
+		.compatible = "amlogic,meson-s4-uart",
+		.data = (void *)true,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
-- 
2.33.1

