From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH 1/3] ARM: dts: colibri-vf: Add pinmux for UART_0 aka UART_A
 RTS/CTS pins
Date: Fri, 29 May 2015 13:35:52 +0530
Message-ID: <1432886754-30115-2-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, bhuvanchandra.dv@gmail.com, kernel@pengutronix.de, shawn.guo@linaro.org, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 68ca125..ad6c5ca 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -174,6 +174,8 @@
 			fsl,pins = <
 				VF610_PAD_PTB10__UART0_TX		0x21a2
 				VF610_PAD_PTB11__UART0_RX		0x21a1
+				VF610_PAD_PTB12__UART0_RTS		0x21a2
+				VF610_PAD_PTB13__UART0_CTS		0x21a1
 			>;
 		};
 
-- 
2.1.0
