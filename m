Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A64C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 21:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFA061528
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 21:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347110AbhI2Vpq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346779AbhI2Vpp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 17:45:45 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A53C06161C
        for <linux-serial@vger.kernel.org>; Wed, 29 Sep 2021 14:44:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14c:485:504a:b573:3d62:4f2f:678d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5963E80641;
        Wed, 29 Sep 2021 23:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632951840;
        bh=WwGSxEGNbHzzabfmoQXzUhpuKakN+jmv23Zdt+O4BNc=;
        h=From:To:Cc:Subject:Date:From;
        b=n+sYaOTL1jk7KzvHBgyVExv39woOu9JrQShWi/gCWqDIG7z6Pt72bD5ImeRjhgfxA
         VBaS+hgR1Z4HCbUA9HAiMybvhHD7RS4tIX4eTKZ2wPtCMEiGOCCwf8IHUJ93/Xsfnp
         7Avc0+v17Qm86HksCC/UjLpUGDpFneokjUVnfcWW8ErhMT1kToPxfllD80gYVlWOLn
         wrIZfKkZ5g7Qj5/VOKXVoxu8xPVzq/87kmtCHHoZB3XuU7JPpVvEt1SeQgRpSYuo5U
         i1ISAnMdgz3kiIj2Q8HhLicOM5lFxsCqf3rDkdkfa9RZ8CMw1i0cLlUcIDg9WtpCHS
         +oseZpDueQcTg==
From:   Fabio Estevam <festevam@denx.de>
To:     gregkh@linuxfoundation.org
Cc:     michael@walle.cc, linux-serial@vger.kernel.org, johan@kernel.org,
        marex@denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] serial: imx: Fix sysrq deadlock
Date:   Wed, 29 Sep 2021 18:43:24 -0300
Message-Id: <20210929214324.44910-1-festevam@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following sysrq command causes the following deadlock:

 # echo t > /proc/sysrq-trigger
 ....
[   20.325246] ======================================================
[   20.325252] WARNING: possible circular locking dependency detected
[   20.325260] 5.15.0-rc2-next-20210924-00004-gd2d6e664f29f-dirty #163
Not tainted
[   20.325273] ------------------------------------------------------
[   20.325279] sh/236 is trying to acquire lock:
[   20.325293] c1618614 (console_owner){-...}-{0:0}, at:
console_unlock+0x180/0x5bc
[   20.325361]
[   20.325361] but task is already holding lock:
[   20.325368] eefccc90 (&pool->lock){-.-.}-{2:2}, at:
show_workqueue_state+0x104/0x3c8
[   20.325432]
[   20.325432] which lock already depends on the new lock.

...

[   20.325657] -> #2 (&pool->lock/1){-.-.}-{2:2}:
[   20.325690]        __queue_work+0x114/0x810
[   20.325710]        queue_work_on+0x54/0x94
[   20.325727]        __imx_uart_rxint.constprop.0+0x1b4/0x2e0
[   20.325760]        imx_uart_int+0x270/0x310

This problem happens because uart_handle_sysrq_char() is called
with the lock held.

Fix this by using the same approach done in commit 5697df7322fe ("serial:
fsl_lpuart: split sysrq handling"), which calls 
uart_unlock_and_check_sysrq() to drop the lock prior to 
uart_handle_sysrq_char().

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- I noticed that when sending break + t via the terminal, the characters
were sometimes lost. Do the minimal changes to fix the deadlock without
missing the sysrq input.

 drivers/tty/serial/imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..1c768dd3896d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -788,6 +788,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 	unsigned int rx, flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
 
+	uart_unlock_and_check_sysrq(&sport->port);
 	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
 		u32 usr2;
 
@@ -846,6 +847,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 out:
 	tty_flip_buffer_push(port);
 
+	spin_lock(&sport->port.lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

