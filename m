From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] serial: doc: .break_ctl() may sleep
Date: Thu, 14 Apr 2016 11:08:11 +0200
Message-ID: <1460624891-8389-5-git-send-email-geert+renesas@glider.be>
References: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hurley <peter@hurleysoftware.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

As mutex_lock() must not be called with interrupts disabled,
.break_ctl() may sleep.

Reported-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 7fb80682e394eb76..39701515832b70b0 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -187,7 +187,6 @@ hardware.
 	ctl.
 
 	Locking: caller holds port->mutex
-	This call must not sleep
 
   startup(port)
 	Grab any interrupt resources and initialise any low level driver
-- 
1.9.1

