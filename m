Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0322C433C1
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 12:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAB861994
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 12:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhCVMQ3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:16:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14424 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhCVMQN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 08:16:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F3tj73tjSzkcrG;
        Mon, 22 Mar 2021 20:14:35 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 20:16:04 +0800
From:   'w00385741 <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] serial: pch_uart: fix build error with !CONFIG_DEBUG_FS
Date:   Mon, 22 Mar 2021 12:26:01 +0000
Message-ID: <20210322122601.2980258-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix the build error with CONFIG_DEBUG_FS is not set:

drivers/tty/serial/pch_uart.c: In function 'pch_uart_init_port':
drivers/tty/serial/pch_uart.c:1815:9: error: 'port_regs_ops' undeclared (first use in this function)
 1815 |        &port_regs_ops);
      |         ^~~~~~~~~~~~~

This commit get rid of the CONFIG_PM_SLEEP ifdefery to
fix the build error.

Fixes: 1f8a51ee3242 ("tty: serial: pch_uart.c: remove debugfs dentry pointer")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/tty/serial/pch_uart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index e9e79d181f0e..f0351e6f0ef6 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -291,8 +291,6 @@ static const int trigger_level_64[4] = { 1, 16, 32, 56 };
 static const int trigger_level_16[4] = { 1, 4, 8, 14 };
 static const int trigger_level_1[4] = { 1, 1, 1, 1 };
 
-#ifdef CONFIG_DEBUG_FS
-
 #define PCH_REGS_BUFSIZE	1024
 
 
@@ -352,7 +350,6 @@ static const struct file_operations port_regs_ops = {
 	.read		= port_show_regs,
 	.llseek		= default_llseek,
 };
-#endif	/* CONFIG_DEBUG_FS */
 
 static const struct dmi_system_id pch_uart_dmi_table[] = {
 	{

