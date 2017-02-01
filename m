From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 06/10] dt-bindings: serial: Update 'uart-has-rtscts' description
Date: Wed,  1 Feb 2017 14:31:41 +0000
Message-ID: <20170201143145.31962-7-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170201143145.31962-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

'uart-has-rtscts' property and 'rts-gpios|cts-gpios' are normally
mutually exclusive, however it is possible for some drivers to have
a dynamic approach, meaning that both properties can be relevant.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
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
