From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 09/26] serial: blackfin: Fix missing gpio.h
Date: Tue,  2 Sep 2014 17:39:18 -0400
Message-ID: <1409693975-1028-10-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

If CONFIG_SERIAL_BFIN_CTSRTS is set, compile fails because of missing
declarations for the gpio_* api. Include necessary header.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/bfin_sport_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 7810aa2..d62d8da 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -33,6 +33,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
+#include <linux/gpio.h>
 
 #include <asm/bfin_sport.h>
 #include <asm/delay.h>
-- 
2.1.0
