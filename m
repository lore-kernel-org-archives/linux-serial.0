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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C43FC433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 11:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5D36191F
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 11:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCWLze (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:55:34 -0400
Received: from m12-17.163.com ([220.181.12.17]:40284 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhCWLzT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 07:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yld4K
        a6D/wNwWDvksBvh6iy6WYppMiQm7zrvFrJHt3s=; b=dW1Sny9s5Ae6DtuW+PeGB
        7ASNO/xvjQSC91dY8DM6YSVAflJQZk+32eQtPnOzNgYi97YEa+/8d4FupeT09nsG
        CQA4txSQWGKEm+dGduNrsZlpQVAoGlx7K2MX7bZ14WjnSTqXv9hGCuNfGP+FJi0V
        7SDne3DzAROU4I3GOeJFew=
Received: from caizhichao.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowAA3P5f01llgllIkrg--.21875S2;
        Tue, 23 Mar 2021 19:54:37 +0800 (CST)
From:   caizhichao <tomstomsczc@163.com>
To:     gregkh@linuxfoundation.org, matthias.bgg@gmail.com
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        caizhichao <caizhichao@yulong.com>
Subject: [PATCH v3] tty:serial: fix spelling typo of values
Date:   Tue, 23 Mar 2021 19:53:27 +0800
Message-Id: <20210323115327.1199-1-tomstomsczc@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAA3P5f01llgllIkrg--.21875S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1DJF1fXF4DAw48Gw4fAFb_yoWfuFcE9r
        1kXwsxZwnYyFnYkw15Arn8urWIka1UWF1xA3W8X3srA398Za1kAFy0vrZ8tr1vqFn3Ary7
        Ar1DKr1xtw1DujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnjL9UUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pwrp23prpvu6rf6rljoofrz/1tbiXx5eil1502GPfQAAsx
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: caizhichao <caizhichao@yulong.com>

vaules -> values

Signed-off-by: Zhichao Cai <caizhichao@yulong.com>
---
v3: use full name and capitalize personal name.
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


