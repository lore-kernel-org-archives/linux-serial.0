From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/9] serial: doc: Document .unthrottle()
Date: Mon, 14 Mar 2016 16:16:12 +0100
Message-ID: <1457968577-22379-5-git-send-email-geert+renesas@glider.be>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 50f3d94ed50b341e..3b2a97d5ecc79491 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -133,6 +133,13 @@ hardware.
 
 	Locking: none.
 
+  unthrottle(port)
+	Notify the serial driver that characters can now be sent to the serial
+	port without fear of overrunning the input buffers of the line
+	disciplines.
+
+	Locking: none.
+
   send_xchar(port,ch)
 	Transmit a high priority character, even if the port is stopped.
 	This is used to implement XON/XOFF flow control and tcflow().  If
-- 
1.9.1

