From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: [PATCH 2/2] tty: serial: use module_init on pl011_init
Date: Wed,  6 Feb 2013 19:47:15 +0800
Message-ID: <1360151235-11980-2-git-send-email-haojian.zhuang@linaro.org>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:53132 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab3BFLsf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 06:48:35 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so618288dak.28
        for <linux-serial@vger.kernel.org>; Wed, 06 Feb 2013 03:48:34 -0800 (PST)
In-Reply-To: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jslaby@suse.cz, linus.walleij@linaro.org, anton.vorontsov@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, Haojian Zhuang <haojian.zhuang@linaro.org>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

If amba serial driver is probed defer, amba serial driver may be
probed after init process. So the error log shows in below.

[    0.389403] Warning: unable to open an initial console.
[    0.390107] Freeing init memory: 2328K

It results in serial console not enabled. So replace arch_initcall
by module_init on pl011_init(). The boot sequence is changed in below.

  pinctrl driver --> amba serial driver --> init process

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d43d530..8b7dacb 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2129,11 +2129,7 @@ static void __exit pl011_exit(void)
 	uart_unregister_driver(&amba_reg);
 }
 
-/*
- * While this can be a module, if builtin it's most likely the console
- * So let's leave module_exit but move module_init to an earlier place
- */
-arch_initcall(pl011_init);
+module_init(pl011_init);
 module_exit(pl011_exit);
 
 MODULE_AUTHOR("ARM Ltd/Deep Blue Solutions Ltd");
-- 
1.7.10.4

