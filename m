From: Joseph Kogut <joseph.kogut@gmail.com>
Subject: [PATCH] tty: serial: Fix spelling of Medfield
Date: Sun,  1 Mar 2015 00:54:41 -0700
Message-ID: <1425196481-3703-1-git-send-email-joseph.kogut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Joseph Kogut <joseph.kogut@gmail.com>
List-Id: linux-serial@vger.kernel.org

Changed 'Medfile' to 'Medfield' in Kconfig

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
2.3.1
