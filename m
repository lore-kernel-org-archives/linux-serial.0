Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27582C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 25 Sep 2021 22:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E399360F21
	for <linux-serial@archiver.kernel.org>; Sat, 25 Sep 2021 22:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhIYWtE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Sep 2021 18:49:04 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:35838
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230024AbhIYWtD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Sep 2021 18:49:03 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2729540CE5;
        Sat, 25 Sep 2021 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632610047;
        bh=3kqfyTB51XM71SI4JIl+mR30FIHSwMKG1CloF0Xq/fo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=RKVV0cw9rvazB0Tiaa1gNr09xoedTFqYNlMvxJ7nIF1QLFEVoiXWZ9Y6J5qrCAplf
         +ZncFb8GK1c4l5gbLdcetLaphZP/715fFxFB1vGWwDE9kokwJUG41BbBHKSgBjPDec
         hRd1XIFvduPFh2n8mU9hibZt+k8XzQBYMOvKHr5BQXmm3BNAl/Pzvcrnpthxebo9ou
         xK20ShW8/JSIoOLT4uFuXpYIrGCBfAX7I1O0ZzfltR4XZBMvD1dFREZWisMTgKsE3A
         m1GSuEzl7p8MrHhDCA1hRY7z+vML1zi6fuS61POj16SJaJ1/zCjR91StooMLlUAlJr
         uxAkr6hWlHrjg==
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: sifive: set pointer to NULL rather than 0.
Date:   Sat, 25 Sep 2021 23:47:26 +0100
Message-Id: <20210925224726.183360-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Clean up the assignment of sifive_serial_console_ports[ssp->port.line],
this is a pointer to a struct sifive_serial_port so the assignment
should be a NULL rather than a integer 0.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 0ac0371f943b..b79900d0e91a 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -887,7 +887,7 @@ static void __ssp_add_console_port(struct sifive_serial_port *ssp)
 
 static void __ssp_remove_console_port(struct sifive_serial_port *ssp)
 {
-	sifive_serial_console_ports[ssp->port.line] = 0;
+	sifive_serial_console_ports[ssp->port.line] = NULL;
 }
 
 #define SIFIVE_SERIAL_CONSOLE	(&sifive_serial_console)
-- 
2.32.0

