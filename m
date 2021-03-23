Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9128EC433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 10:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC3760C3E
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 10:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCWK2P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 06:28:15 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:42558 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCWK2H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 06:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RLWNH
        ajd1b2fJSyFb8LrjbhrhT37rB1kIa2xEUTgpi4=; b=CSsQk81JLH3EOcB61+jIF
        AyfzwqX92XqymDFdgQFsAAfbD4gFXUeFNHd5hf8OJ8ppRigXDFAYDDIC5/+jfMUn
        O+30TSF2R5ypu6Ldiyk33VFBOra4J6EteekYzMVEZT1S6IuRQfvi/xXabDJOEncl
        Xcl+m5/EQ2ukqV1w1yQFqc=
Received: from caizhichao.ccdomain.com (unknown [218.94.48.178])
        by smtp2 (Coremail) with SMTP id GtxpCgBn+818wllgnz25BA--.15583S2;
        Tue, 23 Mar 2021 18:27:27 +0800 (CST)
From:   caizhichao <tomstomsczc@163.com>
To:     gregkh@linuxfoundation.org, matthias.bgg@gmail.com
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        zhichao Cai <caizhichao@yulong.com>
Subject: [PATCH resend]  tty:serial: fix spelling typo of values
Date:   Tue, 23 Mar 2021 18:25:56 +0800
Message-Id: <20210323102556.1136-1-tomstomsczc@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgBn+818wllgnz25BA--.15583S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7KFW5Cr1rAF13Zr45Awb_yoWfWFcE9w
        1kXwsxZ3sYyFs0kw1rArs8urWIka1UuFn7Aa40qr97A398Za1kAFy0vrZxtr1vgFn3Ar9r
        Ar1UKr1xKw1UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0i0ePUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pwrp23prpvu6rf6rljoofrz/1tbisg9eilUMRkyQ7gAAsE
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: zhichao Cai <caizhichao@yulong.com>

vaules -> values

Signed-off-by: zhichao Cai <caizhichao@yulong.com>
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

