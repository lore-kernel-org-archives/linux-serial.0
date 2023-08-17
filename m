Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399BEEB64DD
	for <linux-serial@archiver.kernel.org>; Thu, 17 Aug 2023 10:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350033AbjHQKzD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Aug 2023 06:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350030AbjHQKye (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Aug 2023 06:54:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870342D4A;
        Thu, 17 Aug 2023 03:54:33 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRMK30g7wzVjyN;
        Thu, 17 Aug 2023 18:52:23 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 18:54:29 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <ldewangan@nvidia.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <alan@linux.intel.com>, <swarren@nvidia.com>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH] serial: tegra: handle clk prepare error in tegra_uart_hw_init()
Date:   Thu, 17 Aug 2023 18:54:06 +0800
Message-ID: <20230817105406.228674-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In tegra_uart_hw_init(), the return value of clk_prepare_enable() should
be checked since it might fail.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/tty/serial/serial-tegra.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 0b597b282fce..d4ec943cb8e9 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -996,7 +996,11 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	tup->ier_shadow = 0;
 	tup->current_baud = 0;
 
-	clk_prepare_enable(tup->uart_clk);
+	ret = clk_prepare_enable(tup->uart_clk);
+	if (ret) {
+		dev_err(tup->uport.dev, "could not enable clk\n");
+		return ret;
+	}
 
 	/* Reset the UART controller to clear all previous status.*/
 	reset_control_assert(tup->rst);
-- 
2.17.1

