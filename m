From: Joseph Kogut <joseph.kogut@gmail.com>
Subject: [PATCH] tty: serial: s/Medfile/Medfield
Date: Sun, 22 Feb 2015 17:26:57 -0700
Message-ID: <1424651217-28527-1-git-send-email-joseph.kogut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jslaby@suse.cz
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Joseph Kogut <joseph.kogut@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fixed misspelling of 'Medfield'

Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d2501f0..7baf98c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -489,7 +489,7 @@ config SERIAL_MFD_HSU
 	select SERIAL_CORE
 
 config SERIAL_MFD_HSU_CONSOLE
-	bool "Medfile HSU serial console support"
+	bool "Medfield HSU serial console support"
 	depends on SERIAL_MFD_HSU=y
 	select SERIAL_CORE_CONSOLE
 
-- 
2.3.0
