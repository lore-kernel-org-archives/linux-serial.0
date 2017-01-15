From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/4] ARM64: dts: meson-gx: add the serial CTS and RTS pin
 groups
Date: Sun, 15 Jan 2017 23:32:53 +0100
Message-ID: <20170115223255.10350-3-martin.blumenstingl@googlemail.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, jslaby@suse.com, gregkh@linuxfoundation.org, khilman@baylibre.com, carlo@caione.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This adds pinctrl group nodes for the CTS and RTS pins of each serial
controller. This makes it possible to enable the CTS and RTS pins which
are controlled by the serial controller hardware (through the meson_uart
driver).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 40 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 40 +++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 474435e21759..f001c4d007bc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -138,6 +138,14 @@
 			};
 		};
 
+		uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
+			mux {
+				groups = "uart_cts_ao_a",
+				       "uart_rts_ao_a";
+				function = "uart_ao";
+			};
+		};
+
 		uart_ao_b_pins: uart_ao_b {
 			mux {
 				groups = "uart_tx_ao_b", "uart_rx_ao_b";
@@ -145,6 +153,14 @@
 			};
 		};
 
+		uart_ao_b_cts_rts_pins: uart_ao_b_cts_rts {
+			mux {
+				groups = "uart_cts_ao_b",
+				       "uart_rts_ao_b";
+				function = "uart_ao_b";
+			};
+		};
+
 		remote_input_ao_pins: remote_input_ao {
 			mux {
 				groups = "remote_input_ao";
@@ -290,6 +306,14 @@
 			};
 		};
 
+		uart_a_cts_rts_pins: uart_a_cts_rts {
+			mux {
+				groups = "uart_cts_a",
+				       "uart_rts_a";
+				function = "uart_a";
+			};
+		};
+
 		uart_b_pins: uart_b {
 			mux {
 				groups = "uart_tx_b",
@@ -298,6 +322,14 @@
 			};
 		};
 
+		uart_b_cts_rts_pins: uart_b_cts_rts {
+			mux {
+				groups = "uart_cts_b",
+				       "uart_rts_b";
+				function = "uart_b";
+			};
+		};
+
 		uart_c_pins: uart_c {
 			mux {
 				groups = "uart_tx_c",
@@ -306,6 +338,14 @@
 			};
 		};
 
+		uart_c_cts_rts_pins: uart_c_cts_rts {
+			mux {
+				groups = "uart_cts_c",
+				       "uart_rts_c";
+				function = "uart_c";
+			};
+		};
+
 		i2c_a_pins: i2c_a {
 			mux {
 				groups = "i2c_sck_a",
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 53ed7a5f50ab..7d7fd87f094b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -82,6 +82,14 @@
 			};
 		};
 
+		uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
+			mux {
+				groups = "uart_cts_ao_a",
+				       "uart_rts_ao_a";
+				function = "uart_ao";
+			};
+		};
+
 		uart_ao_b_pins: uart_ao_b {
 			mux {
 				groups = "uart_tx_ao_b", "uart_rx_ao_b";
@@ -89,6 +97,14 @@
 			};
 		};
 
+		uart_ao_b_cts_rts_pins: uart_ao_b_cts_rts {
+			mux {
+				groups = "uart_cts_ao_b",
+				       "uart_rts_ao_b";
+				function = "uart_ao_b";
+			};
+		};
+
 		remote_input_ao_pins: remote_input_ao {
 			mux {
 				groups = "remote_input_ao";
@@ -164,6 +180,14 @@
 			};
 		};
 
+		uart_a_cts_rts_pins: uart_a_cts_rts {
+			mux {
+				groups = "uart_cts_a",
+				       "uart_rts_a";
+				function = "uart_a";
+			};
+		};
+
 		uart_b_pins: uart_b {
 			mux {
 				groups = "uart_tx_b",
@@ -172,6 +196,14 @@
 			};
 		};
 
+		uart_b_cts_rts_pins: uart_b_cts_rts {
+			mux {
+				groups = "uart_cts_b",
+				       "uart_rts_b";
+				function = "uart_b";
+			};
+		};
+
 		uart_c_pins: uart_c {
 			mux {
 				groups = "uart_tx_c",
@@ -180,6 +212,14 @@
 			};
 		};
 
+		uart_c_cts_rts_pins: uart_c_cts_rts {
+			mux {
+				groups = "uart_cts_c",
+				       "uart_rts_c";
+				function = "uart_c";
+			};
+		};
+
 		i2c_a_pins: i2c_a {
 			mux {
 				groups = "i2c_sck_a",
-- 
2.11.0
