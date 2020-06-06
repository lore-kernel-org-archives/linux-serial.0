Return-Path: <SRS0=QrCK=7T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2A0C433E0
	for <linux-serial@archiver.kernel.org>; Sat,  6 Jun 2020 07:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B042520663
	for <linux-serial@archiver.kernel.org>; Sat,  6 Jun 2020 07:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFFHac (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Jun 2020 03:30:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44832 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgFFHab (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Jun 2020 03:30:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49fB4Y2pkwz9v6VQ;
        Sat,  6 Jun 2020 09:30:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1VOIR6gHcwWC; Sat,  6 Jun 2020 09:30:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49fB4Y1hMHz9v6VP;
        Sat,  6 Jun 2020 09:30:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C5E38B774;
        Sat,  6 Jun 2020 09:30:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 06WYmrPJF0JY; Sat,  6 Jun 2020 09:30:22 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 56F868B75B;
        Sat,  6 Jun 2020 09:30:22 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E07A363B15; Sat,  6 Jun 2020 07:30:21 +0000 (UTC)
Message-Id: <bafd8df9e743c433196c727293c5015620fae2b8.1591428452.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] tty: serial: cpm_uart: Fix behaviour for non existing GPIOs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Date:   Sat,  6 Jun 2020 07:30:21 +0000 (UTC)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

devm_gpiod_get_index() doesn't return NULL but -ENOENT when the
requested GPIO doesn't exist,  leading to the following messages:

[    2.742468] gpiod_direction_input: invalid GPIO (errorpointer)
[    2.748147] can't set direction for gpio #2: -2
[    2.753081] gpiod_direction_input: invalid GPIO (errorpointer)
[    2.758724] can't set direction for gpio #3: -2
[    2.763666] gpiod_direction_output: invalid GPIO (errorpointer)
[    2.769394] can't set direction for gpio #4: -2
[    2.774341] gpiod_direction_input: invalid GPIO (errorpointer)
[    2.779981] can't set direction for gpio #5: -2
[    2.784545] ff000a20.serial: ttyCPM1 at MMIO 0xfff00a20 (irq = 39, base_baud = 8250000) is a CPM UART

Use IS_ERR_OR_NULL() to properly check gpiod validity.

Fixes: 97cbaf2c829b ("tty: serial: cpm_uart: Convert to use GPIO descriptors")
Cc: stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index a04f74d2e854..3cbe24802296 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1217,7 +1217,7 @@ static int cpm_uart_init_port(struct device_node *np,
 
 		gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
 
-		if (gpiod) {
+		if (!IS_ERR_OR_NULL(gpiod)) {
 			if (i == GPIO_RTS || i == GPIO_DTR)
 				ret = gpiod_direction_output(gpiod, 0);
 			else
-- 
2.25.0

