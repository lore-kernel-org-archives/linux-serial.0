From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch] tty: fix a build failure on sparc
Date: Fri,  3 Feb 2012 13:22:10 +0800
Message-ID: <1328246540-5824-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35096 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2BCFWo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Feb 2012 00:22:44 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@suse.de>, WANG Cong <xiyou.wangcong@gmail.com>, Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, Stephen Warren <swarren@nvidia.com>, linux-serial@vger.kernel.org

On sparc, there is a build failure:

drivers/tty/serial/8250/8250.c:48:21: error: suncore.h: No such file or directory
drivers/tty/serial/8250/8250.c:3275: error: implicit declaration of function 'sunserial_register_minors'
drivers/tty/serial/8250/8250.c:3305: error: implicit declaration of function 'sunserial_unregister_minors'

this is due to commit 9bef3d4197379a995fa80f81950bbbf8d32e9e8b
(serial: group all the 8250 related code together) moved these files
into 8250/ subdirectory, but forgot to change the reference
to drivers/tty/serial/suncore.h.

Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 9f50c4e..9b7336f 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -45,7 +45,7 @@
 #include "8250.h"
 
 #ifdef CONFIG_SPARC
-#include "suncore.h"
+#include "../suncore.h"
 #endif
 
 /*
