From: Daniele Forsi <dforsi@gmail.com>
Subject: [PATCH v2] serial: 8250_hp300: trivial: fix symbol name in #warning message
Date: Fri,  8 Aug 2014 17:56:30 +0200
Message-ID: <1407513390-18261-1-git-send-email-dforsi@gmail.com>
References: <20140808152938.GA16594@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36150 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbaHHP6G (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Aug 2014 11:58:06 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so5776220wgh.15
        for <linux-serial@vger.kernel.org>; Fri, 08 Aug 2014 08:58:04 -0700 (PDT)
In-Reply-To: <20140808152938.GA16594@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Jiri Kosina <trivial@kernel.org>, linux-serial@vger.kernel.org
Cc: Daniele Forsi <dforsi@gmail.com>

The symbol is defined in drivers/tty/serial/8250/Kconfig as
"SERIAL_8250", not just "8250".

Signed-off-by: Daniele Forsi <dforsi@gmail.com>
---
Changes in v2:
 - fix the original message and do not duplicate the whole check

 drivers/tty/serial/8250/8250_hp300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index 5bdaf27..afffe4d 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -21,7 +21,7 @@
 #include "8250.h"
 
 #if !defined(CONFIG_HPDCA) && !defined(CONFIG_HPAPCI)
-#warning CONFIG_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
+#warning CONFIG_SERIAL_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
 #endif
 
 #ifdef CONFIG_HPAPCI
-- 
2.0.1

