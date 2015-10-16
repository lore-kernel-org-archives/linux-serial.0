From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/trivial] serial: pl011: Spelling s/clocks-names/clock-names/
Date: Fri, 16 Oct 2015 16:23:06 +0200
Message-ID: <1445005386-17962-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jiri Kosina <trivial@kernel.org>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/pl011.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
index cbae3d9a02780768..77863aefe9ef1eaf 100644
--- a/Documentation/devicetree/bindings/serial/pl011.txt
+++ b/Documentation/devicetree/bindings/serial/pl011.txt
@@ -19,7 +19,7 @@ Optional properties:
 	   must correspond to the PCLK clocking the internal logic
 	   of the block. Just listing one clock (the first one) is
 	   deprecated.
-- clocks-names:
+- clock-names:
 	   When present, the first clock listed must be named
 	   "uartclk" and the second clock listed must be named
 	   "apb_pclk"
-- 
1.9.1
