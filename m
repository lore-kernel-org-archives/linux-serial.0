Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E461C07E96
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 08:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A276120A
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 08:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhGOIez (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhGOIey (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Jul 2021 04:34:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD8E06128C;
        Thu, 15 Jul 2021 08:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626337921;
        bh=woZqlikBhzcfKkey7PmgWRKHT0ZS1z/WFIVToT4bwEA=;
        h=From:To:Cc:Subject:Date:From;
        b=qw0/tTG5q9//4jHa/utovc81KcH55xPGWP8ja/agfdc9/Bva7uv5tF/TSS1hem+jv
         CZcvfG7Xq7pFIee9pkHHraDNUiEItcuwv2KeH+o+0jxs6+AE8n36HUnHLDF7QK6asW
         3KEKE0JtK+cm+BoeDemPZdxshnI0EUzrKNK0hDMf0OGtLxrEBq6er35+uvt8SQv5Hy
         Uu3kW11Wq+FWIdkPX7sPWM+yrHVv1KKnIsa2wyIxDtq6iV0H5n6rifuBouWSA8H7cl
         zp5ypXfW4a4actG/ZVQGByjRMu40vgw8DncO6GNQ5hnUjiUOKK+quLEbp4VD/cDp0L
         K7Nt7NXIR97eg==
Received: from johan by xi with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m3wmS-0004vd-U2; Thu, 15 Jul 2021 10:31:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] serial: 8250: extend compile-test coverage
Date:   Thu, 15 Jul 2021 10:30:11 +0200
Message-Id: <20210715083011.18887-1-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Allow more drivers to be compile tested more easily, for example, when
doing subsystem-wide changes.

Verified on X86_64 as well as arm, powerpc and m68k with minimal configs
in order to catch missing implicit build dependencies.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/8250/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d1b3c2373fa4..71ae16de0f90 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -363,7 +363,7 @@ config SERIAL_8250_BCM2835AUX
 config SERIAL_8250_FSL
 	bool
 	depends on SERIAL_8250_CONSOLE
-	default PPC || ARM || ARM64
+	default PPC || ARM || ARM64 || COMPILE_TEST
 
 config SERIAL_8250_DW
 	tristate "Support for Synopsys DesignWare 8250 quirks"
@@ -375,7 +375,8 @@ config SERIAL_8250_DW
 
 config SERIAL_8250_EM
 	tristate "Support for Emma Mobile integrated serial port"
-	depends on SERIAL_8250 && ARM && HAVE_CLK
+	depends on SERIAL_8250 && HAVE_CLK
+	depends on ARM || COMPILE_TEST
 	help
 	  Selecting this option will add support for the integrated serial
 	  port hardware found on the Emma Mobile line of processors.
@@ -383,7 +384,8 @@ config SERIAL_8250_EM
 
 config SERIAL_8250_IOC3
 	tristate "SGI IOC3 8250 UART support"
-	depends on SGI_MFD_IOC3 && SERIAL_8250
+	depends on SERIAL_8250
+	depends on SGI_MFD_IOC3 || COMPILE_TEST
 	select SERIAL_8250_EXTENDED
 	select SERIAL_8250_SHARE_IRQ
 	help
@@ -495,7 +497,7 @@ config SERIAL_8250_MID
 config SERIAL_8250_PXA
 	tristate "PXA serial port support"
 	depends on SERIAL_8250
-	depends on ARCH_PXA || ARCH_MMP
+	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
 	help
 	  If you have a machine based on an Intel XScale PXA2xx CPU you can
 	  enable its onboard serial ports by enabling this option. The option is
-- 
2.31.1

