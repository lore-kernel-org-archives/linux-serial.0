Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D8C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 17 May 2022 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbiEQIQt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 May 2022 04:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbiEQIQi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 May 2022 04:16:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B44B1E7;
        Tue, 17 May 2022 01:14:11 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2TPs0qvTzbbxd;
        Tue, 17 May 2022 16:12:49 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 16:14:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <geert@linux-m68k.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] serial: cpm_uart: Fix build error without CONFIG_SERIAL_CPM_CONSOLE
Date:   Tue, 17 May 2022 16:13:55 +0800
Message-ID: <20220517081355.35456-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

drivers/tty/serial/cpm_uart/cpm_uart_core.c: In function ‘cpm_uart_init_port’:
drivers/tty/serial/cpm_uart/cpm_uart_core.c:1251:7: error: ‘udbg_port’ undeclared (first use in this function); did you mean ‘uart_port’?
  if (!udbg_port)
       ^~~~~~~~~
       uart_port

commit d142585bceb3 leave this corner, wrap it with #ifdef block

Fixes: d142585bceb3 ("serial: cpm_uart: Protect udbg definitions by CONFIG_SERIAL_CPM_CONSOLE")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index d6d3db9c3b1f..ec3a8f768555 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1248,7 +1248,9 @@ static int cpm_uart_init_port(struct device_node *np,
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
 #ifdef CONFIG_CONSOLE_POLL
+#ifdef CONFIG_SERIAL_CPM_CONSOLE
 	if (!udbg_port)
+#endif
 #endif
 		udbg_putc = NULL;
 #endif
-- 
2.17.1

