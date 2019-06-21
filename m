From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v11 0/6] Add basic node support for Mediatek MT8183 SoC
Date: Fri, 21 Jun 2019 17:53:25 +0200
Message-ID: <8efbf3b7-0e11-b378-e582-769b2f869a00@gmail.com>
References: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Erin Lo <erin.lo@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, mars.cheng@mediatek.com, eddie.huang@mediatek.com
List-Id: linux-serial@vger.kernel.org



On 27/05/2019 11:04, Erin Lo wrote:
> MT8183 is a SoC based on 64bit ARMv8 architecture.
> It contains 4 CA53 and 4 CA73 cores.
> MT8183 share many HW IP with MT65xx series.
> This patchset was tested on MT8183 evaluation board and use correct clock to shell.
> 
> Based on v5.2-rc1
> 

Pushed all to v5.2-next/dts64

Please send patches to update the bindings of auxadc and efuse. They use the
fallback right now, but we should make sure to have the binding in sync.

Regards,
Matthias

> Change in v11:
> New add spi node, efuse node, pinctrl node, auxadc node, and capacity-dmips-mhz field
> 
> Change in v10:
> Add the L2 cache node to prevent warning on unable to detect cache
> hierarchy.
> 
> Change in v9:
> Remove pio node since binding is not documented yet
> 
> Change in v8:
> 1. Fix interrupt-parent of pio node
> 2. Remove pinfunc.h and spi node patches
> 
> Change in v7:
> 1. Place all the MMIO peripherals under one or more simple-bus nodes
> 2. Make the pinfunc.h and spi node into seperate patch
> 3. Modify SPIs pamerater from 4 back to 3
>    and remove patch "support 4 interrupt parameters for sysirq"
> 4. Rename intpol-controller to interrupt-controller
> 5. Rename pinctrl@1000b000 to pinctrl@10005000
> 
> Change in v6:
> 1. Remove power and iommu nodes
> 2. Fix dtb build warning
> 3. Fix pinctrl binding doc
> 4. Fix '_' in node names
> 
> Change in v5:
> 1. Collect all device tree nodes to the last patch
> 2. Add PMU
> 3. Add Signed-off-by
> 4. Remove clock driver code and binding doc
> 5. Add pinctrl, iommu, spi, and pwrap nodes
> 
> Change in v4:
> 1. Correct syntax error in dtsi
> 2. Add MT8183 clock support
> 
> Change in v3:
> 1. Fill out GICC, GICH, GICV regions
> 2. Update Copyright to 2018
> 
> Change in v2:
> 1. Split dt-bindings into different patches
> 2. Correct bindings for supported SoCs (mtk-uart.txt)
> 
> Ben Ho (1):
>   arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
>     Makefile
> 
> Erin Lo (1):
>   arm64: dts: mt8183: add spi node
> 
> Hsin-Yi, Wang (1):
>   arm64: dts: mt8183: add capacity-dmips-mhz
> 
> Michael Mei (1):
>   arm64: dts: mt8183: add efuse and Mediatek Chip id node to read
> 
> Zhiyong Tao (2):
>   arm64: dts: mt8183: add pinctrl device node
>   arm64: dts: mt8183: Add auxadc device node
> 
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 140 ++++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 447 ++++++++++++++++++++
>  3 files changed, 588 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> 
> --
> 1.8.1.1.dirty
> 
