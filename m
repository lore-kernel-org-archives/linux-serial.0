Return-Path: <SRS0=2C4M=7Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126EC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985EE207ED
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFLS0L (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:26:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37918 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgFLS0K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Jun 2020 14:26:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49k8LS03QszB09ZR;
        Fri, 12 Jun 2020 20:26:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zK0L2Sz9oYi5; Fri, 12 Jun 2020 20:26:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49k8LR67jKzB09ZQ;
        Fri, 12 Jun 2020 20:26:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE57B8B78B;
        Fri, 12 Jun 2020 20:26:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ksxZW3-Cg00s; Fri, 12 Jun 2020 20:26:07 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9490B8B77C;
        Fri, 12 Jun 2020 20:26:07 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5369865ACE; Fri, 12 Jun 2020 18:26:07 +0000 (UTC)
Message-Id: <694a25fdce548c5ee8b060ef6a4b02746b8f25c0.1591986307.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] tty: serial: cpm_uart: Fix behaviour for non existing
 GPIOs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Date:   Fri, 12 Jun 2020 18:26:07 +0000 (UTC)
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

Use devm_gpiod_get_index_optional() instead.

At the same time, handle the error case and properly exit
with an error.

Fixes: 97cbaf2c829b ("tty: serial: cpm_uart: Convert to use GPIO descriptors")
Cc: stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Using devm_gpiod_get_index_optional() and exiting if error
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index a04f74d2e854..4df47d02b34b 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1215,7 +1215,12 @@ static int cpm_uart_init_port(struct device_node *np,
 
 		pinfo->gpios[i] = NULL;
 
-		gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
+		gpiod = devm_gpiod_get_index_optional(dev, NULL, i, GPIOD_ASIS);
+
+		if (IS_ERR(gpiod)) {
+			ret = PTR_ERR(gpiod);
+			goto out_irq;
+		}
 
 		if (gpiod) {
 			if (i == GPIO_RTS || i == GPIO_DTR)
@@ -1237,6 +1242,8 @@ static int cpm_uart_init_port(struct device_node *np,
 
 	return cpm_uart_request_port(&pinfo->port);
 
+out_irq:
+	irq_dispose_mapping(pinfo->port.irq);
 out_pram:
 	cpm_uart_unmap_pram(pinfo, pram);
 out_mem:
-- 
2.25.0

