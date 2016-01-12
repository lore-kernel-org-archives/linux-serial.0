From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/3] TTY: xtensa/iss/console, remove unused _INLINE_ definition
Date: Tue, 12 Jan 2016 10:52:50 +0100
Message-ID: <1452592370-24951-3-git-send-email-jslaby@suse.cz>
References: <1452592370-24951-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452592370-24951-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
List-Id: linux-serial@vger.kernel.org

This is a remnant from the dark age. Nobody uses the macro now, so
remove.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: <linux-xtensa@linux-xtensa.org>
---
 arch/xtensa/platforms/iss/console.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 70cb408bc20d..c54505dcf4db 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -28,10 +28,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
-#ifdef SERIAL_INLINE
-#define _INLINE_ inline
-#endif
-
 #define SERIAL_MAX_NUM_LINES 1
 #define SERIAL_TIMER_VALUE (HZ / 10)
 
-- 
2.7.0
