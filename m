From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 9/9] serial: doc: Correct return type of mctrl_gpio_to_gpiod()
Date: Mon, 14 Mar 2016 16:16:17 +0100
Message-ID: <1457968577-22379-10-git-send-email-geert+renesas@glider.be>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index ba84d1f38ca1d1e6..65de49a4b39e5baf 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -462,7 +462,8 @@ mctrl_gpio_free(dev, gpios):
 	this function.
 
 mctrl_gpio_to_gpiod(gpios, gidx)
-	This returns the gpio structure associated to the modem line index.
+	This returns the gpio_desc structure associated to the modem line
+	index.
 
 mctrl_gpio_set(gpios, mctrl):
 	This will sets the gpios according to the mctrl state.
-- 
1.9.1

