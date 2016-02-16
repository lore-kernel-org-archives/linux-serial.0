From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 09/12] arm64: dts: add the Marvell Armada 3700 family and a development board
Date: Tue, 16 Feb 2016 18:02:05 +0100
Message-ID: <87egcctwqa.fsf@free-electrons.com>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
	<1454951660-13289-10-git-send-email-gregory.clement@free-electrons.com>
	<20160216141627.78ec94bd@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160216141627.78ec94bd@xhacker> (Jisheng Zhang's message of
	"Tue, 16 Feb 2016 14:16:27 +0800")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Jisheng,
=20
 On mar., f=C3=A9vr. 16 2016, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wrote=
:

> Dear Gregory,
> On Mon, 8 Feb 2016 18:14:17 +0100 Gregory CLEMENT wrote:
>
>> Add initial dtsi files to support Marvell Armada 3700 SoC with Corte=
x-A53
>> CPUs. There are two members in this family: the Armada 3710 (Single =
CPU)
>> and the Armada 3720 (Dual CPUs).
>>=20
>> It also adds a dts file for the Marvell Armada 3720 DB board.
>>=20
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  arch/arm64/boot/dts/marvell/Makefile           |   4 +
>>  arch/arm64/boot/dts/marvell/armada-371x.dtsi   |  53 ++++++++++
>>  arch/arm64/boot/dts/marvell/armada-3720-db.dts |  86 ++++++++++++++=
++
>>  arch/arm64/boot/dts/marvell/armada-372x.dtsi   |  63 ++++++++++++
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 131 ++++++++++++++=
+++++++++++
>>  5 files changed, 337 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-371x.dtsi
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-db.dts
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-372x.dtsi
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>>=20
>> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/=
dts/marvell/Makefile
>> index 348f4db4f313..2114af8d312d 100644
>> --- a/arch/arm64/boot/dts/marvell/Makefile
>> +++ b/arch/arm64/boot/dts/marvell/Makefile
>> @@ -1,6 +1,10 @@
>> +# Berlin SoC Family
>>  dtb-$(CONFIG_ARCH_BERLIN) +=3D berlin4ct-dmp.dtb
>>  dtb-$(CONFIG_ARCH_BERLIN) +=3D berlin4ct-stb.dtb
>> =20
>> +# Mvebu SoC Family
>> +dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-db.dtb
>> +
>>  always		:=3D $(dtb-y)
>>  subdir-y	:=3D $(dts-dirs)
>>  clean-files	:=3D *.dtb
>> diff --git a/arch/arm64/boot/dts/marvell/armada-371x.dtsi b/arch/arm=
64/boot/dts/marvell/armada-371x.dtsi
>> new file mode 100644
>> index 000000000000..c9e5325b8ac3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/marvell/armada-371x.dtsi
>> @@ -0,0 +1,53 @@
>> +/*
>> + * Device Tree Include file for Marvell Armada 371x family of SoCs
>> + * (also named 88F3710)
>> + *
>> + * Copyright (C) 2016 Marvell
>
> Is it better to Add full Marvell company name, eg. Marvell Technology=
 Group Ltd.
>

Well for mvebu I also saw "Marvell International Ltd." and "Marvell
Semiconductors". So at least Marvell is the common pattern.

>> + *
>> + * Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>
> What does this mean? in copyright holder list or just author? Is it b=
etter
> to add "Author:" prefix or something else?
>
>

I don't know the subtilitis between copyright holder list and author...

> [...]
>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm=
64/boot/dts/marvell/armada-37xx.dtsi
>> new file mode 100644
>> index 000000000000..ba9df7ff2a72
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> @@ -0,0 +1,131 @@
>> +/*
>> + * Device Tree Include file for Marvell Armada 37xx family of SoCs.
>> + *
>> + * Copyright (C) 2016 Marvell
>> + *
>> + * Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> + *
>> + * This file is dual-licensed: you can use it either under the term=
s
>> + * of the GPL or the X11 license, at your option. Note that this du=
al
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License =
as
>> + *     published by the Free Software Foundation; either version 2 =
of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty =
of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentati=
on
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom t=
he
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall =
be
>> + *     included in all copies or substantial portions of the Softwa=
re.
>> + *
>> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANT=
IES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE O=
R
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +	model =3D "Marvell Armada 37xx SoC";
>> +	compatible =3D "marvell,armada3700";
>> +	interrupt-parent =3D <&gic>;
>> +	#address-cells =3D <2>;
>> +	#size-cells =3D <2>;
>> +
>> +	aliases {
>> +		serial0 =3D &uart0;
>> +	};
>> +
>> +	cpus {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +		cpu@0 {
>> +			device_type =3D "cpu";
>> +			compatible =3D "arm,cortex-a53", "arm,armv8";
>> +			reg =3D <0>;
>> +			enable-method =3D "psci";
>> +		};
>> +	};
>> +
>> +	psci {
>> +		compatible =3D "arm,psci-0.2";
>> +		method =3D "smc";
>> +	};
>> +
>> +	timer {
>> +		compatible =3D "arm,armv8-timer";
>> +		interrupts =3D <GIC_PPI 13
>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 14
>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 11
>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 10
>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +
>> +	soc {
>> +		compatible =3D "simple-bus";
>> +		#address-cells =3D <2>;
>> +		#size-cells =3D <2>;
>> +		ranges;
>> +
>> +		internal-regs {
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <1>;
>> +			compatible =3D "simple-bus";
>> +			/* 32M internal register @ 0xd000_0000 */
>> +			ranges =3D <0x0 0x0 0xd0000000 0x2000000>;
>> +
>> +			uart0: serial@12000 {
>> +				compatible =3D "marvell,armada-3700-uart";
>> +				reg =3D <0x12000 0x400>;
>> +				interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +				status =3D "disabled";
>> +			};
>> +
>> +			usb3@58000 {
>> +				compatible =3D "generic-xhci";
>> +				reg =3D <0x58000 0x4000>;
>> +				interrupts =3D <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>> +				status =3D "disabled";
>> +			};
>> +
>> +			sata@e0000 {
>> +				compatible =3D "marvell,armada-3700-ahci";
>> +				reg =3D <0xe0000 0x2000>;
>> +				interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>> +				status =3D "disabled";
>> +			};
>> +
>> +			gic: interrupt-controller@1d00000 {
>> +				compatible =3D "arm,gic-v3";
>> +				#interrupt-cells =3D <3>;
>> +				interrupt-controller;
>> +				reg =3D <0x1d00000 0x10000>, /* GICD */
>> +				      <0x1d40000 0x40000>; /* GICR */
>
> There's no GICC, GICV, GICH?

As far as I know, there is only GICD and GICR.

Gregory


>
>> +			};
>> +		};
>> +	};
>> +};
>

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
