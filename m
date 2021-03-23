Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D246CC433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11F26146D
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCWJaK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:30:10 -0400
Received: from m12-15.163.com ([220.181.12.15]:60754 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhCWJaH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 05:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bipQG
        YVg/aKbJfujEx4JlQC2HuVAoinKOBHzXNgUhQU=; b=Y2Stt8aDoK3pbbJDUJ0ck
        qYfE/+hDen9WV6ndxdUak0h+RuEZapgOx7DRLeYxtZrTqBSfnqFyLYr6ZCkvB0pD
        QRMRTJ4j5qMndtuT4geI0A4ZY9Raned6sor6mDrI+M5PubzTVUIULeQId7hHlhbH
        GPYD/6j+bI5LEaX7c3ZNZU=
Received: from caizhichao.ccdomain.com (unknown [218.94.48.178])
        by smtp11 (Coremail) with SMTP id D8CowAAnp_zDtFlgrhxcGA--.56S2;
        Tue, 23 Mar 2021 17:29:04 +0800 (CST)
From:   caizhichao <tomstomsczc@163.com>
To:     gregkh@linuxfoundation.org, matthias.bgg@gmail.com
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        caizhichao <caizhichao@yulong.com>
Subject: [PATCH] tty:serial: fix spelling typo of values
Date:   Tue, 23 Mar 2021 17:28:46 +0800
Message-Id: <20210323092846.819-1-tomstomsczc@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAnp_zDtFlgrhxcGA--.56S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1DZw4fCF13tw45ArWrKrg_yoWfWFcE9r
        WkXwsxZ3sYyF4vkw15Arn8urWSka1UuFn7Aa40qr9rA398Zw4kAFy0vrZ8tw1vqFs3Zr9r
        Ar1UKr1xKw1UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnjZX7UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pwrp23prpvu6rf6rljoofrz/xtbBdQBeilaD+k53QQAAs2
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: caizhichao <caizhichao@yulong.com>

vaules -> values

Signed-off-by: caizhichao <caizhichao@yulong.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index f7d3023..c6633dc 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -325,7 +325,7 @@ static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
 	 * Mediatek UARTs use an extra highspeed register (MTK_UART_HIGHS)
 	 *
 	 * We need to recalcualte the quot register, as the claculation depends
-	 * on the vaule in the highspeed register.
+	 * on the value in the highspeed register.
 	 *
 	 * Some baudrates are not supported by the chip, so we use the next
 	 * lower rate supported and update termios c_flag.
-- 
1.9.1


