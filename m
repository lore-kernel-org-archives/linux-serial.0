From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 2/8] tty: serial: Suppress deprecated SERIAL_PXA on arm64
Date: Wed, 22 Feb 2017 03:29:22 +0100
Message-ID: <20170222022929.10540-3-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170222022929.10540-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, info@andromedabox.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

With Marvell IAP140 being enabled as first arm64 MMP platform, don't
make the deprecated SERIAL_PXA option available outside ARM.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2: split off
 * Updated for ARCH_MMP
 
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 6117ac8..db83085 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -439,7 +439,7 @@ config SERIAL_MPSC_CONSOLE
 
 config SERIAL_PXA
 	bool "PXA serial port support (DEPRECATED)"
-	depends on ARCH_PXA || ARCH_MMP
+	depends on ARCH_PXA || (ARCH_MMP && ARM)
 	select SERIAL_CORE
 	select SERIAL_8250_PXA if SERIAL_8250=y
 	select SERIAL_PXA_NON8250 if !SERIAL_8250=y
-- 
2.10.2
