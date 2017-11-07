From: Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] Devicetree documentation: add rs485-rts-active-high property
Date: Tue,  7 Nov 2017 08:53:36 +0100
Message-ID: <20171107075336.11236-1-m.oleszczyk@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add description of rs485-rts-active-high property into
/serial/rs485.txt devicetree documentation file.

Signed-off-by: Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
Repair 'From' to match with 'Signed-off-by' section.

 Documentation/devicetree/bindings/serial/rs485.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
index b8415936dfdb..71c38ef7f6e2 100644
--- a/Documentation/devicetree/bindings/serial/rs485.txt
+++ b/Documentation/devicetree/bindings/serial/rs485.txt
@@ -16,6 +16,8 @@ Optional properties:
   feature at boot time. It can be disabled later with proper ioctl.
 - rs485-rx-during-tx: empty property that enables the receiving of data even
   whilst sending data.
+- rs485-rts-active-high: empty property telling to set RTS line high when it is 
+  active.
 
 RS485 example for Atmel USART:
 	usart0: serial@fff8c000 {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
