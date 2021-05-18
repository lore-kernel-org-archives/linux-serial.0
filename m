Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B94C43462
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBA3613BB
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbhERB6q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2957 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245537AbhERB6o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:44 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkfFW5Sc4zCtHn;
        Tue, 18 May 2021 09:54:39 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:25 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:24 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>, <tangzihao1@hisilicon.com>
Subject: [PATCH 00/11] tty: serial: Fix some coding style issues
Date:   Tue, 18 May 2021 09:57:07 +0800
Message-ID: <1621303038-12062-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Zihao Tang <tangzihao1@hisilicon.com>

This patchset fixes some coding style issues reported by checkpatch.pl.

Zihao Tang (11):
  tty: serial: 21285: Fix some coding sytle issues
  tty: serial: amba-pl010: Fix 2 coding style issues
  tty: serial: amba-pl011: Replace the unsuitable spaces with tabs
  tty: serial: amba-pl011: Remove initialization of static variable
  tty: serial: apbuart: Fix some coding sytle issues
  tty: serial: atmel: Fix some coding style issues
  tty: serial: bcm63xx_uart: Fix some coding style issues
  tty: serial: clps711x: Fix some coding style issuses
  tty: serial: digicolor: Use 'unsigned int' instead of 'unsigned'
  tty: serial: dz: Use 'unsigned int' instead of 'unsigned'
  tty: serial: earlycon-arm-semihost : Fix some coding style issuses

 drivers/tty/serial/21285.c                 |  7 +++----
 drivers/tty/serial/amba-pl010.c            |  4 ++--
 drivers/tty/serial/amba-pl011.c            | 12 ++++++------
 drivers/tty/serial/apbuart.c               |  5 ++++-
 drivers/tty/serial/atmel_serial.c          | 13 +++++++++----
 drivers/tty/serial/bcm63xx_uart.c          | 14 +++++++++-----
 drivers/tty/serial/clps711x.c              |  4 ++--
 drivers/tty/serial/digicolor-usart.c       |  2 +-
 drivers/tty/serial/dz.c                    |  4 ++--
 drivers/tty/serial/earlycon-arm-semihost.c |  3 ++-
 10 files changed, 40 insertions(+), 28 deletions(-)

-- 
2.7.4

