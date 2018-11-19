From: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 04/14] dt-bindings: timer: Add Milbeaut M10V timer description
Date: Mon, 19 Nov 2018 10:01:09 +0900
Message-ID: <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Sugaya Taichi <sugaya.taichi@socionext.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette <mturquette@baylibre.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-serial@vger.kernel.org

Add DT bindings document for Milbeaut M10V timer.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
new file mode 100644
index 0000000..ddb1b31
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
@@ -0,0 +1,17 @@
+Milbeaut SoCs Timer Controller
+
+Required properties:
+
+- compatible : should be "socionext,milbeaut-m10v-timer"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt of the first timer
+- clocks: should be "rclk"
+
+Example:
+
+timer {
+	compatible = "socionext,milbeaut-m10v-timer";
+	reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
+	interrupts = <0 91 4>;
+	clocks = <&rclk>;
+};
-- 
1.9.1
