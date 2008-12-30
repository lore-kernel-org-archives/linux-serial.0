From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: [PATCH] powerpc: add ioctls for RS485 mode control of serial drivers
Date: Tue, 30 Dec 2008 11:59:38 +0100
Message-ID: <200812301159.38832.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:45341 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629AbYL3K7o (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Dec 2008 05:59:44 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: linux-serial@vger.kernel.org

These ioctls take a struct serial_rs485
(see linux/serial.h) as argument. They are already available
on x86. This patch adds them for the powerpc architecture.

Signed-off-by: Matthias Fuchs <mfuchs@ma-fu.de>
---
 arch/powerpc/include/asm/ioctls.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ioctls.h 
b/arch/powerpc/include/asm/ioctls.h
index 279a622..1842186 100644
--- a/arch/powerpc/include/asm/ioctls.h
+++ b/arch/powerpc/include/asm/ioctls.h
@@ -89,6 +89,8 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TIOCGRS485	0x542e
+#define TIOCSRS485	0x542f
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux 
device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
-- 
1.5.6.3


