From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 06/10] dt-bindings: serial: Update 'uart-has-rtscts' description
Date: Fri, 27 Jan 2017 17:28:00 +0000
Message-ID: <20170127172804.23881-7-lee.jones@linaro.org>
References: <20170127172804.23881-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170127172804.23881-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

'uart-has-rtscts' property and 'rts-gpios|cts-gpios' are normally
mutually exclusive, however it is possible for some drivers to have
a dynamic approach, meaning that both properties can be relevant.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/serial/serial.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.txt b/Documentation/devicetree/bindings/serial/serial.txt
index fd970f7..b542a0e 100644
--- a/Documentation/devicetree/bindings/serial/serial.txt
+++ b/Documentation/devicetree/bindings/serial/serial.txt
@@ -23,7 +23,8 @@ Optional properties:
     they are available for use (wired and enabled by pinmux configuration).
     This depends on both the UART hardware and the board wiring.
     Note that this property is mutually-exclusive with "cts-gpios" and
-    "rts-gpios" above.
+    "rts-gpios" above, unless support is provided to switch between modes
+    dynamically.
 
 
 Examples:
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
