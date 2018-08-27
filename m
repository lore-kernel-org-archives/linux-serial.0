From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
Date: Mon, 27 Aug 2018 08:32:21 +0530
Message-ID: <40cecb47-bd32-04aa-b7cd-ff16c1eb28f3@ti.com>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <454c277e-8a63-81cb-b341-a50f4e25cbea@ti.com>
 <20180820143153.GD7523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820143153.GD7523@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <linux@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-serial@vger.kernel.org

Hi Tony,

On Monday 20 August 2018 08:01 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [180808 06:35]:
>> On Tuesday 05 June 2018 07:35 PM, Rob Herring wrote:
>>> Really need 64-bit addresses and sizes? Use ranges to limit the
>>> address space if possible.
>>
>> We now have address-cells as <1>,
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am65.dtsi#n49
>>
>> However each PCIe instance has 2 data regions and one of the regions
>> (PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1/PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 specified
>> in the "MAIN Domain Memory Map" table of TRM http://www.ti.com/lit/pdf/spruid7)
>> is above the 32bit region and requires 2 cells to specify the start address.
>> This region is used to access MEM_SPACE of PCIe endpoint when operating in root
>> complex mode and access memory of PCI root complex when operating in endpoint mode.
>>
>> In order to describe this, should we change the address-cells back to <2> or do
>> you suggest any other alternatives?
> 
> It's probably best to have the top level cbass interconnect use
> #size-cells = <2> and then have it's child interconnects have
> #size-cells = <1> if they don't need ranges above 4GB.

PCIe has a region starting at 0x40_00000000 and size 4GB. We need 2 address
cells and 2 size cells to describe this no?
> 
> BTW, what's the difference between all these three similar PCIE
> ranges?
> 
> PCIE0_CORE_CORE_DAT_SLV_PCIE_CORE 0x0005500000 0x0005600000 1 MB
> PCIE1_CORE_CORE_DAT_SLV_PCIE_CORE 0x0005600000 0x0005700000 1 MB

This is the register space for the two instances of PCIe controller.
> 
> PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT0 0x0010000000 0x0018000000 128 MB
> PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT0 0x0018000000 0x0020000000 128 MB
> 
> PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1 0x4000000000 0x4100000000 4 GB
> PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 0x4100000000 0x4200000000 4 GB

The above are regions which can be used by CPU/DMA to access the PCIe address
space. The mapping from the above regions to the PCIe address space will be
programmed in the PCIe controller.

Thanks
Kishon
