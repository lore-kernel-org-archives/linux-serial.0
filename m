Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA735C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 13 Oct 2022 08:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJMIZv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJMIZu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Oct 2022 04:25:50 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05753A79
        for <linux-serial@vger.kernel.org>; Thu, 13 Oct 2022 01:25:40 -0700 (PDT)
Received: from xps.lan (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id EFEE5146403;
        Thu, 13 Oct 2022 08:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1665649077; bh=T4ZTdriQe48UUW4+bGtFVqkTVvwmO0ozeAu31DqCdnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=edG3xXUbfG3VLj9j7KywFgG/ag2kJuZv7WHJ5MlekSUbMTVihnQm/O76TYctTWNoB
         KYJ59vw0bfJeWhedgHEnGPpKqIfZBYZEIqfn+khjq6aBlI6eEan/hf1XqR11KpnOH+
         q4Yks8/cIrBFnzKCsKSUqxLtEr24xWlXDNegieHl0iueqfX0Y+o/xrAI/kLe8BhDVw
         aWDEhivZWTnHD8Uzv8ceJREtS482Y6s0WTQiM8Fbc9705COKSc3nzaY3gU0q+ZcJ3t
         4pGeHbcHDfzUJQaBMN7NlKVPFTKWyGvX0wqK2c83NpLTtce41n/IOarLDRGPIEmAXZ
         e249l0GVNmPEg==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] serial: 8250: skip platform device registration with no runtime ports
Date:   Thu, 13 Oct 2022 10:17:48 +0200
Message-Id: <20221013081748.25699-3-martin@geanix.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013081748.25699-1-martin@geanix.com>
References: <20221013081748.25699-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Skip registration of the platform device used for built-in ports, if no
such ports are configured/created.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/tty/serial/8250/8250_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ba48431ec6e2..3161f32c1e90 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1182,6 +1182,14 @@ static int __init serial8250_init(void)
 	if (ret)
 		goto out;
 
+	if (nr_uarts == 0) {
+		ret = platform_driver_register(&serial8250_isa_driver);
+		if (ret)
+			goto unreg_uart_drv;
+
+		goto out;
+	}
+
 	ret = serial8250_pnp_init();
 	if (ret)
 		goto unreg_uart_drv;
@@ -1230,9 +1238,11 @@ static void __exit serial8250_exit(void)
 	serial8250_isa_devs = NULL;
 
 	platform_driver_unregister(&serial8250_isa_driver);
-	platform_device_unregister(isa_dev);
 
-	serial8250_pnp_exit();
+	if (nr_uarts) {
+		platform_device_unregister(isa_dev);
+		serial8250_pnp_exit();
+	}
 
 #ifdef CONFIG_SPARC
 	sunserial_unregister_minors(&serial8250_reg, UART_NR);
-- 
2.38.0

