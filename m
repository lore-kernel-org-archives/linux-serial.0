Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C8EC001DB
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 10:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjHDKUt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 06:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHDKUs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 06:20:48 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85D6D2118;
        Fri,  4 Aug 2023 03:20:47 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 1F15E80F7;
        Fri,  4 Aug 2023 10:20:44 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Merge TTY layer and serial drivers
Date:   Fri,  4 Aug 2023 13:20:40 +0300
Message-ID: <20230804102042.53576-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg suggested we merge TTY layer and serial driver entries to
avoid duplicates.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 MAINTAINERS | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19227,13 +19227,6 @@ F:	Documentation/devicetree/bindings/serial/serial.yaml
 F:	drivers/tty/serdev/
 F:	include/linux/serdev.h
 
-SERIAL DRIVERS
-M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-L:	linux-serial@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/serial/
-F:	drivers/tty/serial/
-
 SERIAL IR RECEIVER
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
@@ -21639,20 +21632,16 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
-TTY LAYER
+TTY LAYER AND SERIAL DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-serial@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
+F:	Documentation/devicetree/bindings/serial/
 F:	Documentation/driver-api/serial/
 F:	drivers/tty/
-F:	drivers/tty/serial/serial_base.h
-F:	drivers/tty/serial/serial_base_bus.c
-F:	drivers/tty/serial/serial_core.c
-F:	drivers/tty/serial/serial_ctrl.c
-F:	drivers/tty/serial/serial_port.c
 F:	include/linux/selection.h
 F:	include/linux/serial.h
 F:	include/linux/serial_core.h
-- 
2.41.0
