From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/13] tty: hvc_dcc: Fix duplicate character inputs
Date: Mon, 21 Nov 2011 17:11:32 -0800
Message-ID: <1321924303-26475-2-git-send-email-gregkh@suse.de>
References: <20111122005917.GD25420@kroah.com>
 <1321924303-26475-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42043 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648Ab1KVBM4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 20:12:56 -0500
In-Reply-To: <1321924303-26475-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Stephen Boyd <sboyd@codeaurora.org>

Reading from the DCC grabs a character from the buffer and
clears the status bit. Since this is a context-changing
operation, instructions following the character read that rely on
the status bit being accurate need to be synchronized with an
ISB.

In this case, the status bit check needs to execute after the
character read otherwise we run the risk of reading the character
and checking the status bit before the read can clear the status
bit in the first place. When this happens, the user will see the
same character they typed twice, instead of once.

Add an ISB after the read and the write, so that the status check
is synchronized with the read/write operations.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/hvc/hvc_dcc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 435f6fa..44fbeba 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -46,6 +46,7 @@ static inline char __dcc_getchar(void)
 
 	asm volatile("mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
 		: "=r" (__c));
+	isb();
 
 	return __c;
 }
@@ -55,6 +56,7 @@ static inline void __dcc_putchar(char c)
 	asm volatile("mcr p14, 0, %0, c0, c5, 0	@ write a char"
 		: /* no output register */
 		: "r" (c));
+	isb();
 }
 
 static int hvc_dcc_put_chars(uint32_t vt, const char *buf, int count)
-- 
1.7.7.3

