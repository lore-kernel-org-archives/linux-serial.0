From: Ivan Ivanov <iivanov.xz@gmail.com>
Subject: Re: regression: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support") drops data
Date: Wed, 20 Apr 2016 09:07:19 +0300
Message-ID: <EEBBF78A-33BB-4ACD-8CBF-285E1149FB9F@gmail.com>
References: <5716BDF1.1010407@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <5716BDF1.1010407@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: frowand.list@gmail.com
Cc: Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, srinivas.kandagatla@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


> On Apr 20, 2016, at 02:23, Frank Rowand <frowand.list@gmail.com> wrot=
e:
>=20
> Hi Ivan,
>=20
> It appears that I have found a regression caused by
> 3a878c430fd6 ("tty: serial: msm: Add TX DMA support").
>=20
> When I cat a file slightly larger than 126000 bytes on
> the console, viewed via minicom connected to the serial
> port, I am losing random chunks of data, almost always
> three bytes in length.  I have also seen a lost chunk
> of two bytes.
>=20
> I am using the 8074 dragonboard, with the dts of
> arch/arm/boot/dts/qcom-apq8074-dragonboard.dts.
> The dts node is serial@f991e000, which has a
> compatible of "qcom,msm-uartdm-v1.4", so is_uartdm
> should be UARTDM_1P4.

I don=E2=80=99t remember what was biggest chunk, which DMA
could carry, sorry. Are you using DMA or just PIO?=20
Is this happening only with cat and terminal or even
when you send data in other means. I believe that=20
people from Linaro could help you better.

Regards,
Ivan--
To unsubscribe from this list: send the line "unsubscribe linux-arm-msm=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
