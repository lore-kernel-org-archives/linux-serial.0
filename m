From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] serial: pxa2xx: remove __deprecated annotation
Date: Tue,  8 Nov 2016 15:50:41 +0100
Message-ID: <20161108145130.3502815-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Sergey Yanovich <ynvich@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

An otherwise very nice cleanup of the pxa2xx uart support marked the
init function of this driver as __deprecated:

drivers/tty/serial/pxa.c:944:1: error: 'serial_pxa_init' is deprecated [-Werror=deprecated-declarations]

This seems unhelpful to me, as we now warn for every allmodconfig build,
which is otherwise free of warnings on most architectures. Let's
remove the annotation again.

Fixes: ab28f51c77cd ("serial: rewrite pxa2xx-uart to use 8250_core")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index b9dd787cb561..75952811c0da 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -927,7 +927,7 @@ static struct platform_driver serial_pxa_driver = {
 
 
 /* 8250 driver for PXA serial ports should be used */
-static int __deprecated __init serial_pxa_init(void)
+static int __init serial_pxa_init(void)
 {
 	int ret;
 
-- 
2.9.0
