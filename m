From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] serial: samsung: fix device name
Date: Fri, 6 Aug 2010 15:26:04 +0900
Message-ID: <AANLkTikrhuey00vC3aUmNEViuEvMNMdhZfGQ4--vnsuj@mail.gmail.com>
References: <20100805201000.14030.34703.stgit@darius-desktop>
	<AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
	<4C5BA810.3030205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54624 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab0HFG0H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Aug 2010 02:26:07 -0400
Received: by wyb39 with SMTP id 39so7429925wyb.19
        for <linux-serial@vger.kernel.org>; Thu, 05 Aug 2010 23:26:04 -0700 (PDT)
In-Reply-To: <4C5BA810.3030205@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darius Augulis <augulis.darius@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-serial@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

On Fri, Aug 6, 2010 at 3:13 PM, Darius Augulis <augulis.darius@gmail.co=
m> wrote:
> On 08/06/2010 03:04 AM, Kyungmin Park wrote:
>>
>> Hi,
>>
>> It's already posted by Mr. Shim
>> http://marc.info/?l=3Dlinux-arm-kernel&m=3D127410047306149&w=3D2
>>
>> As discussed with Ben. even though it's right patch, there's some
>> users to use previous interface.
>> I also think it will be fixed. but need to coordinate with existing =
users.
>>
>
> IMHO, it must be fixed. It's very annoying bug and I spend few hours =
trying
> to understand why kernel with devtmpfs auto-mount option doesn't prov=
ide
> ttySAC0, because when grep'ing 'grep -R ttySAC0 drivers/serial/*
> it's found in samsung driver and I thought everything should be o.k. =
Who
> could imagine that it's driver name, not device?...
> Regarding old users, they should not use such strange device name in =
their
> configs, they have to sync with main line.

Absolutely agree.

>
>> Ben, how to you think?
>>
>> On Fri, Aug 6, 2010 at 5:10 AM, Darius Augulis<augulis.darius@gmail.=
com>
>> =A0wrote:
>>>
>>> Swap device and driver names in serial/samsung.c
>>>
>>> Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
>>> ---
>>> =A0drivers/serial/samsung.c | =A0 =A04 ++--
>>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
>>> index a9d6c56..9d63f24 100644
>>> --- a/drivers/serial/samsung.c
>>> +++ b/drivers/serial/samsung.c
>>> @@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops =3D=
 {
>>>
>>> =A0static struct uart_driver s3c24xx_uart_drv =3D {
>>> =A0 =A0 =A0 =A0.owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>>> - =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D "s3c2410_serial",
>>> + =A0 =A0 =A0 .driver_name =A0 =A0=3D "s3c2410_serial",
>>> =A0 =A0 =A0 =A0.nr =A0 =A0 =A0 =A0 =A0 =A0 =3D CONFIG_SERIAL_SAMSUN=
G_UARTS,
>>> =A0 =A0 =A0 =A0.cons =A0 =A0 =A0 =A0 =A0 =3D S3C24XX_SERIAL_CONSOLE=
,
>>> - =A0 =A0 =A0 .driver_name =A0 =A0=3D S3C24XX_SERIAL_NAME,
>>> + =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D S3C24XX_SERIAL_NAME,
>>> =A0 =A0 =A0 =A0.major =A0 =A0 =A0 =A0 =A0=3D S3C24XX_SERIAL_MAJOR,
>>> =A0 =A0 =A0 =A0.minor =A0 =A0 =A0 =A0 =A0=3D S3C24XX_SERIAL_MINOR,
>>> =A0};
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-seri=
al" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
