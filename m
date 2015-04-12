From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH] drivers/tty/serial/8250/8250_core.c: remove CONFIG_HUB6
Date: Sun, 12 Apr 2015 17:03:22 +0200
Message-ID: <1428851002-4815-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

This file local CPP identifier is not referenced anywhere else, so we
can safely remove it.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
I detected this issue with ./scripts/checkkconfigsymbols.py
---
 drivers/tty/serial/8250/8250_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e0fb5f053d09..1aa349a97172 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -92,11 +92,6 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
 #define CONFIG_SERIAL_MANY_PORTS 1
 #endif
 
-/*
- * HUB6 is always on.  This will be removed once the header
- * files have been cleaned.
- */
-#define CONFIG_HUB6 1
 
 #include <asm/serial.h>
 /*
-- 
2.1.0
