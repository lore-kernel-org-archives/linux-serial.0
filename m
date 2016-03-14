From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/9] serial: doc: Document .set_ldisc()
Date: Mon, 14 Mar 2016 16:16:13 +0100
Message-ID: <1457968577-22379-6-git-send-email-geert+renesas@glider.be>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 3b2a97d5ecc79491..3b08df5bcc17e944 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -259,6 +259,11 @@ hardware.
 	Interrupts: caller dependent.
 	This call must not sleep
 
+  set_ldisc(port,termios)
+	Notifier for discipline change. See Documentation/serial/tty.txt.
+
+	Locking: caller holds port->mutex
+
   pm(port,state,oldstate)
 	Perform any power management related activities on the specified
 	port.  State indicates the new state (defined by
-- 
1.9.1

