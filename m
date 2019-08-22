From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: serial: Document Freescale LINFlex
 UART
Date: Thu, 22 Aug 2019 17:41:07 +0000
Message-ID: <VI1PR0402MB28638ABB58605D7D2ADBA852DFA50@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
 <20190809112853.15846-5-stefan-gabriel.mirea@nxp.com>
 <20190821211841.GA16627@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hello Rob,=0A=
=0A=
Thank you for the review.=0A=
=0A=
On 8/22/2019 12:18 AM, Rob Herring wrote:=0A=
> On Fri, Aug 09, 2019 at 11:29:14AM +0000, Stefan-gabriel Mirea wrote:=0A=
>> +* Freescale Linflex UART=0A=
> =0A=
> Be consistent with the name: LINFlexD?=0A=
=0A=
This was also brought up in our internal review. However, the reference=0A=
manual is also inconsistent, using LINFlexD, LINflexD, LinFlexD,=0A=
LINFlex, LINFLEX, LinFlex and Linflex. I will switch to 'LINFlexD'=0A=
everywhere, though.=0A=
=0A=
>> +The LINFlexD controller implements several LIN protocol versions, as we=
ll as=0A=
>> +support for full-duplex UART communication through 8-bit and 9-bit fram=
es. The=0A=
>> +Linflex UART driver enables operation only in UART mode.=0A=
> =0A=
> What the driver supports or not is independent of the binding.=0A=
=0A=
Ok, I will remove the last sentence ("The Linflex UART driver enables=0A=
operation only in UART mode").=0A=
=0A=
>> +  - "fsl,s32-linflexuart" for linflex configured in uart mode which=0A=
> =0A=
> LINFlexD?=0A=
=0A=
Will fix; I agree that the all lowercase version has no occurrence in=0A=
the reference manual.=0A=
=0A=
>> +  is compatible with the one integrated on S32V234 SoC=0A=
> =0A=
> Compatibles should be SoC specific. Is 's32' specific enough to account=
=0A=
> for any differences or future bugs found?=0A=
=0A=
It is probably not. I will change it to "fsl,s32v234-linflexuart" (as=0A=
well as in the device tree and driver).=0A=
=0A=
>> +Example:=0A=
>> +uart0:serial@40053000 {=0A=
> =0A=
> space    ^=0A=
> =0A=
>> +     compatible =3D "fsl,s32-linflexuart";=0A=
>> +     reg =3D <0x0 0x40053000 0x0 0x1000>;=0A=
>> +     interrupts =3D <0 59 4>;=0A=
>> +     status =3D "disabled";=0A=
> =0A=
> Don't show status in examples.=0A=
=0A=
Will fix these too.=0A=
=0A=
Regards,=0A=
Stefan=0A=
