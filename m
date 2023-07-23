Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55F9C001DE
	for <linux-serial@archiver.kernel.org>; Sun, 23 Jul 2023 04:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGWE71 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 23 Jul 2023 00:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGWE71 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 Jul 2023 00:59:27 -0400
X-Greylist: delayed 1033 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Jul 2023 21:59:25 PDT
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6E10D7
        for <linux-serial@vger.kernel.org>; Sat, 22 Jul 2023 21:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690088363;
        bh=Qd3OAKENIQCpMIhvJEwafrb3xdlGY1wPslvTONjFmls=;
        h=From:To:Cc:Subject:Date;
        b=AAcxRDKM9un9rXQpRWgAIe6SHWzfsliwrZL7lf+lN1+WenpsVYwm7w022+pj8sovh
         HyeWUEhDpLvzvsqMn0txphkpImnsJGqZx0iet+i/MQfA3K+zKaq5hllW2OmDr635Kz
         VTjeLGDsmD+bgr1nG4WQ4z1f5Yi9/DgSeiKdMbOM=
Received: from localhost.ust.hk ([175.159.123.184])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 730804DB; Sun, 23 Jul 2023 12:28:48 +0800
X-QQ-mid: xmsmtpt1690086528tfmkjhssd
Message-ID: <tencent_1FBC566A2B186CCC634D4109F54D62F2C605@qq.com>
X-QQ-XMAILINFO: MSZT09KmLkNURS+7xz5rhECr2KH1qN+Phc+3NUrsPmAGF3/6xxEh5XqOYZDOjl
         atNHPdUnfXMxyTF3hr1xdWBwEfO4exSjq30CFBH97djUy4v8KOv6yymSgn7yTr73xtvN9ktLdKRz
         quszvJ6L96kbTxKJHZ4E3XlTa1WnV5dE32inSn4YSQeoILMGsuDKDBTT5/EtmZDDJnJ6yuHxm4ul
         O2mJAXq/Fjcd+0/N+4BA4Qnmn38flOyeIC4xvJWRKhDLR8Ti6KfBAFUJOA5AgMtGEd1O624SEyYy
         lz9KjTIXwobAdl4hX3K11P0Ytc0/0vQAHsn9CDuATjMG04VvJt+QnCdlzoLgr3Ro+ljotx/kOHVk
         jvZqA3iitHXqkdrqYALs1L9yZU7n9GoPLwDZAlcqU1fpN4473Yu/hwNO/Y7+5vmAZ5Af/yN5Sek3
         sKE5qVqFHF0Pnh2QHbw4LttMDf8nY5sdrJgjC8k8WF2HiFqadTSgU+ZVPMOKJ4mnphLWPycDiaP2
         o++yBbWr8+OP39AzoOyYQ60zOu/vWfP8B6lBma0+/+sMmvmiXd4MWIQpIzDyKsXd4MYJKmSkLWJu
         SoXLXXEKsPm+sxEq1b1et8TaPZr3qK4myyzT0YlsNetarZ2Ov4vjV4+/B/1N/WujgUh9zz2ecvHn
         IR4yDUY6sQlGkMkYqYmKt082jApYGBcMMqW1Yf+0dR12VY93KrHI4HIhYZnSF9YO34mpcXsjyd/v
         g2EJhyAqaEe+E54R2rSQ+k74wvo+HqnoD7rzS84/Ph9yyBXUvwuzVQxxviyoT/MjXZ7HKCjgB4f7
         mmPQATLpQ9rHZy1iJ5SjzK3eEY8Htp49zDiKkIkbOd06Q9qR0bDxnJ/IAqvxaKWHc2hxK3FEEMex
         1etAW2UDVvNsAZRVKCKjTt0EVwtsTm91q0VUIdaYzrmUvcUvquNa3cpoRKLP+jAli9nC3DdHJSRt
         Nxas59d3bUHP0lFm6WUXIS0wdqugNC
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     patrice.chotard@foss.st.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] serial: st-asc: Fix to check return value of platform_get_irq() in asc_init_port()
Date:   Sun, 23 Jul 2023 12:28:47 +0800
X-OQ-MSGID: <20230723042847.6169-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The platform_get_irq might be failed and return a negative result. So
there should have an error handling code.

Fixed this by adding an error handling code.

Fixes: c4b058560762 ("serial:st-asc: Add ST ASC driver.")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/tty/serial/st-asc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index aa471c9c24d9..2f1807fa9bdb 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -688,9 +688,13 @@ static int asc_init_port(struct asc_port *ascport,
 	port->ops	= &asc_uart_ops;
 	port->fifosize	= ASC_FIFO_SIZE;
 	port->dev	= &pdev->dev;
-	port->irq	= platform_get_irq(pdev, 0);
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ST_ASC_CONSOLE);
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	port->irq = ret;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(port->membase))
-- 
2.41.0

