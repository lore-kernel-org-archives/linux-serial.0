From: =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
Subject: [PATCH 3/9] drivers: tty: 68328serial.c: Do not initialize statics to 0
Date: Fri, 11 Dec 2015 11:36:03 +0100
Message-ID: <1449830170-15096-4-git-send-email-frederik.voelkel@fau.de>
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

This patch removes an initialization of a static to 0 as checkpatch
suggests.

Signed-off-by: Frederik V=C3=B6lkel <frederik.voelkel@fau.de>
Signed-off-by: Lukas Braun <lukas.braun@fau.de>
---
 drivers/tty/serial/68328serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/6832=
8serial.c
index b26cbae..b6d7230c 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -157,7 +157,7 @@ static void change_speed(struct m68k_serial *info, =
struct tty_struct *tty);
 #endif
=20
=20
-static int m68328_console_initted =3D 0;
+static int m68328_console_initted;
 static int m68328_console_baud    =3D CONSOLE_BAUD_RATE;
 static int m68328_console_cbaud   =3D DEFAULT_CBAUD;
=20
--=20
1.9.1
