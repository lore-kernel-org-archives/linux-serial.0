From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 3/6] arm64: dts: ti: Add Support for J721E SoC
Date: Tue, 18 Jun 2019 17:38:51 +0300
Message-ID: <665a246b-53ec-b10d-5fbb-840e950977a7@ti.com>
References: <20190522161921.20750-1-nm@ti.com>
 <20190522161921.20750-4-nm@ti.com>
 <a786a889-7414-8cb9-7618-67fa1adf705d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a786a889-7414-8cb9-7618-67fa1adf705d@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
List-Id: linux-serial@vger.kernel.org

On 07/06/2019 23:58, Suman Anna wrote:
> Hi Nishanth, Tero,
> 
> On 5/22/19 11:19 AM, Nishanth Menon wrote:
>> The J721E SoC belongs to the K3 Multicore SoC architecture platform,
>> providing advanced system integration to enable lower system costs
>> of automotive applications such as infotainment, cluster, premium
>> Audio, Gateway, industrial and a range of broad market applications.
>> This SoC is designed around reducing the system cost by eliminating
>> the need of an external system MCU and is targeted towards ASIL-B/C
>> certification/requirements in addition to allowing complex software
>> and system use-cases.
>>
>> Some highlights of this SoC are:
>> * Dual Cortex-A72s in a single cluster, three clusters of lockstep
>>    capable dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA),
>>    C7x floating point Vector DSP, Two C66x floating point DSPs.
>> * 3D GPU PowerVR Rogue 8XE GE8430
>> * Vision Processing Accelerator (VPAC) with image signal processor and Depth
>>    and Motion Processing Accelerator (DMPAC)
>> * Two Gigabit Industrial Communication Subsystems (ICSSG), each with dual
>>    PRUs and dual RTUs
>> * Two CSI2.0 4L RX plus one CSI2.0 4L TX, one eDP/DP, One DSI Tx, and
>>    up to two DPI interfaces.
>> * Integrated Ethernet switch supporting up to a total of 8 external ports in
>>    addition to legacy Ethernet switch of up to 2 ports.
>> * System MMU (SMMU) Version 3.0 and advanced virtualisation
>>    capabilities.
>> * Upto 4 PCIe-GEN3 controllers, 2 USB3.0 Dual-role device subsystems,
>>    16 MCANs, 12 McASP, eMMC and SD, UFS, OSPI/HyperBus memory controller, QSPI,
>>    I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
>> * Two hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
>>    management.
>> * Configurable L3 Cache and IO-coherent architecture with high data throughput
>>    capable distributed DMA architecture under NAVSS
>> * Centralized System Controller for Security, Power, and Resource
>>    Management (DMSC)
>>
>> See J721E Technical Reference Manual (SPRUIL1, May 2019)
>> for further details: http://www.ti.com/lit/pdf/spruil1
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 202 ++++++++++++++++++
>>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  72 +++++++
>>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          | 176 +++++++++++++++
>>   3 files changed, 450 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e.dtsi
>>

<snip>

>> +			 /* MCUSS_WKUP Range */
>> +			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
>> +			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
>> +			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
>> +			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
>> +			 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
>> +			 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>,
>> +			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
>> +			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
>> +			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
>> +			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
>> +			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
>> +			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00800000>,
> 
> minor nit, can we have this MSMC RAM range line moved to before the
> MCUSS_WKUP comment since it doesn't belong to the MCUSS range. Perhaps
> can be fixed up while applying the patch.
> 
> Other than that, everything looks good.
> 
> Reviewed-by: Suman Anna <s-anna@ti.com>

Fixed this issue also locally, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
