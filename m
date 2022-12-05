Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EBDC4321E
	for <linux-serial@archiver.kernel.org>; Mon,  5 Dec 2022 09:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLEJ0P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Dec 2022 04:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiLEJ0K (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Dec 2022 04:26:10 -0500
X-Greylist: delayed 1819 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 01:26:08 PST
Received: from m126.mail.126.com (m126.mail.126.com [123.126.96.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22FA3BC23
        for <linux-serial@vger.kernel.org>; Mon,  5 Dec 2022 01:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VVr6c
        z/DsVQPKxpTQOoEtqMxD6WoHYVqghaTl7GghVk=; b=RGWo3LCt+ofwdQMw/3+Vm
        kCrSEjjLpanb2MP65Ca46ujFMebZSffnL9LuiyxAnpyen/u+i32Fx8XLtUOw1N2f
        bknlQRt5JIFLS480YWJplfyRi+F0NQmuyJSF5PAXWXyfDtFebzKA0BaxiH+8wGCa
        ufY5UfdKUjAbxbMXyQ8rmQ=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp14 (Coremail) with SMTP id fuRpCgDn7vrOsY1jITp0AQ--.16962S2;
        Mon, 05 Dec 2022 16:54:40 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     timur@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] serial: ucc_uart: Add of_node_put() in ucc_uart_remove()
Date:   Mon,  5 Dec 2022 16:54:37 +0800
Message-Id: <20221205085437.1163682-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: fuRpCgDn7vrOsY1jITp0AQ--.16962S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF43Kw1kAFWUCFy8Cr1UGFg_yoWxtFc_C3
        s7Ww1xAr18CF4jgFsrJr43CrWYy3ykZF4rZ3W0qr95Wryjvr4xAFyqgr9FqrnF9rWjvFW7
        Gr4Du34jkF4UZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM8n57UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BDOF1pEEqo8DAAAsD
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In ucc_uart_probe(), we have added proper of_node_put() in the failure
paths. However, we miss it before we free *qe_port* in the remove() function.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/tty/serial/ucc_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 82cf14dd3d43..461d54de6351 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1469,6 +1469,8 @@ static int ucc_uart_remove(struct platform_device *ofdev)
 
 	uart_remove_one_port(&ucc_uart_driver, &qe_port->port);
 
+	of_node_put(qe_port->np);
+
 	kfree(qe_port);
 
 	return 0;
-- 
2.25.1

