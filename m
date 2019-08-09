From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Date: Fri, 9 Aug 2019 09:57:11 +0000
Message-ID: <VI1PR0402MB2863475AD0326DA86594427EDFD60@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190808080832.nleult5bknmzr3ze@willie-the-truck>
 <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
 <20190808171711.nk7ljqkugtketu4q@willie-the-truck>
 <VI1PR0402MB2863B3E3E2F93CBA8ADB96E5DFD60@VI1PR0402MB2863.eurprd04.prod.outlook.com>
 <20190809095338.d73fomq424gayf2b@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

On 8/9/2019 12:53 PM, Will Deacon wrote:=0A=
> On Fri, Aug 09, 2019 at 09:45:40AM +0000, Stefan-gabriel Mirea wrote:=0A=
>> On 8/8/2019 8:17 PM, Will Deacon wrote:=0A=
>>> On Thu, Aug 08, 2019 at 12:47:00PM +0000, Stefan-gabriel Mirea wrote:=
=0A=
>>>> On 8/8/2019 11:08 AM, Will Deacon wrote:=0A=
>>>>> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:=
=0A=
>>>>>> +             linflex,<addr>=0A=
>>>>>> +                     Use early console provided by Freescale LinFle=
x UART=0A=
>>>>>> +                     serial driver for NXP S32V234 SoCs. A valid ba=
se=0A=
>>>>>> +                     address must be provided, and the serial port =
must=0A=
>>>>>> +                     already be setup and configured.=0A=
>>>>>=0A=
>>>>> Why isn't earlycon=3D sufficient for this?=0A=
>>>>=0A=
>>>> "earlycon=3D" is not actually supported. I will fix this in the next=
=0A=
>>>> version by adding a /chosen/stdout-path to the dts. The compatible=0A=
>>>> string provided to OF_EARLYCON_DECLARE will also be changed from=0A=
>>>> "fsl,s32v234-linflexuart" to "fsl,s32-linflexuart" to match the one in=
=0A=
>>>> the device tree nodes. I missed this after importing a rename from our=
=0A=
>>>> codebase.=0A=
>>>>=0A=
>>>> Should I remove this addition from kernel-parameters.txt after that?=
=0A=
>>>=0A=
>>> Yes, if you can use earlycon instead, then you can drop your custom opt=
ion=0A=
>>> entirely and therefore there's no need to document it either.=0A=
>>=0A=
>> Can you please clarify what you mean by "drop your custom option"? The=
=0A=
>> "linflex" option documented in the paragraph is the name of the=0A=
>> earlycon_id declared via "OF_EARLYCON_DECLARE(linflex, ...)". We have=0A=
>> not done anything particular to accept it in the parameter value.=0A=
> =0A=
> My apologies, I completely misread your patch and thought your were addin=
g=0A=
> a *new* kernel parameter. Having looked at the context, I now see you're=
=0A=
> adding a new earlycon option, which is what I was suggesting :)=0A=
> =0A=
> By all means, please update the stdout-path, because then you can just pa=
ss=0A=
> "earlycon" and things will work as expected.=0A=
=0A=
No problem, I will submit the new version soon. Thank you!=0A=
=0A=
Regards,=0A=
Stefan=0A=
