From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 7/9] serial: doc: Spelling s/divsor/divisor/
Date: Mon, 14 Mar 2016 16:16:15 +0100
Message-ID: <1457968577-22379-8-git-send-email-geert+renesas@glider.be>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 09e73e061fcf795c..3706a465fe2d7427 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -380,7 +380,7 @@ uart_get_baud_rate(port,termios,old,min,max)
 	Interrupts: n/a
 
 uart_get_divisor(port,baud)
-	Return the divsor (baud_base / baud) for the specified baud
+	Return the divisor (baud_base / baud) for the specified baud
 	rate, appropriately rounded.
 
 	If 38400 baud and custom divisor is selected, return the
-- 
1.9.1

