Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BCCEB64DD
	for <linux-serial@archiver.kernel.org>; Mon, 24 Jul 2023 03:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjGXDrl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 23 Jul 2023 23:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGXDrj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 Jul 2023 23:47:39 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319CFD7
        for <linux-serial@vger.kernel.org>; Sun, 23 Jul 2023 20:47:38 -0700 (PDT)
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [114.249.186.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 729D53F2F7;
        Mon, 24 Jul 2023 03:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690170454;
        bh=bS94gwxJCTkxEUiXXMT2jlT0I8BOfRaTP+3ZVtBhd2o=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=BXQlhlpY1z3ejlVxaNfNzw97MOs/jZ7gNl0zm3umaJoY+Ae+wI5ylBLjalsMgMKFU
         R6fll6oYTl7iTPBBt6uIlqq6wAW/urPj+HlZB/5UfMULzlSYTeccgQyZGHgvqDkaxR
         /jtRqR5EwMDM5glRmbrYQLNTmAbJqIovKqGQtCRUcjQ+JGaS2qcz+qfy1KWO+zokLF
         1PNbm8M1D45qLouTAaXzCXj9ZL+elW+2vE6bRdAuRgy/q9TYPrEPsqDM1gqH79itRE
         NBp3E6p9fM749S1y4ml71Fq+OimR9skh37pDVkbB4mVQNTC+NAOoCXL015FKh+x00+
         ETmPCKvlSLwBw==
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     jringle@gridpoint.com, u.kleine-koenig@pengutronix.de,
        hui.wang@canonical.com
Subject: [PATCH] serial: sc16is7xx: Put IOControl register into regmap_volatile
Date:   Mon, 24 Jul 2023 11:47:27 +0800
Message-Id: <20230724034727.17335-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

According to the IOControl register bits description in the page 31 of
the product datasheet, we know the bit 3 of IOControl register is
softreset, this bit will self-clearing once the reset finish.

In the probe, the softreset bit is set, and when we read this register
from debugfs/regmap interface, we found the softreset bit is still
setting, this confused us for a while. Finally we found this register
is cached, to read the real value from register, we could put it
into the regmap_volatile().

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 2e7e7c409cf2..bc2b204d63af 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -488,6 +488,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
 	case SC16IS7XX_IOSTATE_REG:
+	case SC16IS7XX_IOCONTROL_REG:
 		return true;
 	default:
 		break;
-- 
2.34.1

