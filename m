From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] serial: hp300: mask the warning for people just doing build coverage
Date: Sat, 21 Jan 2017 22:08:25 -0500
Message-ID: <20170122030825.26709-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Currently this warning is triggered for allmodconfig on m68k.  It is
well intentioned, in that if you are building the driver but not
enabling one of the platforms where the hardware exists, you get a
warning.

The warning dates back to pre-git days, and now we have COMPILE_TEST
so we can use that to mask the warning for people who are obviously
just doing build coverage on tree wide changes.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/8250_hp300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index 38166db2b824..115190b7962a 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -19,7 +19,7 @@
 
 #include "8250.h"
 
-#if !defined(CONFIG_HPDCA) && !defined(CONFIG_HPAPCI)
+#if !defined(CONFIG_HPDCA) && !defined(CONFIG_HPAPCI) && !defined(CONFIG_COMPILE_TEST)
 #warning CONFIG_SERIAL_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
 #endif
 
-- 
2.11.0
