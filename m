From: Colin Leitner <colin.leitner@googlemail.com>
Subject: [PATCH] pl2303: fixed handling of CS5 setting. 5 databits work now
Date: Sun, 3 Nov 2013 15:47:06 +0100
Message-ID: <CAAMgOiUAwXNYbfAicgq+k0OZfKN8--pgR_-zCVSC2wm90bww0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35753 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab3KCOrI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 3 Nov 2013 09:47:08 -0500
Received: by mail-wi0-f171.google.com with SMTP id f4so2788240wiw.16
        for <linux-serial@vger.kernel.org>; Sun, 03 Nov 2013 06:47:06 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

pl2303: fixed handling of CS5 setting. 5 databits work now

This patch fixes the CS5 setting on the PL2303 USB-to-serial devices. CS5 has
a value of 0 and the CSIZE setting has been skipped altogether by the enclosing
if. Tested on 3.11.6 and the scope shows the correct output after the fix has
been applied.

Tagged to be added to stable, because it fixes a user visible driver bug and is
simple enough to backport easily.

Cc: stable@vger.kernel.org
Signed-off-by: Colin Leitner <colin.leitner@gmail.com>
---
 drivers/usb/serial/pl2303.c |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index bedf8e4..fd86357 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -522,23 +522,21 @@ static void pl2303_set_termios(struct tty_struct *tty,
                            0, 0, buf, 7, 100);
        dev_dbg(&port->dev, "0xa1:0x21:0:0  %d - %7ph\n", i, buf);

-       if (C_CSIZE(tty)) {
-               switch (C_CSIZE(tty)) {
-               case CS5:
-                       buf[6] = 5;
-                       break;
-               case CS6:
-                       buf[6] = 6;
-                       break;
-               case CS7:
-                       buf[6] = 7;
-                       break;
-               default:
-               case CS8:
-                       buf[6] = 8;
-               }
-               dev_dbg(&port->dev, "data bits = %d\n", buf[6]);
+       switch (C_CSIZE(tty)) {
+       case CS5:
+               buf[6] = 5;
+               break;
+       case CS6:
+               buf[6] = 6;
+               break;
+       case CS7:
+               buf[6] = 7;
+               break;
+       default:
+       case CS8:
+               buf[6] = 8;
        }
+       dev_dbg(&port->dev, "data bits = %d\n", buf[6]);

        /* For reference:   buf[0]:buf[3] baud rate value */
        pl2303_encode_baudrate(tty, port, spriv->type, buf);
-- 
1.7.10.4
