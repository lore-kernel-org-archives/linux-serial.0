From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: regression: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
 drops data
Date: Wed, 20 Apr 2016 09:48:10 -0700
Message-ID: <5717B2CA.3020206@gmail.com>
References: <5716BDF1.1010407@gmail.com> <EEBBF78A-33BB-4ACD-8CBF-285E1149FB9F@gmail.com>
Reply-To: frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EEBBF78A-33BB-4ACD-8CBF-285E1149FB9F-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivan Ivanov <iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, jslaby-IBi9RG/b67k@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 4/19/2016 11:07 PM, Ivan Ivanov wrote:
>=20
>> On Apr 20, 2016, at 02:23, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
>>
>> Hi Ivan,
>>
>> It appears that I have found a regression caused by
>> 3a878c430fd6 ("tty: serial: msm: Add TX DMA support").
>>
>> When I cat a file slightly larger than 126000 bytes on
>> the console, viewed via minicom connected to the serial
>> port, I am losing random chunks of data, almost always
>> three bytes in length.  I have also seen a lost chunk
>> of two bytes.
>>
>> I am using the 8074 dragonboard, with the dts of
>> arch/arm/boot/dts/qcom-apq8074-dragonboard.dts.
>> The dts node is serial@f991e000, which has a
>> compatible of "qcom,msm-uartdm-v1.4", so is_uartdm
>> should be UARTDM_1P4.
>=20
> I don=E2=80=99t remember what was biggest chunk, which DMA
> could carry, sorry. Are you using DMA or just PIO?=20
> Is this happening only with cat and terminal or even
> when you send data in other means. I believe that=20
> people from Linaro could help you better.

I assumed you would be the person who would have the
information and would be able to help maintain the
code in question since you submitted this not small
patch.  Do you have a pointer to the hardware
documentation of the DMA and uart?  Who at Linaro
are you suggesting?

Thanks for the questions, I'll look into them today.

One more observation that may provide an insight:
if I cat a file multiple times, the location of
the dropped chunks varies.

In further testing I also found examples of single
bytes lost.

Thanks,

=46rank

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
