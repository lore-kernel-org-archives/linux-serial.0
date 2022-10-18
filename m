Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB537C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 18 Oct 2022 13:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJRNen (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJRNem (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Oct 2022 09:34:42 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7610195B1
        for <linux-serial@vger.kernel.org>; Tue, 18 Oct 2022 06:34:34 -0700 (PDT)
Received: from xps.skovby (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id 5125C579B0;
        Tue, 18 Oct 2022 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1666100070; bh=qgyEyCvSf1EUnMEEIVOGiR7AxKMbjmYW6a0T6PsLLEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ljb3wVpu2QAQ/gdcMeVd9Y4jds8MdjBkieej6SvzWT3YTigsQ23tuqShKscpALoNf
         c2ffMFr+6hN0qvOrVGIoU4PPk2rJBWuwt8gMGbhzkJTBi5kx/Bjin/fFIsY1gkSbAD
         Mz3utpUx2Wk4HwDPigs0ySAmsOq4ekrf9RYyEL7W6MF/mu6SVMr6dpGeobKcFMW3Pn
         H6ohNEFaMkgIhKcQqC6h7HqLJWMihmjKSfEr0Hw7Ur546jGAxjnJesK2pReqHxhZuB
         8wmMzXAPaeB8Z2UxkirUotMCz7HhsJzZQ9WQIoeMPSL7Bwm+4MXEoKlgzi5Wq7roHq
         hg92eOA68PCng==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/3] serial: 8250: allow zero runtime-configured ports
Date:   Tue, 18 Oct 2022 15:34:18 +0200
Message-Id: <20221018133419.134110-2-martin@geanix.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018133419.134110-1-martin@geanix.com>
References: <20221018133419.134110-1-martin@geanix.com>
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
2.38.0

