From: Tomas Lastovicka <tomas.lastovicka@gmail.com>
Subject: Re: RS-485 automatic RTS toggle in Linux (on Winbond W83627UHG)
Date: Tue, 29 Nov 2011 18:15:00 -0500
Message-ID: <CAFnDbmBN=TWzVfNhf41A441L3Fcq4u=MnkWKU7PD8LiK2UXcRg@mail.gmail.com>
References: <CAFnDbmD-LG1O45d9s8GPxcbmjeFJ=vSp450oJ_75ooxBMtZFCg@mail.gmail.com>
	<20111129175728.GH5455@pengutronix.de>
	<CAFnDbmAAZZFNJAc=Y92xrkUujemTK63_2-H3TVkvbjVrsjUKgg@mail.gmail.com>
	<20111129222002.GA12314@pengutronix.de>
	<CAFnDbmA1u041X4LQv0pbdAAoR=LBqgdmOGRj_J5MhA2euMKFOw@mail.gmail.com>
	<20111129223626.GB12314@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39840 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab1K2XPA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Nov 2011 18:15:00 -0500
Received: by pzk36 with SMTP id 36so8488751pzk.1
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2011 15:15:00 -0800 (PST)
In-Reply-To: <20111129223626.GB12314@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org

Thanks for both links Wolfram! I will find out what revision i actually=
 have.

Best,
Tomas


On Tue, Nov 29, 2011 at 5:36 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> On Tue, Nov 29, 2011 at 05:25:32PM -0500, Tomas Lastovicka wrote:
>
>> Then i definitely have a different datasheet (v1.41). No 485 matches=
 were found.
>
> I got v1.7:
>
> http://www.nuvoton.com/NuvotonMOSS/Community/ProductInfo.aspx?tp_GUID=
=3D8310ab06-af65-4ec9-92a6-17cf791aa9f2
>
> Ah, it says RS485 is only available on Revision E. Hopefully, you hav=
e that.
>
>> Indeed, if it has support then there is no need for software toggle
>> (although i still think it is done this way in the Etrax driver comi=
ng
>> with the kernel).
>
> I think that was the first RS485 one, so probably just lucky ;)
>
> If you are interested, another series adding support for 8250-variant=
s that
> have HW support can be found here:
>
> http://lkml.org/lkml/2011/11/16/270
>
> Regards,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
