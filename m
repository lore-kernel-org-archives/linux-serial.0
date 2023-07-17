Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731F4C0015E
	for <linux-serial@archiver.kernel.org>; Mon, 17 Jul 2023 14:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGQOsM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Jul 2023 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGQOsH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Jul 2023 10:48:07 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFCAEB2
        for <linux-serial@vger.kernel.org>; Mon, 17 Jul 2023 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=c8oC1V1juyr3GQA6Yo
        2ZJi8sFjuk33j2LQqlIl28Vwg=; b=Ac0xhUvWEjp6P00oumzyrvjo6ZFYyNy41s
        +4Pj3HojVEP3HvOojoWtIkJ14pCRV2ZFOchLLaJiJtr1CToDq8iYaa3VgUMG1ypu
        wZQ+mGUgGfFTg8I7KilWOtBDMPbovl8HIBj+NrjTSUAqH3HfOSBrI7Vzn03MFolY
        tnabNE7Kc=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wBHo5yGVLVkiyIkAg--.44640S4;
        Mon, 17 Jul 2023 22:47:39 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 1/1] drivers:tty: fix return value check in asc_init_port
Date:   Mon, 17 Jul 2023 22:47:33 +0800
Message-Id: <20230717144733.24194-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wBHo5yGVLVkiyIkAg--.44640S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1rur45XF1UGr48CFW5Awb_yoWfZwcE93
        WDWws3Zrn8ursrtw1DC3429r90kF4kZF4rW34FvFy3trW7JayfWrykZanxCws3Aw4DXr97
        KF4Uu3y7AF1q9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtqXd5UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSQ+v5VaEH4VBNAAAsx
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

in asc_init_port, clk_prepare_enable may fail, therefore, the
return value of clk_prepare_enable should be checked.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/tty/serial/st-asc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index aa471c9c24d9..1c28014aa903 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -704,7 +704,9 @@ static int asc_init_port(struct asc_port *ascport,
 	if (WARN_ON(IS_ERR(ascport->clk)))
 		return -EINVAL;
 	/* ensure that clk rate is correct by enabling the clk */
-	clk_prepare_enable(ascport->clk);
+	ret = clk_prepare_enable(ascport->clk);
+	if (ret)
+		return ret;
 	ascport->port.uartclk = clk_get_rate(ascport->clk);
 	WARN_ON(ascport->port.uartclk == 0);
 	clk_disable_unprepare(ascport->clk);
-- 
2.17.1

