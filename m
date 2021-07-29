Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47088C432BE
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 01:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285566101C
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 01:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhG2Bs7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Jul 2021 21:48:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42308 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233205AbhG2Bs6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Jul 2021 21:48:58 -0400
X-UUID: 73cc931f060843f99ccebaa6a6b692a7-20210729
X-UUID: 73cc931f060843f99ccebaa6a6b692a7-20210729
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1007863186; Thu, 29 Jul 2021 09:48:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Jul 2021 09:48:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Jul 2021 09:48:48 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <timur@kernel.org>, <linux@armlinux.org.uk>, <alcooperx@gmail.com>,
        <tklauser@distanz.ch>, <sean.wang@kernel.org>
CC:     <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hui.liu@mediatek.com>, <yuchen.huang@mediatek.com>,
        <huihui.wang@mediatek.com>, <eddie.huang@mediatek.com>,
        <sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
Subject: [PATCH v1 0/1] Mediatek uart patch 
Date:   Thu, 29 Jul 2021 09:48:16 +0800
Message-ID: <20210729014817.11879-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series includes 1 patches:
1.fix uart corruption issue when rx power off

when uart is used as a communication port with external device(GPS).
when external device(GPS) power off, the power of rx pin is also from
1.8v to 0v. Even if there is not any data in rx. But uart rx pin can
capture the data "0".
If uart don't receive any data in specified cycle, uart will generates
BI(Break interrupt) interrupt.
If external device(GPS) power off, we found that BI interrupt appeared
continuously and very frequently.
When uart interrupt type is BI, uart IRQ handler(8250 framwork
API:serial8250_handle_irq) will push data to tty buffer.
The code path:
https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_port.c#L1917
mtk8250_dma_rx_complete is a task of mtk_uart_apdma_rx_handler.
mtk8250_dma_rx_complete priority is lower than uart irq
handler(serial8250_handle_irq).
if we are in process of mtk8250_dma_rx_complete, uart appear BI
interrupt:1)serial8250_handle_irq will priority execution.2)it may cause
write tty buffer conflict in mtk8250_dma_rx_complete.
So the spin lock protect the rx receive data process is not break.

Changes in patch v1:
1. remove processing mechanism which count value is 0.
2. change patch title and commit message.
3. explain the detailed reason for the patch in changelog.

Zhiyong Tao (1):
  serial: 8250_mtk: fix uart corruption issue when rx power off

 drivers/tty/serial/8250/8250_mtk.c | 5 +++++
 1 file changed, 5 insertions(+)

--
2.18.0


