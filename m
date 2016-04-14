From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] serial: doc: .(un)throttle() are serialized by the tty layer
Date: Thu, 14 Apr 2016 11:08:10 +0200
Message-ID: <1460624891-8389-4-git-send-email-geert+renesas@glider.be>
References: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hurley <peter@hurleysoftware.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Document that .(un)throttle() are serialized with each other, and with
termios modification by the tty layer.

Reported-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 03b703cf93182216..7fb80682e394eb76 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -137,7 +137,8 @@ hardware.
 	should be sent to the serial port.
 	This will be called only if hardware assisted flow control is enabled.
 
-	Locking: none.
+	Locking: serialized with .unthrottle() and termios modification by the
+		 tty layer.
 
   unthrottle(port)
 	Notify the serial driver that characters can now be sent to the serial
@@ -145,7 +146,8 @@ hardware.
 	disciplines.
 	This will be called only if hardware assisted flow control is enabled.
 
-	Locking: none.
+	Locking: serialized with .throttle() and termios modification by the
+		 tty layer.
 
   send_xchar(port,ch)
 	Transmit a high priority character, even if the port is stopped.
-- 
1.9.1

