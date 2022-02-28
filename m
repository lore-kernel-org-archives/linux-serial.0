Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1785C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Feb 2022 06:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiB1GvM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Feb 2022 01:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiB1GvK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Feb 2022 01:51:10 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC254F444;
        Sun, 27 Feb 2022 22:50:29 -0800 (PST)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Mon, 28 Feb 2022
 14:50:27 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Yu Tu <yu.tu@amlogic.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tty: serial: meson: Fix the compile link error reported by kernel test robot
Date:   Mon, 28 Feb 2022 14:49:10 +0800
Message-ID: <20220228064910.11636-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Describes the calculation of the UART baud rate clock using a clock
frame. Forgot to add in Kconfig kernel test Robot compilation error
due to COMMON_CLK dependency.

Fixes: 44023b8e1f14 ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e952ec5c7a7c..a0f2b82fc18b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -200,6 +200,7 @@ config SERIAL_KGDB_NMI
 config SERIAL_MESON
 	tristate "Meson serial port support"
 	depends on ARCH_MESON || COMPILE_TEST
+	depends on COMMON_CLK
 	select SERIAL_CORE
 	help
 	  This enables the driver for the on-chip UARTs of the Amlogic

base-commit: c2faf737abfb10f88f2d2612d573e9edc3c42c37
-- 
2.33.1

