Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B683BC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 03:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A38461396
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 03:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEMDDD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 23:03:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2657 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEMDDD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 23:03:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fgbws2lTVzmVYc;
        Thu, 13 May 2021 10:59:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 11:01:47 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>, <tangzihao1@hisilicon.com>
Subject: [PATCH 00/12] use <linux/io.h> instead of <linux/io.h>
Date:   Thu, 13 May 2021 11:01:32 +0800
Message-ID: <1620874904-39285-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Zihao Tang <tangzihao1@hisilicon.com>

<linux/io.h> is the preferred header to include instead of <asm/io.h>,
so use <linux/io.h> instead of <asm/io.h>.

Zihao Tang (12):
  tty: serial: atmel: include <linux/io.h> instead of <asm/io.h>
  tty: serial: dz: include <linux/io.h> instead of <asm/io.h>
  tty: serial: icom: include <linux/io.h> instead of <asm/io.h>
  tty: serial: ip22zilog: include <linux/io.h> instead of <asm/io.h>
  tty: serial: mux: include <linux/io.h> instead of <asm/io.h>
  tty: serial: pmac_zilog: include <linux/io.h> insteiad of <asm/io.h>
  tty: serial: txx9: include <linux/io.h> instead of <asm/io.h>
  tty: serial: sunsab: include <linux/io.h> instead of <asm/io.h>
  tty: serial: sunsu: include <linux/io.h> instead of <asm/io.h>
  tty: serial: sunzilog: include <linux/io.h> instead of <asm/io.h>
  tty: serial: vr41xx_siu: include <linux/io.h> instead of <asm/io.h>
  tty: serial: sb1250-duart: include <linux/io.h> instead of <asm/io.h>

 drivers/tty/serial/atmel_serial.c | 2 +-
 drivers/tty/serial/dz.c           | 2 +-
 drivers/tty/serial/icom.c         | 2 +-
 drivers/tty/serial/ip22zilog.c    | 2 +-
 drivers/tty/serial/mux.c          | 2 +-
 drivers/tty/serial/pmac_zilog.c   | 2 +-
 drivers/tty/serial/sb1250-duart.c | 2 +-
 drivers/tty/serial/serial_txx9.c  | 2 +-
 drivers/tty/serial/sunsab.c       | 2 +-
 drivers/tty/serial/sunsu.c        | 2 +-
 drivers/tty/serial/sunzilog.c     | 2 +-
 drivers/tty/serial/vr41xx_siu.c   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.7.4

