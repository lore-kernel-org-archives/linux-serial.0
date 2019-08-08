From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Date: Thu, 8 Aug 2019 12:47:00 +0000
Message-ID: <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190808080832.nleult5bknmzr3ze@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hello Will,=0A=
=0A=
On 8/8/2019 11:08 AM, Will Deacon wrote:=0A=
> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:=0A=
>> +             linflex,<addr>=0A=
>> +                     Use early console provided by Freescale LinFlex UA=
RT=0A=
>> +                     serial driver for NXP S32V234 SoCs. A valid base=
=0A=
>> +                     address must be provided, and the serial port must=
=0A=
>> +                     already be setup and configured.=0A=
> =0A=
> Why isn't earlycon=3D sufficient for this?=0A=
=0A=
"earlycon=3D" is not actually supported. I will fix this in the next=0A=
version by adding a /chosen/stdout-path to the dts. The compatible=0A=
string provided to OF_EARLYCON_DECLARE will also be changed from=0A=
"fsl,s32v234-linflexuart" to "fsl,s32-linflexuart" to match the one in=0A=
the device tree nodes. I missed this after importing a rename from our=0A=
codebase.=0A=
=0A=
Should I remove this addition from kernel-parameters.txt after that?=0A=
=0A=
Regards,=0A=
Stefan=0A=
