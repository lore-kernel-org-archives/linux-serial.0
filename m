From: =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
Subject: [PATCH 2/9] drivers: tty: 68328serial.c: remove unnecessary spaces(checkpatch)
Date: Fri, 11 Dec 2015 11:36:02 +0100
Message-ID: <1449830170-15096-3-git-send-email-frederik.voelkel@fau.de>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: jslaby@suse.com, gregkh@linuxfoundation.org, linux-kernel@i4.cs.fau.de, =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>, Lukas Braun <lukas.braun@fau.de>
List-Id: linux-serial@vger.kernel.org

This patch removes unnecessary spaces reported by checkpatch.

Signed-off-by: Frederik V=C3=B6lkel <frederik.voelkel@fau.de>
Signed-off-by: Lukas Braun <lukas.braun@fau.de>
---
 drivers/tty/serial/68328serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/6832=
8serial.c
index 4cdd805..b26cbae 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -538,7 +538,7 @@ static void change_speed(struct m68k_serial *info, =
struct tty_struct *tty)
 =09
 #ifdef CONFIG_SERIAL_68328_RTS_CTS
 	if (cflag & CRTSCTS) {
-		uart->utx.w &=3D ~ UTX_NOCTS;
+		uart->utx.w &=3D ~UTX_NOCTS;
 	} else {
 		uart->utx.w |=3D UTX_NOCTS;
 	}
@@ -1198,7 +1198,7 @@ rs68328_init(void)
 	    printk(" is a builtin MC68328 UART\n");
 	   =20
 #ifdef CONFIG_M68VZ328
-		if (i > 0 )
+		if (i > 0)
 			PJSEL &=3D 0xCF;  /* PSW enable second port output */
 #endif
=20
@@ -1298,7 +1298,7 @@ void m68328_console_write (struct console *co, co=
nst char *str,
     while (count--) {
         if (*str =3D=3D '\n')
            rs_put_char('\r');
-        rs_put_char( *str++ );
+        rs_put_char(*str++);
     }
 }
=20
--=20
1.9.1
