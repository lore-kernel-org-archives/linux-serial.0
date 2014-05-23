From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC v2 05/10] ARM: STi: STiH41x: Extend UART with FIQ support.
Date: Fri, 23 May 2014 14:57:53 +0100
Message-ID: <1400853478-5824-6-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradea
List-Id: linux-serial@vger.kernel.org

This patch provides the UART with a second interrupt resource that
can be used to route the UARTs interrupt to FIQ (demarked by setting
bit 7 in the third item in the tuple).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: kernel@stlinux.com
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/stih415.dtsi | 4 ++--
 arch/arm/boot/dts/stih416.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index d89064c..b2c9df4 100644
--- a/arch/arm/boot/dts/stih415.dtsi
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -79,7 +79,7 @@
 			compatible	= "st,asc";
 			status 		= "disabled";
 			reg		= <0xfed32000 0x2c>;
-			interrupts	= <0 197 0>;
+			interrupts	= <0 197 0>, <0 197 0x80>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_serial2>;
 			clocks		= <&CLKS_ICN_REG_0>;
@@ -90,7 +90,7 @@
 			compatible	= "st,asc";
 			status 		= "disabled";
 			reg		= <0xfe531000 0x2c>;
-			interrupts	= <0 210 0>;
+			interrupts	= <0 210 0>, <0 197 0x80>;
 			clocks		= <&CLK_SYSIN>;
 			pinctrl-names 	= "default";
 			pinctrl-0	= <&pinctrl_sbc_serial1>;
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 78746d2..fdf7b43 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -88,7 +88,7 @@
 			compatible	= "st,asc";
 			status 		= "disabled";
 			reg		= <0xfed32000 0x2c>;
-			interrupts	= <0 197 0>;
+			interrupts	= <0 197 0>, <0 210 0x80>;
 			clocks          = <&CLK_S_ICN_REG_0>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_serial2 &pinctrl_serial2_oe>;
@@ -99,7 +99,7 @@
 			compatible	= "st,asc";
 			status 		= "disabled";
 			reg		= <0xfe531000 0x2c>;
-			interrupts	= <0 210 0>;
+			interrupts	= <0 210 0>, <0 210 0x80>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_sbc_serial1>;
 			clocks          = <&CLK_SYSIN>;
-- 
1.9.0
