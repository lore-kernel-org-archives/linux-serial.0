From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/9] serial: doc: Document .throttle()
Date: Mon, 14 Mar 2016 16:16:11 +0100
Message-ID: <1457968577-22379-4-git-send-email-geert+renesas@glider.be>
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
index 61d520dea4c6e13a..50f3d94ed50b341e 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -126,6 +126,13 @@ hardware.
 	Interrupts: locally disabled.
 	This call must not sleep
 
+  throttle(port)
+	Notify the serial driver that input buffers for the line discipline are
+	close to full, and it should somehow signal that no more characters
+	should be sent to the serial port.
+
+	Locking: none.
+
   send_xchar(port,ch)
 	Transmit a high priority character, even if the port is stopped.
 	This is used to implement XON/XOFF flow control and tcflow().  If
-- 
1.9.1

