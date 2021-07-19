Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7499AC12002
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 09:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C9861182
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 09:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhGSJPB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Jul 2021 05:15:01 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:44148
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231928AbhGSJPB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Jul 2021 05:15:01 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 913D940333;
        Mon, 19 Jul 2021 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626688533;
        bh=NeHvk9CH9MzNaHMMnngpGmg0816fMoabsjV9w7Sujo0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=L0DAiBLGaexsMDOLjcAxv5HUFc5vJ6tef9lciZSKNT2fJYWcCTsNlj2JI/ON2X+W9
         SGudH1exrM9v7V27hYzs6ORXdVaKcua97w3i/RfwHuOAGPCtDiHJ0lb8e+Dspe6WQV
         W1S/j8Ka7J8VbIVkeMcOdP3tDDd2gKjr3vyi1OgXq8S8fjWKiaXsI4uDiwBUfzWVoj
         gYFoQi8Q7BLeBxy+98reKgyOkwdasIh8ssgsL8gyiuudkjO36jvkbk+7mlPN4R1K3L
         YnNm3Fc6ZEeVJzY5zlP+TR7NvkkBfKD5ylXVo/FynF6WWPf/JLOdilJSIsPNDjAdPs
         0kZSWwCWmEn0g==
From:   Colin King <colin.king@canonical.com>
To:     Al Cooper <alcooperx@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_bcm7271: use NULL to initialized a null pointer
Date:   Mon, 19 Jul 2021 10:55:33 +0100
Message-Id: <20210719095533.14017-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer membase is currently being in initialized with zero rather
than NULL. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 725a450058f8..7f656fac503f 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -941,7 +941,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	struct clk *baud_mux_clk;
 	struct uart_8250_port up;
 	struct resource *irq;
-	void __iomem *membase = 0;
+	void __iomem *membase = NULL;
 	resource_size_t mapbase = 0;
 	u32 clk_rate = 0;
 	int ret;
-- 
2.31.1

