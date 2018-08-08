From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
Date: Wed, 8 Aug 2018 12:01:32 +0530
Message-ID: <454c277e-8a63-81cb-b341-a50f4e25cbea@ti.com>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <linux@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On Tuesday 05 June 2018 07:35 PM, Rob Herring wrote:
> On Tue, Jun 5, 2018 at 1:05 AM, Nishanth Menon <nm@ti.com> wrote:
>> The AM654 SoC is a lead device of the K3 Multicore SoC architecture
>> platform, targeted for broad market and industrial control with aim to
>> meet the complex processing needs of modern embedded products.
>>
>> Some highlights of this SoC are:
>> * Quad ARMv8 A53 cores split over two clusters
>> * GICv3 compliant GIC500
>> * Configurable L3 Cache and IO-coherent architecture
>> * Dual lock-step capable R5F uC for safety-critical applications
>> * High data throughput capable distributed DMA architecture under NAVSS
>> * Three Gigabit Industrial Communication Subsystems (ICSSG), each with dual
>>   PRUs and dual RTUs
>> * Hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
>> * Centralized System Controller for Security, Power, and Resource
>>   management.
>> * Dual ADCSS, eQEP/eCAP, eHRPWM, dual CAN-FD
>> * Flash subystem with OSPI and Hyperbus interfaces
>> * Multimedia capability with CAL, DSS7-UL, SGX544, McASP
>> * Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
>>   GPIO
>>
>> See AM65x Technical Reference Manual (SPRUID7, April 2018)
>> for further details: http://www.ti.com/lit/pdf/spruid7
>>
>> We introduce the Kconfig symbol for the SoC along with this patch since
>> it is logically relevant point, however the usage is in subsequent
>> patches.
>>
>> NOTE: AM654 is the first of the device variants, hence we introduce a
>> generic am6.dtsi.
>>
>> Signed-off-by: Benjamin Fair <b-fair@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  MAINTAINERS                          |   1 +
>>  arch/arm64/boot/dts/ti/k3-am6.dtsi   | 144 +++++++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am654.dtsi | 117 ++++++++++++++++++++++++++++
>>  drivers/soc/ti/Kconfig               |  14 ++++
>>  4 files changed, 276 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6.dtsi
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cfb35b252ac7..5f5c4eddec7a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2092,6 +2092,7 @@ M:        Nishanth Menon <nm@ti.com>
>>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:     Supported
>>  F:     Documentation/devicetree/bindings/arm/ti/k3.txt
>> +F:     arch/arm64/boot/dts/ti/k3-*
>>
>>  ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>>  M:     Santosh Shilimkar <ssantosh@kernel.org>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am6.dtsi b/arch/arm64/boot/dts/ti/k3-am6.dtsi
>> new file mode 100644
>> index 000000000000..cdfa12173aac
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am6.dtsi
>> @@ -0,0 +1,144 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree Source for AM6 SoC Family
>> + *
>> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +       model = "Texas Instruments K3 AM654 SoC";
>> +       compatible = "ti,am654";
>> +       interrupt-parent = <&gic>;
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       aliases {
>> +               serial0 = &wkup_uart0;
>> +               serial1 = &mcu_uart0;
>> +               serial2 = &main_uart0;
>> +               serial3 = &main_uart1;
>> +               serial4 = &main_uart2;
>> +       };
>> +
>> +       chosen { };
>> +
>> +       firmware {
>> +               optee {
>> +                       compatible = "linaro,optee-tz";
>> +                       method = "smc";
>> +               };
>> +
>> +               psci: psci {
>> +                       compatible = "arm,psci-1.0";
>> +                       method = "smc";
>> +               };
>> +       };
>> +
>> +       soc0: soc0 {
>> +               compatible = "simple-bus";
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
> 
> Really need 64-bit addresses and sizes? Use ranges to limit the
> address space if possible.

We now have address-cells as <1>,
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am65.dtsi#n49

However each PCIe instance has 2 data regions and one of the regions
(PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1/PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 specified
in the "MAIN Domain Memory Map" table of TRM http://www.ti.com/lit/pdf/spruid7)
is above the 32bit region and requires 2 cells to specify the start address.
This region is used to access MEM_SPACE of PCIe endpoint when operating in root
complex mode and access memory of PCI root complex when operating in endpoint mode.

In order to describe this, should we change the address-cells back to <2> or do
you suggest any other alternatives?

Thanks
Kishon
