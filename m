Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E0EC04A95
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 07:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiJYHkD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Oct 2022 03:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiJYHkC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Oct 2022 03:40:02 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB515BC780
        for <linux-serial@vger.kernel.org>; Tue, 25 Oct 2022 00:39:59 -0700 (PDT)
Received: from xps.skovby (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id AE09357B5F;
        Tue, 25 Oct 2022 07:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1666683596; bh=FUmC+OGv0I7Nvfopjtaj/kknM9e7xXBjcOJlUhrvTmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IlHuUvCfI3eQLXHLtLkZq0RZetTwOng5nx8QTtGtr96/LKtno1dgsNbgNeWAqRaxj
         ShgSmz4zrdczja/tVrj1s4OWt7OPzimI2zuOVMTBOjPHLptWYp/BsGSQiihfllZ4gg
         IrOvDlm+XhtTmqmjtB5H4FHgHosq5uSIbvMLODs7a/CjP2XQFPlTpfPDe2lXEE2yWL
         o+87vwvI09biM/r1AsmikVwvh9hc6d6uYIz2rSUmL+ytwLbf2LhA2P+xSeZM7xh85h
         QsS3KTOSeyTyV3E01zn/EgTIp3CmzeKFUjsZxS2lH85lW6ESW2t1NPDoc+PXMTeGgg
         edIoAF/vqdoWw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 3/4] serial: 8250: skip platform device registration with no runtime ports
Date:   Tue, 25 Oct 2022 09:39:43 +0200
Message-Id: <20221025073944.102437-3-martin@geanix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025073944.102437-1-martin@geanix.com>
References: <20221025073944.102437-1-martin@geanix.com>
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

Change since v2:
 * invert condition to initialize built-in ports (as suggested by Ilpo)

 drivers/tty/serial/8250/8250_core.c | 30 +++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ba48431ec6e2..a8fbc2325244 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1186,22 +1186,26 @@ static int __init serial8250_init(void)
 	if (ret)
 		goto unreg_uart_drv;
 
-	serial8250_isa_devs = platform_device_alloc("serial8250",
-						    PLAT8250_DEV_LEGACY);
-	if (!serial8250_isa_devs) {
-		ret = -ENOMEM;
-		goto unreg_pnp;
+	if (nr_uarts) {
+		serial8250_isa_devs = platform_device_alloc("serial8250",
+							    PLAT8250_DEV_LEGACY);
+		if (!serial8250_isa_devs) {
+			ret = -ENOMEM;
+			goto unreg_pnp;
+		}
+
+		ret = platform_device_add(serial8250_isa_devs);
+		if (ret)
+			goto put_dev;
+
+		serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
 	}
 
-	ret = platform_device_add(serial8250_isa_devs);
-	if (ret)
-		goto put_dev;
-
-	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
-
 	ret = platform_driver_register(&serial8250_isa_driver);
 	if (ret == 0)
 		goto out;
+	if (!nr_uarts)
+		goto unreg_pnp;
 
 	platform_device_del(serial8250_isa_devs);
 put_dev:
@@ -1230,7 +1234,9 @@ static void __exit serial8250_exit(void)
 	serial8250_isa_devs = NULL;
 
 	platform_driver_unregister(&serial8250_isa_driver);
-	platform_device_unregister(isa_dev);
+
+	if (nr_uarts)
+		platform_device_unregister(isa_dev);
 
 	serial8250_pnp_exit();
 
-- 
2.38.1

