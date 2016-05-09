From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/7] tty: stop defining STD_COM_FLAGS in drivers
Date: Mon,  9 May 2016 09:11:57 +0200
Message-ID: <1462777919-10367-5-git-send-email-jslaby@suse.cz>
References: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

STD_COM_FLAGS is mostly a bad name for what the drivers thinks it is.
Stop using it and pass the flags directly.

cyclades defines it as 0, so we do not assign anything to freshly
tty_port_init'ed structure.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/xtensa/platforms/xt2000/setup.c | 1 -
 drivers/tty/cyclades.c               | 3 ---
 drivers/tty/serial/m32r_sio.c        | 5 +----
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/xtensa/platforms/xt2000/setup.c b/arch/xtensa/platforms/xt2000/setup.c
index 5f4bd71971d6..4904c5c16918 100644
--- a/arch/xtensa/platforms/xt2000/setup.c
+++ b/arch/xtensa/platforms/xt2000/setup.c
@@ -113,7 +113,6 @@ void platform_heartbeat(void)
 }
 
 //#define RS_TABLE_SIZE 2
-//#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF|UPF_SKIP_TEST)
 
 #define _SERIAL_PORT(_base,_irq)					\
 {									\
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 7251430bf149..5d535cb902dc 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -93,8 +93,6 @@ static void cy_send_xchar(struct tty_struct *tty, char ch);
 #define	SERIAL_XMIT_SIZE	(min(PAGE_SIZE, 4096))
 #endif
 
-#define STD_COM_FLAGS (0)
-
 /* firmware stuff */
 #define ZL_MAX_BLOCKS	16
 #define DRIVER_VERSION	0x02010203
@@ -3083,7 +3081,6 @@ static int cy_init_card(struct cyclades_card *cinfo)
 
 		info->port.closing_wait = CLOSING_WAIT_DELAY;
 		info->port.close_delay = 5 * HZ / 10;
-		info->port.flags = STD_COM_FLAGS;
 		init_completion(&info->shutdown_wait);
 
 		if (cy_is_Z(cinfo)) {
diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 68765f7c2645..1b01504cf306 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -51,9 +51,6 @@
 
 #define PASS_LIMIT	256
 
-/* Standard COM flags */
-#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
-
 static const struct {
 	unsigned int port;
 	unsigned int irq;
@@ -892,7 +889,7 @@ static void __init m32r_sio_init_ports(void)
 		up->port.iobase   = old_serial_port[i].port;
 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
 		up->port.uartclk  = BAUD_RATE * 16;
-		up->port.flags    = STD_COM_FLAGS;
+		up->port.flags    = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
 		up->port.membase  = 0;
 		up->port.iotype   = 0;
 		up->port.regshift = 0;
-- 
2.8.2
