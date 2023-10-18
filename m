Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3121CDB484
	for <linux-serial@archiver.kernel.org>; Wed, 18 Oct 2023 09:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjJRJQn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Oct 2023 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjJRJQj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Oct 2023 05:16:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A0100
        for <linux-serial@vger.kernel.org>; Wed, 18 Oct 2023 02:16:37 -0700 (PDT)
Received: from kwepemm000014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S9Q9f4F0MzRt5X;
        Wed, 18 Oct 2023 17:12:54 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemm000014.china.huawei.com
 (7.193.23.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 17:16:34 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] serial: atmel: Check return value of platform_get_irq() in atmel_init_port()
Date:   Wed, 18 Oct 2023 09:15:21 +0000
Message-ID: <20231018091521.314706-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000014.china.huawei.com (7.193.23.6)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The platform_get_irq() might be failed and return a negative result, there
should be return an error code when platform_get_irq() failed.
Fix it by add check return value of platform_get_irq().

Fixes: 5bb221b0ad65 ("serial: atmel: Use platform_get_irq() to get the interrupt")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/tty/serial/atmel_serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 1946fafc3f3e..4984bec88445 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2540,13 +2540,17 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	atmel_init_property(atmel_port, pdev);
 	atmel_set_ops(port);
 
+	ret = platform_get_irq(mpdev, 0);
+	if (ret < 0)
+		return 0;
+
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
 	port->ops		= &atmel_pops;
 	port->fifosize		= 1;
 	port->dev		= &pdev->dev;
 	port->mapbase		= mpdev->resource[0].start;
-	port->irq		= platform_get_irq(mpdev, 0);
+	port->irq		= ret;
 	port->rs485_config	= atmel_config_rs485;
 	port->rs485_supported	= atmel_rs485_supported;
 	port->iso7816_config	= atmel_config_iso7816;
-- 
2.25.1

