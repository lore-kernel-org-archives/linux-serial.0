Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9712BC7EE25
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jun 2023 04:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjFIEpu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Jun 2023 00:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjFIEpt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Jun 2023 00:45:49 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5585230E8
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 21:45:45 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 7U0KqPBjCDGHG7U0Kq4YGn; Fri, 09 Jun 2023 06:45:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686285943;
        bh=UkPuf1cEggfUhF63kQO/8xolTLGbzwLNxFq6qhE7R0c=;
        h=From:To:Cc:Subject:Date;
        b=ID8zcjZT9VNLSLnTBfTRFr7XdAJhLgGQQTZmuTkb8ZRx1I4puHUr3FQjEy9dizrt1
         +7adlgaC23iIECotO7NMgpk6j7KCOEfm3jRftQprT2A53sWY5bt3RaOketL6bUfAD5
         VOxq1Q2AFB7OXRMufd0PVN3LlKc8Txd1YBW/wQFCGRaf4qVdgn5ZhNXIF/jJ+50DOs
         ghNrWe8JWisDPa66b89R+/ZFNK6uBEpAARxgn5xwkfxV0+Ap9z+ileXfnpMkWSPSOs
         x8NPJdeXGHRNnDwW6n8G+sRF44HeyZkdQwJDEnTF16cnPXLuz922jTX7m+hoJxBYOs
         Cc0p82GxdZrEQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 09 Jun 2023 06:45:43 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
Date:   Fri,  9 Jun 2023 06:45:38 +0200
Message-Id: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If clk_get_rate() fails, the clk that has just been allocated needs to be
freed.

Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/samsung_tty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 2a7520ad3abd..dd751e7010e3 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1459,8 +1459,10 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			continue;
 
 		rate = clk_get_rate(clk);
-		if (!rate)
+		if (!rate) {
+			clk_put(clk);
 			continue;
+		}
 
 		if (ourport->info->has_divslot) {
 			unsigned long div = rate / req_baud;
-- 
2.34.1

