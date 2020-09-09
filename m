Return-Path: <SRS0=MLOr=CS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458CEC433E2
	for <linux-serial@archiver.kernel.org>; Wed,  9 Sep 2020 15:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1821A206D4
	for <linux-serial@archiver.kernel.org>; Wed,  9 Sep 2020 15:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgIIPyW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:54:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730581AbgIIPyK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Sep 2020 11:54:10 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 31D906DFC959D022662F;
        Wed,  9 Sep 2020 21:51:15 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:51:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <u74147@gmail.com>, <je.yen.tam@ni.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] serial: 8250_pci: Remove unused function get_pci_irq()
Date:   Wed, 9 Sep 2020 21:51:03 +0800
Message-ID: <20200909135103.17768-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is not used since commit 8428413b1d14 ("serial: 8250_pci: Implement MSI(-X) support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/8250/8250_pci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 85810b8b9d20..824c44ec25a8 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2795,15 +2795,6 @@ static struct pci_serial_quirk *find_quirk(struct pci_dev *dev)
 	return quirk;
 }
 
-static inline int get_pci_irq(struct pci_dev *dev,
-				const struct pciserial_board *board)
-{
-	if (board->flags & FL_NOIRQ)
-		return 0;
-	else
-		return dev->irq;
-}
-
 /*
  * This is the configuration table for all of the PCI serial boards
  * which we support.  It is directly indexed by the pci_board_num_t enum
-- 
2.17.1


