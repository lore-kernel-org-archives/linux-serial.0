Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA8AC4320A
	for <linux-serial@archiver.kernel.org>; Sun, 22 Aug 2021 03:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AC761350
	for <linux-serial@archiver.kernel.org>; Sun, 22 Aug 2021 03:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhHVD2m (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Aug 2021 23:28:42 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7990 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhHVD2l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Aug 2021 23:28:41 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56121c432c31-f265f; Sun, 22 Aug 2021 11:27:47 +0800 (CST)
X-RM-TRANSID: 2ee56121c432c31-f265f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.250.151])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36121c429ec8-6521d;
        Sun, 22 Aug 2021 11:27:46 +0800 (CST)
X-RM-TRANSID: 2ee36121c429ec8-6521d
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, paul@crapouillou.net,
        jirislaby@kernel.org, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux@prisktech.co.nz
Cc:     linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH 2/3] serial: tegra: Use of_device_get_match_data
Date:   Sun, 22 Aug 2021 11:28:05 +0800
Message-Id: <20210822032806.3256-3-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20210822032806.3256-1-tangbin@cmss.chinamobile.com>
References: <20210822032806.3256-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Retrieve OF match data, it's better and cleaner to use
'of_device_get_match_data' over 'of_match_device'.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/tty/serial/serial-tegra.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index eba5b9ecb..45e2e4109 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1568,14 +1568,12 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	struct resource *resource;
 	int ret;
 	const struct tegra_uart_chip_data *cdata;
-	const struct of_device_id *match;
 
-	match = of_match_device(tegra_uart_of_match, &pdev->dev);
-	if (!match) {
+	cdata = of_device_get_match_data(&pdev->dev);
+	if (!cdata) {
 		dev_err(&pdev->dev, "Error: No device match found\n");
 		return -ENODEV;
 	}
-	cdata = match->data;
 
 	tup = devm_kzalloc(&pdev->dev, sizeof(*tup), GFP_KERNEL);
 	if (!tup) {
-- 
2.20.1.windows.1



