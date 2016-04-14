From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] serial: doc: .(un)throttle() depends on hardware assisted flow control
Date: Thu, 14 Apr 2016 11:08:09 +0200
Message-ID: <1460624891-8389-3-git-send-email-geert+renesas@glider.be>
References: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hurley <peter@hurleysoftware.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Document that .throttle() and .unthrottle() are relevant only if
hardware assisted flow control is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 03369d076ca20a98..03b703cf93182216 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -135,6 +135,7 @@ hardware.
 	Notify the serial driver that input buffers for the line discipline are
 	close to full, and it should somehow signal that no more characters
 	should be sent to the serial port.
+	This will be called only if hardware assisted flow control is enabled.
 
 	Locking: none.
 
@@ -142,6 +143,7 @@ hardware.
 	Notify the serial driver that characters can now be sent to the serial
 	port without fear of overrunning the input buffers of the line
 	disciplines.
+	This will be called only if hardware assisted flow control is enabled.
 
 	Locking: none.
 
-- 
1.9.1

