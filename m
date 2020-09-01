Return-Path: <SRS0=lI39=CK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBED4C433E6
	for <linux-serial@archiver.kernel.org>; Tue,  1 Sep 2020 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82B12065F
	for <linux-serial@archiver.kernel.org>; Tue,  1 Sep 2020 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978073;
	bh=DcBlB18rbAsmyBD9sb9dDR94iJ5BAmzF5Xo0e4RxksY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zd2ycYAFyVXxJ6uWOyWp+wBvsE4twnpRY4FBfJWL6204ETWDPWMZ8C0RIkaFnWHND
	 nATEzBDrA5NrCkQYfPoT2Fv76/zQYdIVKpw/ILqR4SmeIVH3tLSEvGwAlRKPAzmHO0
	 W+In1uE2eho+YWui1UDFSC8aS9OSDjEWY+aMo2MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgIAQeb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730671AbgIAPbK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Sep 2020 11:31:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B96C21527;
        Tue,  1 Sep 2020 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974269;
        bh=DcBlB18rbAsmyBD9sb9dDR94iJ5BAmzF5Xo0e4RxksY=;
        h=From:To:Cc:Subject:Date:From;
        b=sBJjxRcFa7GzT6SamUEOBeBB4W2Ofp99PojRb8SLlckVfMyokPt9uatH0MnbBHXpD
         E8Z30W3gjJKJ6u338nbOuu0x4gUCBRo2RSLnm9eEEDESkEIjVomd8K6GYBjLpdEsuM
         NxbukGKI9+I10NsKUnvx2pFV+yCHg7r7Zm3Assm8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] serial: 8250: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:30:59 +0200
Message-Id: <20200901153100.18827-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 12 +++---------
 drivers/tty/serial/8250/8250_ingenic.c    | 20 ++++++--------------
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 12d03e678295..fd95860cd661 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -110,12 +110,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 	/* get the clock - this also enables the HW */
 	data->clk = devm_clk_get(&pdev->dev, NULL);
-	ret = PTR_ERR_OR_ZERO(data->clk);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "could not get clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(data->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
 
 	/* get the interrupt */
 	ret = platform_get_irq(pdev, 0);
@@ -155,9 +151,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	/* register the port */
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"unable to register 8250 port - %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "unable to register 8250 port\n");
 		goto dis_clk;
 	}
 	data->line = ret;
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index dde766fa465f..988bf6bcce42 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -259,22 +259,14 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->clk_module = devm_clk_get(&pdev->dev, "module");
-	if (IS_ERR(data->clk_module)) {
-		err = PTR_ERR(data->clk_module);
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"unable to get module clock: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(data->clk_module))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk_module),
+				     "unable to get module clock\n");
 
 	data->clk_baud = devm_clk_get(&pdev->dev, "baud");
-	if (IS_ERR(data->clk_baud)) {
-		err = PTR_ERR(data->clk_baud);
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"unable to get baud clock: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(data->clk_baud))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk_baud),
+				     "unable to get baud clock\n");
 
 	err = clk_prepare_enable(data->clk_module);
 	if (err) {
-- 
2.17.1

