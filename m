Return-Path: <SRS0=Jo6V=EG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF1C00A89
	for <linux-serial@archiver.kernel.org>; Sat, 31 Oct 2020 03:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A3522249
	for <linux-serial@archiver.kernel.org>; Sat, 31 Oct 2020 03:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgJaDF7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Oct 2020 23:05:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7119 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaDF6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Oct 2020 23:05:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNPFZ54NGzLqyG;
        Sat, 31 Oct 2020 11:05:54 +0800 (CST)
Received: from localhost (10.174.176.180) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 11:05:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: mctrl_gpio: Fix passing zero to 'ERR_PTR' warning
Date:   Sat, 31 Oct 2020 11:05:30 +0800
Message-ID: <20201031030530.1304-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

drivers/tty/serial/serial_mctrl_gpio.c:214
 mctrl_gpio_init() warn: passing zero to 'ERR_PTR'

gpiod_to_irq() never return 0, so remove the useless test
and make code more clear.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index fb4781292d40..c41d8911ce95 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -207,7 +207,7 @@ struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx)
 			continue;
 
 		ret = gpiod_to_irq(gpios->gpio[i]);
-		if (ret <= 0) {
+		if (ret < 0) {
 			dev_err(port->dev,
 				"failed to find corresponding irq for %s (idx=%d, err=%d)\n",
 				mctrl_gpios_desc[i].name, idx, ret);
-- 
2.17.1

