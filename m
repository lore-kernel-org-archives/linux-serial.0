From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 3/6] arm64: dts: ti: Add Support for J721E SoC
Date: Tue, 18 Jun 2019 17:37:55 +0300
Message-ID: <327b6685-40fd-7333-e78e-af215f2d432b@ti.com>
References: <20190522161921.20750-1-nm@ti.com>
 <20190522161921.20750-4-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190522161921.20750-4-nm@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 22/05/2019 19:19, Nishanth Menon wrote:
> The J721E SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration to enable lower system costs
> of automotive applications such as infotainment, cluster, premium
> Audio, Gateway, industrial and a range of broad market applications.
> This SoC is designed around reducing the system cost by eliminating
> the need of an external system MCU and is targeted towards ASIL-B/C
> certification/requirements in addition to allowing complex software
> and system use-cases.
> 
> Some highlights of this SoC are:
> * Dual Cortex-A72s in a single cluster, three clusters of lockstep
>    capable dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA),
>    C7x floating point Vector DSP, Two C66x floating point DSPs.
> * 3D GPU PowerVR Rogue 8XE GE8430
> * Vision Processing Accelerator (VPAC) with image signal processor and Depth
>    and Motion Processing Accelerator (DMPAC)
> * Two Gigabit Industrial Communication Subsystems (ICSSG), each with dual
>    PRUs and dual RTUs
> * Two CSI2.0 4L RX plus one CSI2.0 4L TX, one eDP/DP, One DSI Tx, and
>    up to two DPI interfaces.
> * Integrated Ethernet switch supporting up to a total of 8 external ports in
>    addition to legacy Ethernet switch of up to 2 ports.
> * System MMU (SMMU) Version 3.0 and advanced virtualisation
>    capabilities.
> * Upto 4 PCIe-GEN3 controllers, 2 USB3.0 Dual-role device subsystems,
>    16 MCANs, 12 McASP, eMMC and SD, UFS, OSPI/HyperBus memory controller, QSPI,
>    I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
> * Two hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
>    management.
> * Configurable L3 Cache and IO-coherent architecture with high data throughput
>    capable distributed DMA architecture under NAVSS
> * Centralized System Controller for Security, Power, and Resource
>    Management (DMSC)
> 
> See J721E Technical Reference Manual (SPRUIL1, May 2019)
> for further details: http://www.ti.com/lit/pdf/spruil1
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 202 ++++++++++++++++++
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  72 +++++++
>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          | 176 +++++++++++++++
>   3 files changed, 450 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> new file mode 100644
> index 000000000000..d42912044a5d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi

<snip>

> +&cbass_mcu_wakeup {
> +	dmsc: dmsc@44083000 {
> +		compatible = "ti,k2g-sci";
> +		ti,host-id = <12>;
> +
> +		mbox-names = "rx", "tx";
> +
> +		mboxes= <&secure_proxy_main 11>,
> +			<&secure_proxy_main 13>;
> +
> +		reg-names = "debug_messages";
> +		reg = <0x00 0x44083000 0x0 0x1000>;
> +
> +		k3_pds: power-controller {
> +			compatible = "ti,sci-pm-domain";
> +			#power-domain-cells = <1>;
> +		};
> +
> +		k3_clks: clocks {
> +			compatible = "ti,k2g-sci-clk";
> +			#clock-cells = <2>;
> +			ti,scan-clocks-from-dt;

ti,scan-clocks-from-dt is an invalid DT property, it was NAK:ed a while 
back. The same functionality is now going to be used by default, so the 
property is not needed anyway.

Fixed this locally by dropping the property.

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
