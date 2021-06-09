Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C31C48BCD
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 15:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BFE61377
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 15:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFIP7Y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbhFIP7Y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Jun 2021 11:59:24 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4766C06175F;
        Wed,  9 Jun 2021 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=28I4IuSZAYmWqn18AViUdi1wb/tIUBRiUXVfn698loo=; b=Dmr19vb7YOyqX4nkty1OBS6cgs
        hvsA5xuFLRoIcLmfseO9nSifjclaH4N8tsbBCwNiouGmi6m9SeT3rENV7ihyyjICH9o7OwUQdZD6x
        P91gSlGl8gc+3ggwiPbScl9mLhVGLWOXSPxyw6sTAKnMbT/YLVLWh42A4aVMRKRnep4NlmNzsmaaX
        tn/WXDXHCBa7Rbg0k/QBua6RWpGKUiUg4H61TkqksfJucJdIyI/M8CvJlTJemfi/LX2Gw9mx6vV8b
        zhaMNcfIpOD8c/UwfJWQGOHsDvbaq/rL0GhHvDpkOsWQKz4JQIYYkqT+yBkrrSg0CeAJsgQ2EVJ2/
        2VT2xzrQ==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mperttunen@nvidia.com>)
        id 1lr0a1-0002mP-1n; Wed, 09 Jun 2021 18:57:21 +0300
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH] serial: tegra-tcu: Reorder channel initialization
Date:   Wed,  9 Jun 2021 18:56:55 +0300
Message-Id: <20210609155655.3567545-1-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Request the RX mailbox only after initializing the UART data
structures. Otherwise it can rarely happen that the receive
callback is called before the UART is ready.

Fixes: 2d908b38d409 ("serial: Add Tegra Combined UART driver")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/tty/serial/tegra-tcu.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 52687c65ad74..4877c54c613d 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -195,13 +195,6 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	tcu->rx = mbox_request_channel_byname(&tcu->rx_client, "rx");
-	if (IS_ERR(tcu->rx)) {
-		err = PTR_ERR(tcu->rx);
-		dev_err(&pdev->dev, "failed to get rx mailbox: %d\n", err);
-		goto free_tx;
-	}
-
 #if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
 	/* setup the console */
 	strcpy(tcu->console.name, "ttyTCU");
@@ -226,7 +219,7 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev, "failed to register UART driver: %d\n",
 			err);
-		goto free_rx;
+		goto free_tx;
 	}
 
 	/* setup the port */
@@ -246,6 +239,17 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 		goto unregister_uart;
 	}
 
+	/*
+	 * Request RX channel after creating port to ensure tcu->port
+	 * is ready for any immediate incoming bytes.
+	 */
+	tcu->rx = mbox_request_channel_byname(&tcu->rx_client, "rx");
+	if (IS_ERR(tcu->rx)) {
+		err = PTR_ERR(tcu->rx);
+		dev_err(&pdev->dev, "failed to get rx mailbox: %d\n", err);
+		goto remove_uart_port;
+	}
+
 	platform_set_drvdata(pdev, tcu);
 #if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
 	register_console(&tcu->console);
@@ -253,10 +257,10 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 
 	return 0;
 
+remove_uart_port:
+	uart_remove_one_port(&tcu->driver, &tcu->port);
 unregister_uart:
 	uart_unregister_driver(&tcu->driver);
-free_rx:
-	mbox_free_channel(tcu->rx);
 free_tx:
 	mbox_free_channel(tcu->tx);
 
@@ -270,9 +274,9 @@ static int tegra_tcu_remove(struct platform_device *pdev)
 #if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
 	unregister_console(&tcu->console);
 #endif
+	mbox_free_channel(tcu->rx);
 	uart_remove_one_port(&tcu->driver, &tcu->port);
 	uart_unregister_driver(&tcu->driver);
-	mbox_free_channel(tcu->rx);
 	mbox_free_channel(tcu->tx);
 
 	return 0;
-- 
2.30.1

