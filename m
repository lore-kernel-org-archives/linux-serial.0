From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: ti: Add bindings for J721E SoC
Date: Mon, 17 Jun 2019 10:46:14 -0500
Message-ID: <20190617154614.wlbh6dtj54brkt67@kahuna>
References: <20190522161921.20750-1-nm@ti.com>
 <20190522161921.20750-2-nm@ti.com>
 <20190614164526.GA14925@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190614164526.GA14925@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-serial@vger.kernel.org

On 10:45-20190614, Rob Herring wrote:
> On Wed, May 22, 2019 at 11:19:16AM -0500, Nishanth Menon wrote:
> > The J721E SoC belongs to the K3 Multicore SoC architecture platform,
> > providing advanced system integration to enable lower system costs
> > of automotive applications such as infotainment, cluster, premium
> > Audio, Gateway, industrial and a range of broad market applications.
> > This SoC is designed around reducing the system cost by eliminating
> > the need of an external system MCU and is targeted towards ASIL-B/C
> > certification/requirements in addition to allowing complex software
> > and system use-cases.
> > 
> > Some highlights of this SoC are:
> > * Dual Cortex-A72s in a single cluster, three clusters of lockstep
> >   capable dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA),
> >   C7x floating point Vector DSP, Two C66x floating point DSPs.
> > * 3D GPU PowerVR Rogue 8XE GE8430
> > * Vision Processing Accelerator (VPAC) with image signal processor and Depth
> >   and Motion Processing Accelerator (DMPAC)
> > * Two Gigabit Industrial Communication Subsystems (ICSSG), each with dual
> >   PRUs and dual RTUs
> > * Two CSI2.0 4L RX plus one CSI2.0 4L TX, one eDP/DP, One DSI Tx, and
> >   up to two DPI interfaces.
> > * Integrated Ethernet switch supporting up to a total of 8 external ports in
> >   addition to legacy Ethernet switch of up to 2 ports.
> > * System MMU (SMMU) Version 3.0 and advanced virtualisation
> >   capabilities.
> > * Upto 4 PCIe-GEN3 controllers, 2 USB3.0 Dual-role device subsystems,
> >   16 MCANs, 12 McASP, eMMC and SD, UFS, OSPI/HyperBus memory controller, QSPI,
> >   I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
> > * Two hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
> >   management.
> > * Configurable L3 Cache and IO-coherent architecture with high data throughput
> >   capable distributed DMA architecture under NAVSS
> > * Centralized System Controller for Security, Power, and Resource
> >   Management (DMSC)
> > 
> > See J721E Technical Reference Manual (SPRUIL1, May 2019)
> > for further details: http://www.ti.com/lit/pdf/spruil1
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  Documentation/devicetree/bindings/arm/ti/k3.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Okay for now, but please convert K3 and other TI SoCs to schema soon.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>


Thanks Rob. Will do the change to rst soon (hopefully post in the 5.3 window).
-- 
Regards,
Nishanth Menon
