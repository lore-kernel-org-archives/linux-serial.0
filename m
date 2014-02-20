From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 3/4] tty: serial: bcm63xx_uart: add support for DT probing
Date: Thu, 20 Feb 2014 08:18:41 -0800
Message-ID: <53062AE1.6000204@gmail.com>
References: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com> <CAGVrzcYEWJ6nKncSx3jjWFp9TXf8PFJnd-joPwSe0mDh-CeMiw@mail.gmail.com> <CAOiHx=mDYsGjtEXEK+8YUo4WZRQeXYvDJdfk2OQtqheeaD7icw@mail.gmail.com> <4709421.TpqQL1VssO@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:61887 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbaBTQSo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Feb 2014 11:18:44 -0500
In-Reply-To: <4709421.TpqQL1VssO@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jonas Gorski <jogo@openwrt.org>
Cc: linux-serial@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Maxime Bizon <mbizon@freebox.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Arnd,

Le 20/02/2014 04:16, Arnd Bergmann a =E9crit :
> On Thursday 20 February 2014 11:59:04 Jonas Gorski wrote:
>> On Thu, Feb 20, 2014 at 2:29 AM, Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>>> 2014-02-19 16:00 GMT-08:00 Jonas Gorski <jogo@openwrt.org>:
>>>> On Thu, Feb 20, 2014 at 12:22 AM, Florian Fainelli <f.fainelli@gma=
il.com> wrote:
>>>>> @@ -857,6 +861,12 @@ static int bcm_uart_remove(struct platform_d=
evice *pdev)
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> +static const struct of_device_id bcm63xx_of_match[] =3D {
>>>>> +       { .compatible =3D "brcm,bcm63xx-uart" },
>>>>
>>>>  From my understanding, this should be "brcm,bcm6345-uart", becaus=
e
>>>> this kind of uart appeared first on bcm6345 (well, maybe bcm6335, =
no
>>>> idea which one of these two was first, but the latter was never
>>>> supported in mainline anyway).
>>>
>>> That's right, in fact, I think it might be desirable to handle both
>>> compatible string, just as a hint that it is compatible with the
>>> entire bcm63xx family. Would that work for you?
>>
>> I think using a "generic" compatible string is rather frowned upon
>> (what do you do if there is eventually a bcm63xx chip with an
>> incompatible uart?), but I'm no device tree expert.
>
> It's ok to have a generic name, it's wildcards like the xx above
> that we try to avoid, since that breaks down when you get another
> device in the same SoC family that is not compatible. This is differe=
nt
> from the Linux way of naming things.
>
> brcm,bcm6345-uart sounds good, if that is the closest we can get
> to a generic name, working under the assumption that it's the oldest
> implementation of this UART. Ideally we'd find someone with access
> to the design documents of the SoC to tell us what the UART is really
> called by whoever designed it (which may not even be Broadcom).

This is just called an uart, it does not have any specific project name=
=20
as far as I could see, and BCM6345 was indeed the very first SoC using =
it.

>
> If we think there may be some level of variation between the UARTS
> in the various bcm63xx SoCs, it would be good to list both the
> specific model of the SoC as well as the generic name in "compatible"=
,
> so the driver can later detect those differences without requiring
> an updated DT.

Makes sense. So far this UART has been not modified (as far as a=20
programmer may be concerned) since its very first design in a BCM6345.

>
> A BCM63138 for instance could list this as
>
> 	compatible =3D "brcm,bcm62138-uart", "brcm-bcm6345-uart";
>
> 	Arnd
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
