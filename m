Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4330C4167B
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 13:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6AA61251
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 13:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhIONVn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbhIONVl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Sep 2021 09:21:41 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39E7C0613D9
        for <linux-serial@vger.kernel.org>; Wed, 15 Sep 2021 06:20:21 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id uDLH2500a4C55Sk06DLHoH; Wed, 15 Sep 2021 15:20:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQUnf-004eT9-Rj; Wed, 15 Sep 2021 15:18:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQUUl-002gVM-9i; Wed, 15 Sep 2021 14:58:35 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: 8250_fsl: Move fsl8250_data to ACPI section
Date:   Wed, 15 Sep 2021 14:58:34 +0200
Message-Id: <e406730a5eab880448d6bb55fbce492d281034ef.1631710623.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The fsl8250_data structure is only used by ACPI support.
Hence move its definition to the driver's ACPI section.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/8250/8250_fsl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index fc65a2293ce9e3cd..9c01c531349dfd41 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -23,10 +23,6 @@
 
 #include "8250.h"
 
-struct fsl8250_data {
-	int	line;
-};
-
 int fsl8250_handle_irq(struct uart_port *port)
 {
 	unsigned char lsr, orig_lsr;
@@ -90,6 +86,10 @@ int fsl8250_handle_irq(struct uart_port *port)
 EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
 
 #ifdef CONFIG_ACPI
+struct fsl8250_data {
+	int	line;
+};
+
 static int fsl8250_acpi_probe(struct platform_device *pdev)
 {
 	struct fsl8250_data *data;
-- 
2.25.1

