From: jon@ringle.org
Subject: [PATCH 2/2] serial: sc16is7xx: fix implicit decl of func copy_{to,from}_user
Date: Fri, 25 Apr 2014 15:53:10 -0400
Message-ID: <1398455590-4374-2-git-send-email-jon@ringle.org>
References: <1398455590-4374-1-git-send-email-jon@ringle.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398455590-4374-1-git-send-email-jon@ringle.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, shc_work@mail.ru, Jon Ringle <jringle@gridpoint.com>
List-Id: linux-serial@vger.kernel.org

From: Jon Ringle <jringle@gridpoint.com>

Fix by including linux/uaccess.h:

   drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_ioctl':
>> drivers/tty/serial/sc16is7xx.c:861:3: error: implicit declaration of function 'copy_from_user' [-Werror=implicit-function-declaration]
>> drivers/tty/serial/sc16is7xx.c:867:3: error: implicit declaration of function 'copy_to_user' [-Werror=implicit-function-declaration]

Signed-off-by: Jon Ringle <jringle@gridpoint.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ed139f5..7206a64 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -25,6 +25,7 @@
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/uaccess.h>
 
 #define SC16IS7XX_NAME			"sc16is7xx"
 
-- 
1.8.5.4
