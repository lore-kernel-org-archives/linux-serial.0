Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B99C43463
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 09:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A94821D42
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 09:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRJOk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Sep 2020 05:14:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgIRJOk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Sep 2020 05:14:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DCE0D757EFC0FBBD27A2;
        Fri, 18 Sep 2020 17:14:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 17:14:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next] tty: serial: imx: fix link error with CONFIG_SERIAL_CORE_CONSOLE=n
Date:   Fri, 18 Sep 2020 17:13:05 +0800
Message-ID: <20200918091305.3822598-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix the link error by selecting SERIAL_CORE_CONSOLE.

aarch64-linux-gnu-ld: drivers/tty/serial/imx_earlycon.o: in function `imx_uart_console_early_write':
imx_earlycon.c:(.text+0x84): undefined reference to `uart_console_write'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 9631ccf43378..1044fc387691 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -521,6 +521,7 @@ config SERIAL_IMX_EARLYCON
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on OF
 	select SERIAL_EARLYCON
+	select SERIAL_CORE_CONSOLE
 	help
 	  If you have enabled the earlycon on the Freescale IMX
 	  CPU you can make it the earlycon by answering Y to this option.
-- 
2.25.1

