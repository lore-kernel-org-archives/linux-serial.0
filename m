From: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 0/2] Add basic support for Mediatek MT2712 SoC
Date: Fri, 28 Jul 2017 19:37:13 +0800
Message-ID: <1501241835-47849-1-git-send-email-yt.shen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

MT2712 is a SoC based on 64bit ARMv8 architecture.
MT2712 share many HW IP with MT8173.  This patchset was tested on MT2712 evaluation board, and boot to shell ok.

This series contains document bindings, device tree including interrupt and uart.

Changes compared to v4:
- rebase to 4.13-rc1
- use two clocks (baud_clk & sys_clk) instead of one uart_clk to the correct bindings

Changes compared to v3:
- use two uart clocks refer to the bindings

Changes compared to v2:
- remove alias from serial1 to serial5
- remove initrd-start and initrd-end
- change GIC_CPU_MASK_SIMPLE(6) to GIC_CPU_MASK_RAW(0x13)
- change gic-400 reg range

Changes compared to v1:
- change subject prefix for bindings
- change device tree license to SPDX tag.
- change bootargs parameter to DT usage.
- change intpol-controller to interrupt-controller

YT Shen (2):
  dt-bindings: arm: Add bindings for Mediatek MT2712 SoC Platform
  arm64: dts: Add Mediatek SoC MT2712 and evaluation board dts and
    Makefile

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 .../interrupt-controller/mediatek,sysirq.txt       |   1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |  32 ++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          | 178 +++++++++++++++++++++
 6 files changed, 217 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712e.dtsi

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
