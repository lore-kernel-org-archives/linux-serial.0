Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8CBC433FE
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548A823EB1
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 13:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392165AbgLKNjw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436904AbgLKNjt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 08:39:49 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D368CC0613D3
        for <linux-serial@vger.kernel.org>; Fri, 11 Dec 2020 05:39:08 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id 31f82400G4C55Sk011f8Ws; Fri, 11 Dec 2020 14:39:08 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1knidY-009iJz-6r; Fri, 11 Dec 2020 14:39:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1knidX-00CSlP-MR; Fri, 11 Dec 2020 14:39:07 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: 8250_pci: Drop bogus __refdata annotation
Date:   Fri, 11 Dec 2020 14:39:07 +0100
Message-Id: <20201211133907.2970460-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit d73dfc6a4199e0e3 ("serial: 8250_pci: remove __devexit
usage") in v3.9, the 8250/16550 PCI serial driver no longer has any code
or data located in initmem, hence there is no need to annotate the
pci_serial_quirks structure with __refdata.  Drop the annotation, to
avoid suppressing future section warnings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index d5a513efb2613dff..689d8227f95f7dfb 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1964,7 +1964,7 @@ pci_moxa_setup(struct serial_private *priv,
  * This list is ordered alphabetically by vendor then device.
  * Specific entries must come before more generic entries.
  */
-static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
+static struct pci_serial_quirk pci_serial_quirks[] = {
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
 	*/
-- 
2.25.1

