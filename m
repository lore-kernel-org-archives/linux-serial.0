From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH stable v2 1/2] termios, tty/tty_baudrate.c: fix buffer overrun
Date: Mon, 22 Oct 2018 09:19:04 -0700
Message-ID: <20181022161905.26589-1-hpa@zytor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Eugene Syromiatnikov <esyr@redhat.com>, linux-alpha@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>

On architectures with CBAUDEX == 0 (Alpha and PowerPC), the code in tty_baudrate.c does
not do any limit checking on the tty_baudrate[] array, and in fact a
buffer overrun is possible on both architectures. Add a limit check to
prevent that situation.

This will be followed by a much bigger cleanup/simplification patch.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Requested-by: Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: <linux-alpha@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <stable@vger.kernel.org>
---
 drivers/tty/tty_baudrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 7576ceace571..f438eaa68246 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -77,7 +77,7 @@ speed_t tty_termios_baud_rate(struct ktermios *termios)
 		else
 			cbaud += 15;
 	}
-	return baud_table[cbaud];
+	return cbaud >= n_baud_table ? 0 : baud_table[cbaud];
 }
 EXPORT_SYMBOL(tty_termios_baud_rate);
 
@@ -113,7 +113,7 @@ speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 		else
 			cbaud += 15;
 	}
-	return baud_table[cbaud];
+	return cbaud >= n_baud_table ? 0 : baud_table[cbaud];
 #else	/* IBSHIFT */
 	return tty_termios_baud_rate(termios);
 #endif	/* IBSHIFT */
-- 
2.14.4
