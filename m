From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/9] serial: doc: .break_ctl() is called with port->mutex() held
Date: Mon, 14 Mar 2016 16:16:14 +0100
Message-ID: <1457968577-22379-7-git-send-email-geert+renesas@glider.be>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Note that mutex_lock() should not be called with interrupts disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 3b08df5bcc17e944..09e73e061fcf795c 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -177,8 +177,7 @@ hardware.
 	should be terminated when another call is made with a zero
 	ctl.
 
-	Locking: none.
-	Interrupts: caller dependent.
+	Locking: caller holds port->mutex
 	This call must not sleep
 
   startup(port)
-- 
1.9.1

