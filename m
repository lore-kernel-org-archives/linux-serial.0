From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] serial: sh-sci: remove obsolete Kconfig macros
Date: Mon, 25 Mar 2013 11:50:28 +0100
Message-ID: <1364208628.1390.275.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Support for SH7367 and SH7377 got removed in v3.8. Now remove their
last Kconfig macros.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Entirely untested.

 drivers/tty/serial/sh-sci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 4c22a15..5aca736 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -15,8 +15,6 @@
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
     defined(CONFIG_ARCH_SH73A0) || \
-    defined(CONFIG_ARCH_SH7367) || \
-    defined(CONFIG_ARCH_SH7377) || \
     defined(CONFIG_ARCH_SH7372) || \
     defined(CONFIG_ARCH_R8A7740)
 
-- 
1.7.11.7
