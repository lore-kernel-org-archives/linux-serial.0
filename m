From: Tomas Lastovicka <tomas.lastovicka@gmail.com>
Subject: Re: RS-485 automatic RTS toggle in Linux (on Winbond W83627UHG)
Date: Wed, 7 Dec 2011 06:58:31 -0500
Message-ID: <CAFnDbmD3GSxM8FBU-n35Ndsio0M3X6bO0=5OdDVj9b82hiwyLw@mail.gmail.com>
References: <CAFnDbmD-LG1O45d9s8GPxcbmjeFJ=vSp450oJ_75ooxBMtZFCg@mail.gmail.com>
	<20111129175728.GH5455@pengutronix.de>
	<CAFnDbmAAZZFNJAc=Y92xrkUujemTK63_2-H3TVkvbjVrsjUKgg@mail.gmail.com>
	<20111129222002.GA12314@pengutronix.de>
	<CAFnDbmA1u041X4LQv0pbdAAoR=LBqgdmOGRj_J5MhA2euMKFOw@mail.gmail.com>
	<20111129223626.GB12314@pengutronix.de>
	<CAFnDbmBN=TWzVfNhf41A441L3Fcq4u=MnkWKU7PD8LiK2UXcRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62148 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407Ab1LGL6d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Dec 2011 06:58:33 -0500
Received: by dadv6 with SMTP id v6so494483dad.19
        for <linux-serial@vger.kernel.org>; Wed, 07 Dec 2011 03:58:32 -0800 (PST)
In-Reply-To: <CAFnDbmBN=TWzVfNhf41A441L3Fcq4u=MnkWKU7PD8LiK2UXcRg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org

Hi,

to conclude this thread: the Winbond W83627UHG, used in my brand new
device, really does not support the automatic RTS toggle for the
RS-485 line. Thus the most appropriate solution appears to be the RTS
toggling from within a driver.

Cheers,
Tomas


On Tue, Nov 29, 2011 at 6:15 PM, Tomas Lastovicka
<tomas.lastovicka@gmail.com> wrote:
> Thanks for both links Wolfram! I will find out what revision i actual=
ly have.
>
> Best,
> Tomas
>
>
> On Tue, Nov 29, 2011 at 5:36 PM, Wolfram Sang <w.sang@pengutronix.de>=
 wrote:
>> On Tue, Nov 29, 2011 at 05:25:32PM -0500, Tomas Lastovicka wrote:
>>
>>> Then i definitely have a different datasheet (v1.41). No 485 matche=
s were found.
>>
>> I got v1.7:
>>
>> http://www.nuvoton.com/NuvotonMOSS/Community/ProductInfo.aspx?tp_GUI=
D=3D8310ab06-af65-4ec9-92a6-17cf791aa9f2
>>
>> Ah, it says RS485 is only available on Revision E. Hopefully, you ha=
ve that.
>>
>>> Indeed, if it has support then there is no need for software toggle
>>> (although i still think it is done this way in the Etrax driver com=
ing
>>> with the kernel).
>>
>> I think that was the first RS485 one, so probably just lucky ;)
>>
>> If you are interested, another series adding support for 8250-varian=
ts that
>> have HW support can be found here:
>>
>> http://lkml.org/lkml/2011/11/16/270
>>
>> Regards,
>>
>> =A0 Wolfram
>>
>> --
>> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
>> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://=
www.pengutronix.de/ =A0|
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
