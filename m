From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] serial: samsung: Remove redundant DEBUG_LL check
Date: Mon, 13 Jul 2015 13:18:51 +0200
Message-ID: <1436786331-5188-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-samsung-soc@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-serial@vger.kernel.org

Commit 84f57d9e3685 ("tty: serial/samsung: fix modular build") fixed
build issues when the driver was built as a module. One of those was
that printascii is only accessible when the driver is built-in.

But there is no need to check for defined(CONFIG_DEBUG_LL) since the
SERIAL_SAMSUNG_DEBUG Kconfig symbol already depends on DEBUG_LL.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/tty/serial/samsung.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 67d0c213b1c7..8c963d6d9074 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -53,7 +53,6 @@
 #include "samsung.h"
 
 #if	defined(CONFIG_SERIAL_SAMSUNG_DEBUG) &&	\
-	defined(CONFIG_DEBUG_LL) &&		\
 	!defined(MODULE)
 
 extern void printascii(const char *);
-- 
2.4.3
