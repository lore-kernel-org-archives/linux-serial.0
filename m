From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: fsl: Add device tree for S32V234-EVB
Date: Tue, 20 Aug 2019 16:38:34 +0000
Message-ID: <VI1PR0402MB28634C3AEDC11B2CE0C4DE43DFAB0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
 <20190809112853.15846-4-stefan-gabriel.mirea@nxp.com>
 <20190819085816.GI5999@X250>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Dan Nica <dan.nica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@n>
List-Id: linux-serial@vger.kernel.org

Hello Shawn,=0A=
=0A=
Thank you for your suggestions!=0A=
=0A=
On 8/19/2019 11:58 AM, Shawn Guo wrote:=0A=
> On Fri, Aug 09, 2019 at 11:29:12AM +0000, Stefan-gabriel Mirea wrote:=0A=
>>  .../boot/dts/freescale/fsl-s32v234-evb.dts    |  24 ++++=0A=
> =0A=
> The 'fsl-' prefix can be saved here, so that we can distinguish three=0A=
> families by starting string: imx??? for i.MX, fsl-??? for LayerScape,=0A=
> and s32??? for S32.=0A=
=0A=
All right, I will remove the prefixes.=0A=
=0A=
>> +     model =3D "Freescale S32V234";=0A=
> =0A=
> The 'model' is usually used in board level DTS to describe the board.=0A=
=0A=
I will delete the 'model' property from fsl-s32v234.dtsi and add a=0A=
suitable one in fsl-s32v234-evb.dts.=0A=
=0A=
>> +             };=0A=
> =0A=
> Please have a newline between nodes.=0A=
> =0A=
>> +             cpu1: cpu@1 {=0A=
=0A=
I've got it.=0A=
=0A=
>> +                             interrupts =3D <0 59 1>;=0A=
> =0A=
> Please use GIC_SPI and IRQ_TYPE_xxx defines to make it more readable.=0A=
=0A=
I will use GIC_SPI/GIC_PPI and IRQ_TYPE_xxx/GIC_CPU_MASK_xxx where=0A=
applicable.=0A=
=0A=
>> +=0A=
>> +     timer {=0A=
>> +             compatible =3D "arm,armv8-timer";=0A=
>> +             interrupts =3D <1 13 0xf08>,=0A=
>> +                          <1 14 0xf08>,=0A=
>> +                          <1 11 0xf08>,=0A=
>> +                          <1 10 0xf08>;=0A=
>> +             /* clock-frequency might be modified by u-boot, depending =
on the=0A=
>> +              * chip version.=0A=
>> +              */=0A=
>> +             clock-frequency =3D <10000000>;=0A=
>> +     };=0A=
>> +=0A=
>> +     gic: interrupt-controller@7d001000 {=0A=
>> +             compatible =3D "arm,cortex-a15-gic", "arm,cortex-a9-gic";=
=0A=
>> +             #interrupt-cells =3D <3>;=0A=
>> +             #address-cells =3D <0>;=0A=
>> +             interrupt-controller;=0A=
>> +             reg =3D <0 0x7d001000 0 0x1000>,=0A=
>> +                   <0 0x7d002000 0 0x2000>,=0A=
>> +                   <0 0x7d004000 0 0x2000>,=0A=
>> +                   <0 0x7d006000 0 0x2000>;=0A=
>> +             interrupts =3D <1 9 0xf04>;=0A=
>> +     };=0A=
> =0A=
> We usually put these core platform devices prior to 'soc' node.=0A=
=0A=
Sure, I will move the 'timer' and 'interrupt-controller' nodes right=0A=
before 'soc'.=0A=
=0A=
Regards,=0A=
Stefan=0A=
