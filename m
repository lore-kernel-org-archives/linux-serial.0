From: Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH linux-next] MIPS: ioctls: Add missing TIOC{S,G}RS485 definitions
Date: Tue, 9 Sep 2014 12:52:55 +0100
Message-ID: <1410263575-26720-1-git-send-email-markos.chandras@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: Markos Chandras <markos.chandras@imgtec.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Commit e676253b19b2d269cccf67fdb1592120a0cd0676
(serial/8250: Add support for RS485 IOCTLs) added cases for the
TIOC{S,G}RS485 commands but this broke the build for MIPS:

drivers/tty/serial/8250/8250_core.c: In function 'serial8250_ioctl':
drivers/tty/serial/8250/8250_core.c:2874:7: error: 'TIOCSRS485' undeclared
(first use in this function)
drivers/tty/serial/8250/8250_core.c:2886:7: error: 'TIOCGRS485' undeclared
(first use in this function)

This patch adds these missing definitions

Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: <linux-next@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/ioctls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
index b1e637757fe3..34050cb6b631 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -76,6 +76,8 @@
 
 #define TIOCSBRK	0x5427	/* BSD compatibility */
 #define TIOCCBRK	0x5428	/* BSD compatibility */
+#define TIOCGRS485	0x542E
+#define TIOCSRS485	0x542F
 #define TIOCGSID	0x7416	/* Return the session ID of FD */
 #define TCGETS2		_IOR('T', 0x2A, struct termios2)
 #define TCSETS2		_IOW('T', 0x2B, struct termios2)
-- 
2.1.0
