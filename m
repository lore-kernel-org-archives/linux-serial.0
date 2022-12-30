Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520BEC3DA7D
	for <linux-serial@archiver.kernel.org>; Fri, 30 Dec 2022 17:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiL3RAD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Dec 2022 12:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiL3RAC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Dec 2022 12:00:02 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423DE19039
        for <linux-serial@vger.kernel.org>; Fri, 30 Dec 2022 09:00:01 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BIjepxxYHqMfRBIjepeWsm; Fri, 30 Dec 2022 17:59:59 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Dec 2022 17:59:59 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: sccnxp: Use devm_clk_get_enabled() helper
Date:   Fri, 30 Dec 2022 17:59:56 +0100
Message-Id: <735a807c2df835aa436dcbc76b374f983f89a9af.1672419577.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code.
This also avoids some other warnings/issues. (see [1])

[1]: https://lore.kernel.org/all/20221118233101.never.215-kees@kernel.org/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/sccnxp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 7df687822634..4f2fc5f7bb19 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -913,23 +913,13 @@ static int sccnxp_probe(struct platform_device *pdev)
 	} else if (PTR_ERR(s->regulator) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		if (ret == -EPROBE_DEFER)
 			goto err_out;
 		uartclk = 0;
 	} else {
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			goto err_out;
-
-		ret = devm_add_action_or_reset(&pdev->dev,
-				(void(*)(void *))clk_disable_unprepare,
-				clk);
-		if (ret)
-			goto err_out;
-
 		uartclk = clk_get_rate(clk);
 	}
 
-- 
2.34.1

