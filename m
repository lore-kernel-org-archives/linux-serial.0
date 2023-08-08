Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28039C001B0
	for <linux-serial@archiver.kernel.org>; Tue,  8 Aug 2023 18:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjHHSvW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHHSvF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Aug 2023 14:51:05 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE7146543
        for <linux-serial@vger.kernel.org>; Tue,  8 Aug 2023 10:02:10 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.spreadtrum.com with ESMTP id 3783WK2B073154
        for <linux-serial@vger.kernel.org>; Tue, 8 Aug 2023 11:32:20 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3783VlqW071806;
        Tue, 8 Aug 2023 11:31:47 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RKdwd3hcwz2NsJlw;
        Tue,  8 Aug 2023 11:29:53 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 8 Aug 2023
 11:31:46 +0800
From:   Wenhua Lin <Wenhua.Lin@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH 3/3] gpio: sprd: Add clear interrupt
Date:   Tue, 8 Aug 2023 11:31:44 +0800
Message-ID: <20230808033144.2276-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3783VlqW071806
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Clear interrupt after set the interrupt type.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index c506cfd6df8e..31125f53bc97 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -374,29 +374,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_FALLING:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		default:
@@ -409,29 +414,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_FALLING:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		default:
-- 
2.17.1

