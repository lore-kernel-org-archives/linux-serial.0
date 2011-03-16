From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/76] hvc_dcc: Simplify assembly for v6 and v7 ARM
Date: Wed, 16 Mar 2011 14:11:44 -0700
Message-ID: <1300309966-5745-14-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32953 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab1CPVNL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:11 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Walker <dwalker@codeaurora.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Stephen Boyd <sboyd@codeaurora.org>

The inline assembly differences for v6 vs. v7 in the hvc_dcc
driver are purely optimizations. On a v7 processor, an mrc with
the pc sets the condition codes to the 28-31 bits of the register
being read. It just so happens that the TX/RX full bits the DCC
driver is testing for are high enough in the register to be put
into the condition codes. On a v6 processor, this "feature" isn't
implemented and thus we have to do the usual read, mask, test
operations to check for TX/RX full.

Since we already test the RX/TX full bits before calling
__dcc_getchar() and __dcc_putchar() we don't actually need to do
anything special for v7 over v6. The only difference is in
hvc_dcc_get_chars(). We would test RX full, poll RX full, and
then read a character from the buffer, whereas now we will test
RX full, read a character from the buffer, and then test RX full
again for the second iteration of the loop. It doesn't seem
possible for the buffer to go from full to empty between testing
the RX full and reading a character. Therefore, replace the v7
versions with the v6 versions and everything works the same.

Acked-by: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/hvc/hvc_dcc.c |   24 ------------------------
 1 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index ad23cc8..435f6fa 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -40,19 +40,6 @@ static inline u32 __dcc_getstatus(void)
 }
 
 
-#if defined(CONFIG_CPU_V7)
-static inline char __dcc_getchar(void)
-{
-	char __c;
-
-	asm volatile("get_wait:	mrc p14, 0, pc, c0, c1, 0                  \n\
-			bne get_wait                                       \n\
-			mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
-		: "=r" (__c) : : "cc");
-
-	return __c;
-}
-#else
 static inline char __dcc_getchar(void)
 {
 	char __c;
@@ -62,24 +49,13 @@ static inline char __dcc_getchar(void)
 
 	return __c;
 }
-#endif
 
-#if defined(CONFIG_CPU_V7)
-static inline void __dcc_putchar(char c)
-{
-	asm volatile("put_wait:	mrc p14, 0, pc, c0, c1, 0         \n\
-			bcs put_wait                              \n\
-			mcr p14, 0, %0, c0, c5, 0                   "
-	: : "r" (c) : "cc");
-}
-#else
 static inline void __dcc_putchar(char c)
 {
 	asm volatile("mcr p14, 0, %0, c0, c5, 0	@ write a char"
 		: /* no output register */
 		: "r" (c));
 }
-#endif
 
 static int hvc_dcc_put_chars(uint32_t vt, const char *buf, int count)
 {
-- 
1.7.4.1

