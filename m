Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE4C38A2D
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 07:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiJYHkC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Oct 2022 03:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiJYHkA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Oct 2022 03:40:00 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E84D018B
        for <linux-serial@vger.kernel.org>; Tue, 25 Oct 2022 00:39:57 -0700 (PDT)
Received: from xps.skovby (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id D57A157B5E;
        Tue, 25 Oct 2022 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1666683594; bh=FanAamhN0Tyzto9YBh6hDKkv8eCiVXOpGPAkgV/5EVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BGpnf1Urn1X/eOvwVf42PxcN6y1li/USgUg00khyxw7tVaPMJwkceUPEFGgpqa7mf
         IzmHOEmtyub79csY7mUqsqa3tCzlxWVw7U2iYvdGRGIojIYyrUYXTKABPIvVxARqUl
         ZAi7L4swwPu0zZD4Km6NhB6V2K4Vykw0kOjVrlYY6Ay11QQbvsx1+JL/MECFkJX/CP
         tczX8K9cQWymrnQ00iw655V5XQDA26+kNop6esK4pB6Unm+/OD7hpSrpnIqy0QuE+B
         f0LoRTzrxYPDsR/550/KSk4pl3Mn6flklizKHjlvIeqf/rO1i8N/6N3cAb0iYyI/WV
         WxiOVBLIRcx6A==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 2/4] serial: 8250: allow zero runtime-configured ports
Date:   Tue, 25 Oct 2022 09:39:42 +0200
Message-Id: <20221025073944.102437-2-martin@geanix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025073944.102437-1-martin@geanix.com>
References: <20221025073944.102437-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

One should be able to set CONFIG_SERIAL_8250_RUNTIME_UARTS=0 on
platforms with zero built-in 8250-like ports. However, that case was
prohibited in commit 59cfc45f17d6
("serial: 8250: Do nothing if nr_uarts=0"), because of missing array
initialization, effectively disabling the driver entirely.

The missing array initialization has been fixed in the previous commit,
so remove check for zero runtime ports. Said check gets to stay when
initializing early consoles, though, because that makes sense for
built-in ports only.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/tty/serial/8250/8250_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a166cc66e7d1..ba48431ec6e2 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -680,9 +680,6 @@ static struct console univ8250_console = {
 
 static int __init univ8250_console_init(void)
 {
-	if (nr_uarts == 0)
-		return -ENODEV;
-
 	serial8250_isa_init_ports();
 	register_console(&univ8250_console);
 	return 0;
@@ -1171,9 +1168,6 @@ static int __init serial8250_init(void)
 {
 	int ret;
 
-	if (nr_uarts == 0)
-		return -ENODEV;
-
 	serial8250_isa_init_ports();
 
 	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %sabled\n",
-- 
2.38.1

