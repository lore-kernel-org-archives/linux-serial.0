Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8157C07E95
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jul 2021 09:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D61F613DA
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jul 2021 09:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhGJJDx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Jul 2021 05:03:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38178 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230083AbhGJJDx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Jul 2021 05:03:53 -0400
X-UUID: 63f9c0c360884c218d9327f087a74969-20210710
X-UUID: 63f9c0c360884c218d9327f087a74969-20210710
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1717240993; Sat, 10 Jul 2021 17:01:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Jul 2021 17:01:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Jul 2021 17:01:04 +0800
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
Subject: [PATCH 0/1] Mediatek uart patch 
Date:   Sat, 10 Jul 2021 17:01:02 +0800
Message-ID: <20210710090103.2643-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series includes 1 patches:
1.fix uart access memory corruption issue

Zhiyong Tao (1):
  uart: mediatek: fix memory corruption issue

 drivers/tty/serial/8250/8250_mtk.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--
2.18.0


