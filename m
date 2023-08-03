Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1997EB64DD
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 14:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjHCOUS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 10:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbjHCOUQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 10:20:16 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D27910CA;
        Thu,  3 Aug 2023 07:20:14 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RGr4n3qbPz9t4x;
        Thu,  3 Aug 2023 15:57:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4Sf1yU4GLUXO; Thu,  3 Aug 2023 15:57:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RGr4l6PrLz9t4C;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D84368B773;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Rk4TqBzrY9_N; Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F87B8B778;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 373Dv3TI494181
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 15:57:03 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 373Dv31f494172;
        Thu, 3 Aug 2023 15:57:03 +0200
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
Subject: [PATCH v1 04/12] serial: cpm_uart: Use get_baudrate() instead of uart_baudrate()
Date:   Thu,  3 Aug 2023 15:56:45 +0200
Message-ID: <4d497386f576a3df768e44a04f9bb512e424c311.1691068700.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691068700.git.christophe.leroy@csgroup.eu>
References: <cover.1691068700.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691071000; l=1833; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=hqhoT/NVGFbL9/t+3tZhmV5v3NEDaEY38X+4uIs3ScI=; b=ZOklVu9kfWIIzoy3UK20I9xmKXif6N0Ux2nYcILxBHxaiFftos1FFcd/dH9k17h7+cRluuJbh 9ZJfRFEUimiAbKYwBbX/93dVdVTY35fdcOaXmnMtO7U0ukWB0t8EWyt
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

uart_baudrate() is just a trivial wrapper to get_baudrate().

Use get_baudrate() directly and remove assignment in if condition.

And also remove uart_clock() which is not used since
commit 0b2a2e5b7747 ("cpm_uart: Remove !CONFIG_PPC_CPM_NEW_BINDING
code")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/fs_pd.h            | 10 ----------
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  6 ++++--
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/fs_pd.h b/arch/powerpc/include/asm/fs_pd.h
index 8def56ec05c6..7b61b80f212d 100644
--- a/arch/powerpc/include/asm/fs_pd.h
+++ b/arch/powerpc/include/asm/fs_pd.h
@@ -36,14 +36,4 @@ extern immap_t __iomem *mpc8xx_immr;
 #define immr_unmap(addr) do {} while (0)
 #endif
 
-static inline int uart_baudrate(void)
-{
-        return get_baudrate();
-}
-
-static inline int uart_clock(void)
-{
-        return ppc_proc_freq;
-}
-
 #endif
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index c5a896f79d80..36bac4390c13 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -32,10 +32,11 @@
 #include <linux/gpio/consumer.h>
 #include <linux/clk.h>
 
+#include <sysdev/fsl_soc.h>
+
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
-#include <asm/fs_pd.h>
 #include <asm/udbg.h>
 
 #include <linux/serial_core.h>
@@ -1311,7 +1312,8 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 	if (options) {
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	} else {
-		if ((baud = uart_baudrate()) == -1)
+		baud = get_baudrate();
+		if (baud == -1)
 			baud = 9600;
 	}
 
-- 
2.41.0

