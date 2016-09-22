From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3] devicetree: bindings: uart: Add new compatible string for
 ZynqMP
Date: Thu, 22 Sep 2016 16:50:35 +0530
Message-ID: <1474543235-38151-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jslaby@suse.com, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, punnaia@xilinx.com
Cc: Nava kishore Manne <nava.manne@xilinx.com>, Nava kishore Manne <navam@xilinx.com>
List-Id: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch Adds the new compatiable string for ZynqMP.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v3:
		-Added changeLog comment.
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
