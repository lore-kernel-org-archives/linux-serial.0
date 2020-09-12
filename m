Return-Path: <SRS0=FFO7=CV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2005C43461
	for <linux-serial@archiver.kernel.org>; Sat, 12 Sep 2020 03:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE243221EB
	for <linux-serial@archiver.kernel.org>; Sat, 12 Sep 2020 03:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgILDj1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Sep 2020 23:39:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgILDjZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Sep 2020 23:39:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 96CC92E51582B4AFDF07;
        Sat, 12 Sep 2020 11:39:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 12 Sep 2020
 11:39:14 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <timur@kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <linux@rasmusvillemoes.dk>,
        <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-serial@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] serial: ucc_uart: make qe_uart_set_mctrl() static
Date:   Sat, 12 Sep 2020 11:38:34 +0800
Message-ID: <20200912033834.143166-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This eliminates the following sparse warning:

drivers/tty/serial/ucc_uart.c:286:6: warning: symbol 'qe_uart_set_mctrl'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/tty/serial/ucc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 3c8c662c69e2..d6a8604157ab 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -283,7 +283,7 @@ static unsigned int qe_uart_tx_empty(struct uart_port *port)
  * don't need that support. This function must exist, however, otherwise
  * the kernel will panic.
  */
-void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+static void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 }
 
-- 
2.25.4

