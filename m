From: =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
Subject: [PATCH v2 3/4] drivers: tty: 68328serial.c: Use use same indentation for switch/case
Date: Wed, 16 Dec 2015 16:17:00 +0100
Message-ID: <1450279021-17154-4-git-send-email-frederik.voelkel@fau.de>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
 <1450279021-17154-1-git-send-email-frederik.voelkel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450279021-17154-1-git-send-email-frederik.voelkel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, lukas.braun@fau.de, linux-kernel@i4.cs.fau.de, =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
List-Id: linux-serial@vger.kernel.org

This patch fixes an indentation checkpatch error so switch and case
have the same indentation.

Signed-off-by: Frederik V=C3=B6lkel <frederik.voelkel@fau.de>
Signed-off-by: Lukas Braun <lukas.braun@fau.de>
---
 drivers/tty/serial/68328serial.c | 60 ++++++++++++++++++++------------=
--------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/6832=
8serial.c
index f7f9b7e..c0bd3a6 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -936,37 +936,37 @@ static int rs_ioctl(struct tty_struct *tty,
 	}
=20
 	switch (cmd) {
-		case TCSBRK:	/* SVID version: non-zero arg --> no break */
-			retval =3D tty_check_change(tty);
-			if (retval)
-				return retval;
-			tty_wait_until_sent(tty, 0);
-			if (!arg)
-				send_break(info, 250);	/* 1/4 second */
-			return 0;
-		case TCSBRKP:	/* support for POSIX tcsendbreak() */
-			retval =3D tty_check_change(tty);
-			if (retval)
-				return retval;
-			tty_wait_until_sent(tty, 0);
-			send_break(info, arg ? arg*(100) : 250);
-			return 0;
-		case TIOCGSERIAL:
-			return get_serial_info(info,
+	case TCSBRK:	/* SVID version: non-zero arg --> no break */
+		retval =3D tty_check_change(tty);
+		if (retval)
+			return retval;
+		tty_wait_until_sent(tty, 0);
+		if (!arg)
+			send_break(info, 250);	/* 1/4 second */
+		return 0;
+	case TCSBRKP:	/* support for POSIX tcsendbreak() */
+		retval =3D tty_check_change(tty);
+		if (retval)
+			return retval;
+		tty_wait_until_sent(tty, 0);
+		send_break(info, arg ? arg*(100) : 250);
+		return 0;
+	case TIOCGSERIAL:
+		return get_serial_info(info,
+			       (struct serial_struct *) arg);
+	case TIOCSSERIAL:
+		return set_serial_info(info, tty,
 				       (struct serial_struct *) arg);
-		case TIOCSSERIAL:
-			return set_serial_info(info, tty,
-					       (struct serial_struct *) arg);
-		case TIOCSERGETLSR: /* Get line status register */
-			return get_lsr_info(info, (unsigned int *) arg);
-		case TIOCSERGSTRUCT:
-			if (copy_to_user((struct m68k_serial *) arg,
-				    info, sizeof(struct m68k_serial)))
-				return -EFAULT;
-			return 0;
-		default:
-			return -ENOIOCTLCMD;
-		}
+	case TIOCSERGETLSR: /* Get line status register */
+		return get_lsr_info(info, (unsigned int *) arg);
+	case TIOCSERGSTRUCT:
+		if (copy_to_user((struct m68k_serial *) arg,
+			    info, sizeof(struct m68k_serial)))
+			return -EFAULT;
+		return 0;
+	default:
+		return -ENOIOCTLCMD;
+	}
 	return 0;
 }
=20
--=20
1.9.1
