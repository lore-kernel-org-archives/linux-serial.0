From: Pranith Kumar <bobby.prani@gmail.com>
Subject: [PATCH] serial: Fix build failure caused by missing header file
Date: Wed, 20 Aug 2014 12:55:45 -0400
Message-ID: <1408553745-3536-2-git-send-email-bobby.prani@gmail.com>
References: <1408553745-3536-1-git-send-email-bobby.prani@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408553745-3536-1-git-send-email-bobby.prani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Fix build failure caused by missing header file:

drivers/tty/serial/nwpserial.c: In function 'wait_for_bits':
drivers/tty/serial/nwpserial.c:53:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 drivers/tty/serial/nwpserial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/nwpserial.c b/drivers/tty/serial/nwpserial.c
index c06366b..5da7622 100644
--- a/drivers/tty/serial/nwpserial.c
+++ b/drivers/tty/serial/nwpserial.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 #include <linux/nwpserial.h>
+#include <linux/delay.h>
 #include <asm/prom.h>
 #include <asm/dcr.h>
 
-- 
1.9.1
