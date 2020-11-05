Return-Path: <SRS0=qe7h=EL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF1C388F7
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 20:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BE120756
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 20:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgKEUkd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEUkc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 15:40:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B5CC0613CF
        for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2020 12:40:32 -0800 (PST)
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kam3X-0000UK-UJ; Thu, 05 Nov 2020 21:40:28 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Fugang Duan <fugang.duan@nxp.com>, linux-serial@vger.kernel.org,
        patchwork-lst@pengutronix.de, kernel@pengutronix.de
Date:   Thu,  5 Nov 2020 21:40:26 +0100
Message-Id: <20201105204026.1818219-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: l.stach@pengutronix.de
Subject: [PATCH v3] tty: serial: imx: enable earlycon by default if IMX_SERIAL_CONSOLE is enabled
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since 699cc4dfd140 (tty: serial: imx: add imx earlycon driver), the earlycon
part of imx serial is a separate driver and isn't necessarily enabled anymore
when the console is enabled. This causes users to loose the earlycon
functionality when upgrading their kenrel configuration via oldconfig.

Enable earlycon by default when IMX_SERIAL_CONSOLE is enabled.

Fixes: 699cc4dfd140 (tty: serial: imx: add imx earlycon driver)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
v2: add R-b from Fabio, fix typo in subject
v3: no changes, adding this note
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1044fc387691..28f22e58639c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -522,6 +522,7 @@ config SERIAL_IMX_EARLYCON
 	depends on OF
 	select SERIAL_EARLYCON
 	select SERIAL_CORE_CONSOLE
+	default y if SERIAL_IMX_CONSOLE
 	help
 	  If you have enabled the earlycon on the Freescale IMX
 	  CPU you can make it the earlycon by answering Y to this option.
-- 
2.20.1

