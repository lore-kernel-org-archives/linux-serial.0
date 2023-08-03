Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4219BEB64DD
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 14:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjHCOUV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjHCOUU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 10:20:20 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0978011B;
        Thu,  3 Aug 2023 07:20:18 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RGr4c1Jw0z9t3S;
        Thu,  3 Aug 2023 15:57:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pCYp6389DTH2; Thu,  3 Aug 2023 15:57:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RGr4b1NMZz9t3W;
        Thu,  3 Aug 2023 15:57:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A4778B776;
        Thu,  3 Aug 2023 15:57:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kDG7ZK9UYyI2; Thu,  3 Aug 2023 15:57:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D0DF18B763;
        Thu,  3 Aug 2023 15:57:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 373DuvIJ494161
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 15:56:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 373Duv1P494160;
        Thu, 3 Aug 2023 15:56:57 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Timur Tabi <timur@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v1 01/12] serial: cpm_uart: Avoid suspicious locking
Date:   Thu,  3 Aug 2023 15:56:42 +0200
Message-ID: <f7da5cdc9287960185829cfef681a7d8614efa1f.1691068700.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691068700.git.christophe.leroy@csgroup.eu>
References: <cover.1691068700.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691071000; l=2066; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=g1/VJfSY6urnYolQkf6XjuqARyJIyQnB+2i32ZVNAL8=; b=ox36XmAYX8W9jeRLvNG7fKCBBZNkkZiraAKzbwxaL6IRb4RnMjidksKybn8nHV7gQhBFVWUS2 KtQcpca72eOB3BTBWKygA/DrIogB5ilpy3rzlEEst3AvHs/emqviZtG
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  CHECK   drivers/tty/serial/cpm_uart/cpm_uart_core.c
drivers/tty/serial/cpm_uart/cpm_uart_core.c:1271:39: warning: context imbalance in 'cpm_uart_console_write' - unexpected unlock

Allthough 'nolock' is not expected to change, sparse find the following
form suspicious:

	if (unlikely(nolock)) {
		local_irq_save(flags);
	} else {
		spin_lock_irqsave(&pinfo->port.lock, flags);
	}

	cpm_uart_early_write(pinfo, s, count, true);

	if (unlikely(nolock)) {
		local_irq_restore(flags);
	} else {
		spin_unlock_irqrestore(&pinfo->port.lock, flags);
	}

Rewrite it a more obvious form:

	if (unlikely(oops_in_progress)) {
		local_irq_save(flags);
		cpm_uart_early_write(pinfo, s, count, true);
		local_irq_restore(flags);
	} else {
		spin_lock_irqsave(&pinfo->port.lock, flags);
		cpm_uart_early_write(pinfo, s, count, true);
		spin_unlock_irqrestore(&pinfo->port.lock, flags);
	}

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 66afa9bea6bf..71366a4cea22 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1255,19 +1255,14 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 {
 	struct uart_cpm_port *pinfo = &cpm_uart_ports[co->index];
 	unsigned long flags;
-	int nolock = oops_in_progress;
 
-	if (unlikely(nolock)) {
+	if (unlikely(oops_in_progress)) {
 		local_irq_save(flags);
-	} else {
-		spin_lock_irqsave(&pinfo->port.lock, flags);
-	}
-
-	cpm_uart_early_write(pinfo, s, count, true);
-
-	if (unlikely(nolock)) {
+		cpm_uart_early_write(pinfo, s, count, true);
 		local_irq_restore(flags);
 	} else {
+		spin_lock_irqsave(&pinfo->port.lock, flags);
+		cpm_uart_early_write(pinfo, s, count, true);
 		spin_unlock_irqrestore(&pinfo->port.lock, flags);
 	}
 }
-- 
2.41.0

