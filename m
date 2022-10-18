Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28818C43219
	for <linux-serial@archiver.kernel.org>; Tue, 18 Oct 2022 13:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiJRNeo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiJRNem (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Oct 2022 09:34:42 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0E4101DB
        for <linux-serial@vger.kernel.org>; Tue, 18 Oct 2022 06:34:35 -0700 (PDT)
Received: from xps.skovby (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id ED6E9579B1;
        Tue, 18 Oct 2022 13:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1666100072; bh=mNsqSl6YDVCE9NikCts87i4U1Q6BJxyF7joSSpDkQco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=P+y95Rgx3Wx+27BcUXTp0TnYkZsb1009MgQkvZd8k90ocboe6AB6EUSpuvMPheqc4
         TdRWMiyO1A8hU+2GdfhXI7j6dUWbuq0ttA23efVbsLfUWZFHs02zhkAAKpJvOWt776
         3sKf0MssyOkUMEg/bFs7bc7p6/4KivZ+X6gOS8gfQGQ8jn7idv3LwE7rR0RDN11fsM
         x0Sc1qL4vVzE6ggjGcyMeV1Zu2FqzVZYvwY+Hs0ziP3/HCCnH8JvwmNU3Ge39R053x
         v+JK8PushbAwylm1gdEWSuqaTT5hBgrrccB+KzIDEd1CfEc2toBGxuotOzE4nsrgTu
         Cic5HtDwA74Uw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 3/3] serial: 8250: skip platform device registration with no runtime ports
Date:   Tue, 18 Oct 2022 15:34:19 +0200
Message-Id: <20221018133419.134110-3-martin@geanix.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018133419.134110-1-martin@geanix.com>
References: <20221018133419.134110-1-martin@geanix.com>
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

Change since v1:
 * call serial8250_pnp_init() also when nr_uarts is zero

 drivers/tty/serial/8250/8250_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ba48431ec6e2..f4a08fb74c31 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1186,6 +1186,14 @@ static int __init serial8250_init(void)
 	if (ret)
 		goto unreg_uart_drv;
 
+	if (nr_uarts == 0) {
+		ret = platform_driver_register(&serial8250_isa_driver);
+		if (ret)
+			goto unreg_pnp;
+
+		goto out;
+	}
+
 	serial8250_isa_devs = platform_device_alloc("serial8250",
 						    PLAT8250_DEV_LEGACY);
 	if (!serial8250_isa_devs) {
@@ -1230,7 +1238,9 @@ static void __exit serial8250_exit(void)
 	serial8250_isa_devs = NULL;
 
 	platform_driver_unregister(&serial8250_isa_driver);
-	platform_device_unregister(isa_dev);
+
+	if (nr_uarts)
+		platform_device_unregister(isa_dev);
 
 	serial8250_pnp_exit();
 
-- 
2.38.0

