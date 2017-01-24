From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5/8] ARM: dts: STiH410-b2260: Identify the UART RTS line
Date: Tue, 24 Jan 2017 13:43:07 +0000
Message-ID: <20170124134310.27512-6-lee.jones@linaro.org>
References: <20170124134310.27512-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170124134310.27512-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

When hardware flow-control is disabled, manual toggling of the UART's
reset line (RTS) using userland applications (e.g. stty) is not
possible, since the ASC IP does not provide this functionality in the
same was as some other IPs do.  Thus, we have to do this manually.
This patch configures the UART RTS line as a GPIO for manipulation
within the UART driver when HW flow-control is not enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih410-b2260.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 06b0696..fa16aba 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -63,6 +63,7 @@
 		uart0: serial@9830000 {
 			label = "LS-UART0";
 			status = "okay";
+			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Low speed expansion connector */
-- 
2.10.2
