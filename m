From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 9/9] serial/arc: Add DT based earlycon support
Date: Thu, 12 Jun 2014 16:01:39 +0530
Message-ID: <1402569099-9900-10-git-send-email-vgupta@synopsys.com>
References: <1402569099-9900-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402569099-9900-1-git-send-email-vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Francois.Bedard-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 arch/arc/boot/dts/angel4.dts  | 3 ++-
 drivers/tty/serial/arc_uart.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arc/boot/dts/angel4.dts b/arch/arc/boot/dts/angel4.dts
index 6b57475967a6..e9fc270d1e0b 100644
--- a/arch/arc/boot/dts/angel4.dts
+++ b/arch/arc/boot/dts/angel4.dts
@@ -17,7 +17,8 @@
 	interrupt-parent = <&intc>;
 
 	chosen {
-		bootargs = "earlycon=arc_uart,mmio32,0xc0fc1000,115200n8 console=ttyARC0,115200n8";
+		bootargs = "earlycon console=ttyARC0,115200n8";
+		stdout-path = &arcuart0;
 	};
 
 	aliases {
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 435de4f2af3b..d9900cb3e7b6 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -579,6 +579,7 @@ static int __init arc_early_console_setup(struct earlycon_device *dev,
 	return 0;
 }
 EARLYCON_DECLARE(arc_uart, arc_early_console_setup);
+OF_EARLYCON_DECLARE(arc_uart, "snps,arc-uart", arc_early_console_setup);
 
 #endif	/* CONFIG_SERIAL_ARC_CONSOLE */
 
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
