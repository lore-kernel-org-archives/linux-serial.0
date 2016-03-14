From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 8/9] serial: doc: Grammar s/function are/functions are/
Date: Mon, 14 Mar 2016 16:16:16 +0100
Message-ID: <1457968577-22379-9-git-send-email-geert+renesas@glider.be>
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
index 3706a465fe2d7427..ba84d1f38ca1d1e6 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -458,7 +458,7 @@ mctrl_gpio_init(port, idx):
 
 mctrl_gpio_free(dev, gpios):
 	This will free the requested gpios in mctrl_gpio_init().
-	As devm_* function are used, there's generally no need to call
+	As devm_* functions are used, there's generally no need to call
 	this function.
 
 mctrl_gpio_to_gpiod(gpios, gidx)
-- 
1.9.1

