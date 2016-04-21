From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: regression: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
 drops data
Date: Thu, 21 Apr 2016 23:42:32 +0300
Message-ID: <CAHp75Vdu6+qLHe9tTK5BE3ec5Mvz5Z0e4DvLc8ewjjVbSs-BdQ@mail.gmail.com>
References: <5716BDF1.1010407@gmail.com>
	<EEBBF78A-33BB-4ACD-8CBF-285E1149FB9F@gmail.com>
	<5717B2CA.3020206@gmail.com>
	<57182635.5070606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57182635.5070606@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc: Ivan Ivanov <iivanov.xz@gmail.com>, Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, srinivas.kandagatla@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 21, 2016 at 4:00 AM, Frank Rowand <frowand.list@gmail.com> =
wrote:
> On 4/20/2016 9:48 AM, Frank Rowand wrote:
>> On 4/19/2016 11:07 PM, Ivan Ivanov wrote:
>>>
>>>> On Apr 20, 2016, at 02:23, Frank Rowand <frowand.list@gmail.com> w=
rote:
>>>>
>>>> Hi Ivan,
>>>>
>>>> It appears that I have found a regression caused by
>>>> 3a878c430fd6 ("tty: serial: msm: Add TX DMA support").
>>>>
>>>> When I cat a file slightly larger than 126000 bytes on
>>>> the console, viewed via minicom connected to the serial
>>>> port, I am losing random chunks of data, almost always
>>>> three bytes in length.  I have also seen a lost chunk
>>>> of two bytes.
>>>>
>>>> I am using the 8074 dragonboard, with the dts of
>>>> arch/arm/boot/dts/qcom-apq8074-dragonboard.dts.
>>>> The dts node is serial@f991e000, which has a
>>>> compatible of "qcom,msm-uartdm-v1.4", so is_uartdm
>>>> should be UARTDM_1P4.
>>>
>>> I don=E2=80=99t remember what was biggest chunk, which DMA
>>> could carry, sorry. Are you using DMA or just PIO?
>>> Is this happening only with cat and terminal or even
>>> when you send data in other means. I believe that
>>> people from Linaro could help you better.
>>
>> I assumed you would be the person who would have the
>> information and would be able to help maintain the
>> code in question since you submitted this not small
>> patch.  Do you have a pointer to the hardware
>> documentation of the DMA and uart?  Who at Linaro
>> are you suggesting?
>>
>> Thanks for the questions, I'll look into them today.
>
> I switched from cat to several variations of dd and on
> the host side I tried using programs other than minicom.
>
> My symptoms have now changed to something else that I
> have seen in the past, but I am now suspicious of my
> environment.  I'll reset and do some more tests.
>
> I'm not sure if the driver was in DMA or PIO mode, both
> before the change and after.  This seems like a rather
> important question to answer, so I'll try to verify
> that tonight.
>
>>
>> One more observation that may provide an insight:
>> if I cat a file multiple times, the location of
>> the dropped chunks varies.
>>
>> In further testing I also found examples of single
>> bytes lost.

[Shrink and reshuffle Cc list a bit to leave UART related people mostly=
=2E]

There are currently issues with DMA and UART on some platforms.
Besides that Peter noticed the problem with latency how DMA tasklets
are handled.

I could add that for testing (and better user experience) we are
starving for fix to disable / enable DMA support runtime. Heikki or me
might help with that when we have a bit more time.

--=20
With Best Regards,
Andy Shevchenko
