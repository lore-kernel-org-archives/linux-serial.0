Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BCDC4332F
	for <linux-serial@archiver.kernel.org>; Thu, 13 Oct 2022 08:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJMIZr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJMIZq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Oct 2022 04:25:46 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137D84D4EF
        for <linux-serial@vger.kernel.org>; Thu, 13 Oct 2022 01:25:40 -0700 (PDT)
Received: from xps.lan (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id 23B2B146402;
        Thu, 13 Oct 2022 08:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1665649075; bh=qgyEyCvSf1EUnMEEIVOGiR7AxKMbjmYW6a0T6PsLLEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A6Ovb3ChLKKHS6lOI45vhYnLnzd0Z0n5gkxhbaQtKaCebap+itvtEDKd8tHCQhsjM
         w1j+WBS5ESOWxk3Ph9RhjZtXPtVaYI5VEdcbxWlz4Ed4OcIxRkC+AcTX+G+mAnkydf
         79gbNYxyLrOz+vycEUgu7ZWPwlbXPnqaKAg8V2BWJwDrfoJECskDoHIlMClyB/jRr9
         Tuz3sgNHyvd+s5wi42POpQYcAYmy5OO+dsppLfR8ogbsjQGZ+JiihaS7IqExstHhmD
         72dEClN0u0P0xm+mnZmkebQFw7HpX6JcaLn7oLIn8hCO4ntWraCg2R/q8O9n0Dl/89
         BW8LiEFV/7sUA==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] serial: 8250: allow zero runtime-configured ports
Date:   Thu, 13 Oct 2022 10:17:47 +0200
Message-Id: <20221013081748.25699-2-martin@geanix.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013081748.25699-1-martin@geanix.com>
References: <20221013081748.25699-1-martin@geanix.com>
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

