From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/7] tty: frv, remove unused serial macros
Date: Mon,  9 May 2016 09:11:56 +0200
Message-ID: <1462777919-10367-4-git-send-email-jslaby@suse.cz>
References: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, David Howells <dhowells@redhat.com>
List-Id: linux-serial@vger.kernel.org

STD_COM_FLAGS needs not be defined as it is not used anywhere on frv.

SERIAL_PORT_DFNS is defined to be empty. 8250 is aware of empty
SERIAL_PORT_DFNS and does:
 #ifndef SERIAL_PORT_DFNS
 #define SERIAL_PORT_DFNS
 #endif

So no need to define it on frv.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: David Howells <dhowells@redhat.com>
---
 arch/frv/include/asm/serial.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/frv/include/asm/serial.h b/arch/frv/include/asm/serial.h
index bce0d0d07e60..614c6d76789a 100644
--- a/arch/frv/include/asm/serial.h
+++ b/arch/frv/include/asm/serial.h
@@ -12,7 +12,3 @@
  * the base baud is derived from the clock speed and so is variable
  */
 #define BASE_BAUD 0
-
-#define STD_COM_FLAGS		UPF_BOOT_AUTOCONF
-
-#define SERIAL_PORT_DFNS
-- 
2.8.2
