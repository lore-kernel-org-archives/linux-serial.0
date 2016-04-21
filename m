From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: regression: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
 drops data
Date: Wed, 20 Apr 2016 18:00:37 -0700
Message-ID: <57182635.5070606@gmail.com>
References: <5716BDF1.1010407@gmail.com> <EEBBF78A-33BB-4ACD-8CBF-285E1149FB9F@gmail.com> <5717B2CA.3020206@gmail.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5717B2CA.3020206@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Ivanov <iivanov.xz@gmail.com>
Cc: Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, srinivas.kandagatla@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 4/20/2016 9:48 AM, Frank Rowand wrote:
> On 4/19/2016 11:07 PM, Ivan Ivanov wrote:
>>
>>> On Apr 20, 2016, at 02:23, Frank Rowand <frowand.list@gmail.com> wr=
ote:
>>>
>>> Hi Ivan,
>>>
>>> It appears that I have found a regression caused by
>>> 3a878c430fd6 ("tty: serial: msm: Add TX DMA support").
>>>
>>> When I cat a file slightly larger than 126000 bytes on
>>> the console, viewed via minicom connected to the serial
>>> port, I am losing random chunks of data, almost always
>>> three bytes in length.  I have also seen a lost chunk
>>> of two bytes.
>>>
>>> I am using the 8074 dragonboard, with the dts of
>>> arch/arm/boot/dts/qcom-apq8074-dragonboard.dts.
>>> The dts node is serial@f991e000, which has a
>>> compatible of "qcom,msm-uartdm-v1.4", so is_uartdm
>>> should be UARTDM_1P4.
>>
>> I don=E2=80=99t remember what was biggest chunk, which DMA
>> could carry, sorry. Are you using DMA or just PIO?=20
>> Is this happening only with cat and terminal or even
>> when you send data in other means. I believe that=20
>> people from Linaro could help you better.
>=20
> I assumed you would be the person who would have the
> information and would be able to help maintain the
> code in question since you submitted this not small
> patch.  Do you have a pointer to the hardware
> documentation of the DMA and uart?  Who at Linaro
> are you suggesting?
>=20
> Thanks for the questions, I'll look into them today.

I switched from cat to several variations of dd and on
the host side I tried using programs other than minicom.

My symptoms have now changed to something else that I
have seen in the past, but I am now suspicious of my
environment.  I'll reset and do some more tests.

I'm not sure if the driver was in DMA or PIO mode, both
before the change and after.  This seems like a rather
important question to answer, so I'll try to verify
that tonight.

>=20
> One more observation that may provide an insight:
> if I cat a file multiple times, the location of
> the dropped chunks varies.
>=20
> In further testing I also found examples of single
> bytes lost.
>=20
> Thanks,
>=20
> Frank
>=20
>=20
