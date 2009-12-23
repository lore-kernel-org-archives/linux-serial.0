From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: [PATCH 1/5] serial: TTY: new ldisc for TI BT/FM/GPS chips
Date: Wed, 23 Dec 2009 15:06:42 +0530 (IST)
Message-ID: <919778.72163.qm@web94913.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web94913.mail.in2.yahoo.com ([203.104.17.184]:35190 "HELO
	web94913.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752812AbZLWJnZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Dec 2009 04:43:25 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

From: Pavan Savoy <pavan_savoy@ti.com>

A new N_SHARED line discipline added for TI BT/FM/GPS
combo chips which make use of same TTY to communicate
with chip. This is to be made use of individual protocol
BT/FM/GPS drivers

Signed-off-by: Pavan Savoy <pavan_savoy@ti.com>
---
include/linux/tty.h |    3 ++-
1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index ef3a294..ba7df77 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -23,7 +23,7 @@
  */
#define NR_UNIX98_PTY_DEFAULT    4096      /* Default maximum for Unix98 ptys */
#define NR_UNIX98_PTY_MAX    (1 << MINORBITS) /* Absolute limit */
-#define NR_LDISCS        20
+#define NR_LDISCS        21

/* line disciplines */
#define N_TTY        0
@@ -48,6 +48,7 @@
#define N_PPS        18    /* Pulse per Second */

#define N_V253        19    /* Codec control over voice modem */
+#define N_SHARED    20    /* for TI BT/FM/GPS combo devices*/

/*
  * This character is the same as _POSIX_VDISABLE: it cannot be used as
-- 
1.5.6.3



      The INTERNET now has a personality. YOURS! See your Yahoo! Homepage. http://in.yahoo.com/
