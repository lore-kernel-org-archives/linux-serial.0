From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH 1/2] drivers/tty/serial/sh-sci.h: remove dead reference on ARCH_SH7372
Date: Sat, 11 Apr 2015 12:26:19 +0200
Message-ID: <1428747979-20455-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, pebolle@tiscali.nl
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

The Kconfig option ARCH_SH7372 has been removed by commit 59b89af1d555
("ARM: shmobile: sh7372: Remove Legacy C SoC code").  This patch removes
the last reference on this Kconfig option.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
I found this issue with ./scripts/checkkconfigsymbols.py
---
 drivers/tty/serial/sh-sci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index d5db81a0a430..350717404507 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -15,7 +15,6 @@
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
     defined(CONFIG_ARCH_SH73A0) || \
-    defined(CONFIG_ARCH_SH7372) || \
     defined(CONFIG_ARCH_R8A7740)
 
 # define SCxSR_RDxF_CLEAR(port)	 (serial_port_in(port, SCxSR) & 0xfffc)
-- 
2.1.0
