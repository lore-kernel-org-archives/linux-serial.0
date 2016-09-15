From: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/3] devicetree: bindings: uart: Add new compatible string for ZynqMP
Date: Thu, 15 Sep 2016 14:45:30 +0530
Message-ID: <1473930931-1034-2-git-send-email-navam@xilinx.com>
References: <1473930931-1034-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473930931-1034-1-git-send-email-navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
Cc: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Scott Telford <stelford-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
[stelford-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org: cherry picked from
https://github.com/Xilinx/linux-xlnx commit
37b8a9780766422b2437f5166ddef3767bb60887]
Signed-off-by: Scott Telford <stelford-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
---
Changes for v2:
		-None

 Documentation/devicetree/bindings/serial/cdns,uart.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
index a3eb154..4fe7aae 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
@@ -1,7 +1,8 @@
 Binding for Cadence UART Controller
 
 Required properties:
-- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
+- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq and
+               "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC uart controller.
 - reg: Should contain UART controller registers location and length.
 - interrupts: Should contain UART controller interrupts.
 - clocks: Must contain phandles to the UART clocks
-- 
2.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
