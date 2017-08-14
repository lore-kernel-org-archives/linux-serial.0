From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v6 0/2] Add basic support for Mediatek MT2712 SoC
Date: Mon, 14 Aug 2017 17:15:37 +0200
Message-ID: <d40ece12-5148-af2a-fb83-00c56230e175@gmail.com>
References: <1501847977-4023-1-git-send-email-yt.shen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501847977-4023-1-git-send-email-yt.shen@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YT Shen <yt.shen@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mars Cheng <mars.cheng@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, yingjoe.chen@mediatek.com
List-Id: linux-serial@vger.kernel.org



On 08/04/2017 01:59 PM, YT Shen wrote:
> MT2712 is a SoC based on 64bit ARMv8 architecture.
> MT2712 share many HW IP with MT8173.  This patchset was tested on MT2712 evaluation board, and boot to shell ok.
> 
> This series contains document bindings, device tree including interrupt and uart.
> 

pushed to v4.13-next/dts64

Thanks

> Changes compared to v5:
> - remove the soc node
> 
> Changes compared to v4:
> - rebase to 4.13-rc1
> - use two clocks (baud_clk & sys_clk) instead of one uart_clk to the correct bindings
> 
> Changes compared to v3:
> - use two uart clocks refer to the bindings
> 
> Changes compared to v2:
> - remove alias from serial1 to serial5
> - remove initrd-start and initrd-end
> - change GIC_CPU_MASK_SIMPLE(6) to GIC_CPU_MASK_RAW(0x13)
> - change gic-400 reg range
> 
> Changes compared to v1:
> - change subject prefix for bindings
> - change device tree license to SPDX tag.
> - change bootargs parameter to DT usage.
> - change intpol-controller to interrupt-controller
> 
> YT Shen (2):
>    dt-bindings: arm: Add bindings for Mediatek MT2712 SoC Platform
>    arm64: dts: Add Mediatek SoC MT2712 and evaluation board dts and
>      Makefile
> 
>   Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
>   .../interrupt-controller/mediatek,sysirq.txt       |   1 +
>   .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
>   arch/arm64/boot/dts/mediatek/Makefile              |   1 +
>   arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |  32 ++++
>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi          | 171 +++++++++++++++++++++
>   6 files changed, 210 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> 
