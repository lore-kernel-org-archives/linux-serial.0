From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: 8250: include <linux/serial_reg.h> from serial_8250.h
Date: Tue, 26 May 2015 13:28:48 +0900
Message-ID: <1432614528-13605-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The header file, include/linux/serial_8250.h, contains references to
UART_LSR_BRK_ERROR_BITS and UART_MSR_ANY_DELTA that are defined in
<linux/serial_reg.h>.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/serial_8250.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 78097e7..89e44a7 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -12,6 +12,7 @@
 #define _LINUX_SERIAL_8250_H
 
 #include <linux/serial_core.h>
+#include <linux/serial_reg.h>
 #include <linux/platform_device.h>
 
 /*
-- 
1.9.1
