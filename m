Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E44C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 14:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E9C610F7
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 14:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbhIXOPC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Sep 2021 10:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345078AbhIXOOz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Sep 2021 10:14:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 722B361164;
        Fri, 24 Sep 2021 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632492801;
        bh=9FzflPSvRNuYL+0FLYUAyRLchX7APKhwtwvl5/cvnCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnVgfeKnra6bOv3CxDPW8dODEeB+NZxz9nPundXZ7KqRUktkONycmi3oqO8Sw+eT3
         x3o3vhLGOvlvxDGeOPIYPsTni7Ue4DTMgT3PoYB4Mky0/jAZ4ZC76TD2229HNc1sxj
         9Cmn3N4WgmszYgDbANePd9rNP7YI2ZfFXZpYt5tklPmXi29gnzYD5IQwpfz2zuq+7d
         kurazXGUqlXqACVz0Z7bySPnX3XTK18wQjhjSX8v7q7mITfjwOuC7Nc4PobpChjY+z
         sPdJqISiThoYatIRTwmqz4HD0xN0GaIUx0uT04JSFOSCD8IMdy39OPSNgC1SfdNN13
         3MgyFJ8ZGu+vg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mTlx6-0001AF-Bb; Fri, 24 Sep 2021 16:13:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] serial: 8250: allow disabling of Freescale 16550 compile test
Date:   Fri, 24 Sep 2021 16:12:32 +0200
Message-Id: <20210924141232.4419-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <6421f256407262afd658ffa74ec9430581528a7d.1632467477.git.geert+renesas@glider.be>
References: <6421f256407262afd658ffa74ec9430581528a7d.1632467477.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The SERIAL_8250_FSL option is used to enable a workaround for a
break-detection erratum for Freescale 16550 UARTs in the 8250 driver and
is currently also used to enable support for ACPI enumeration.

It is enabled on PPC, ARM and ARM64 whenever 8250 console support is
enabled (since the quirk is needed for sysrq handling).

Commit b1442c55ce89 ("serial: 8250: extend compile-test coverage")
enabled compile testing of the code in question but did not provide a
means to disable the option when COMPILE_TEST is enabled.

Add a conditional input prompt instead so that SERIAL_8250_FSL is no
longer enabled by default when compile testing while continuing to
always enable the quirk for platforms that may need it.

Fixes: b1442c55ce89 ("serial: 8250: extend compile-test coverage")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/8250/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 71ae16de0f90..39fc96dc2531 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -361,9 +361,13 @@ config SERIAL_8250_BCM2835AUX
 	  If unsure, say N.
 
 config SERIAL_8250_FSL
-	bool
+	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
 	depends on SERIAL_8250_CONSOLE
-	default PPC || ARM || ARM64 || COMPILE_TEST
+	default PPC || ARM || ARM64
+	help
+	  Selecting this option enables a workaround for a break-detection
+	  erratum for Freescale 16550 UARTs in the 8250 driver. It also
+	  enables support for ACPI enumeration.
 
 config SERIAL_8250_DW
 	tristate "Support for Synopsys DesignWare 8250 quirks"
-- 
2.32.0

