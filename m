Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB3DC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 13:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53746135B
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 13:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhDZNTe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 09:19:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17402 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZNTd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 09:19:33 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FTQQp4St6zkjvF;
        Mon, 26 Apr 2021 21:16:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 26 Apr 2021 21:18:42 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <krzysztof.kozlowski@canonical.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v2] tty: serial: samsung_tty: remove set but not used variables
Date:   Mon, 26 Apr 2021 21:18:55 +0800
Message-ID: <1619443135-21399-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The value of 'ret' is not used which reported by svace, so jutst return
instead of break.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
v2: s3c24xx_serial_probe function exit than convert ret to some default
value when the attribute "reg-io-width" is not 1 or 4.
---
 drivers/tty/serial/samsung_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d9e4b67..9fbc611 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2220,8 +2220,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 			default:
 				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
 						prop);
-				ret = -EINVAL;
-				break;
+				return -EINVAL;
 			}
 		}
 	}
-- 
2.7.4

