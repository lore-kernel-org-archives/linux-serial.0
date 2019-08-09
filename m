From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH v2 6/6] arm64: defconfig: Enable configs for S32V234
Date: Fri, 9 Aug 2019 11:29:17 +0000
Message-ID: <20190809112853.15846-7-stefan-gabriel.mirea@nxp.com>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
Cc: "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
List-Id: linux-serial@vger.kernel.org

From: Mihaela Martinas <Mihaela.Martinas@freescale.com>

Enable support for the S32V234 SoC, including the previously added UART
driver.

Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Signed-off-by: Adrian.Nitu <adrian.nitu@freescale.com>
Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..bb5aa95a8455 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -48,6 +48,7 @@ CONFIG_ARCH_MXC=3Dy
 CONFIG_ARCH_QCOM=3Dy
 CONFIG_ARCH_RENESAS=3Dy
 CONFIG_ARCH_ROCKCHIP=3Dy
+CONFIG_ARCH_S32=3Dy
 CONFIG_ARCH_SEATTLE=3Dy
 CONFIG_ARCH_STRATIX10=3Dy
 CONFIG_ARCH_SYNQUACER=3Dy
@@ -347,6 +348,8 @@ CONFIG_SERIAL_XILINX_PS_UART=3Dy
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=3Dy
 CONFIG_SERIAL_FSL_LPUART=3Dy
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=3Dy
+CONFIG_SERIAL_FSL_LINFLEXUART=3Dy
+CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=3Dy
 CONFIG_SERIAL_MVEBU_UART=3Dy
 CONFIG_SERIAL_DEV_BUS=3Dy
 CONFIG_VIRTIO_CONSOLE=3Dy
--=20
2.22.0
