From: Tomas Lastovicka <tomas.lastovicka@gmail.com>
Subject: Re: RS-485 automatic RTS toggle in Linux (on Winbond W83627UHG)
Date: Tue, 29 Nov 2011 17:25:32 -0500
Message-ID: <CAFnDbmA1u041X4LQv0pbdAAoR=LBqgdmOGRj_J5MhA2euMKFOw@mail.gmail.com>
References: <CAFnDbmD-LG1O45d9s8GPxcbmjeFJ=vSp450oJ_75ooxBMtZFCg@mail.gmail.com>
	<20111129175728.GH5455@pengutronix.de>
	<CAFnDbmAAZZFNJAc=Y92xrkUujemTK63_2-H3TVkvbjVrsjUKgg@mail.gmail.com>
	<20111129222002.GA12314@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40318 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab1K2WZd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Nov 2011 17:25:33 -0500
Received: by yenl6 with SMTP id l6so4586040yen.19
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2011 14:25:33 -0800 (PST)
In-Reply-To: <20111129222002.GA12314@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org

Then i definitely have a different datasheet (v1.41). No 485 matches we=
re found.
Indeed, if it has support then there is no need for software toggle
(although i still think it is done this way in the Etrax driver coming
with the kernel).


On Tue, Nov 29, 2011 at 5:20 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>
>> Unless i have overlooked something, i do not see how to toggle the
>> automatic RTS mode from W83627UHG's datasheet. Have you found it?
>
> Yes, searching for '485' gives you all the info you need (if we got t=
he same
> datasheet).
>
>> Regarding 2.6.38+ drivers, Atmel supports RS485 on the hardware leve=
l
>> and Etrax is handling the RTS toggling directly from the driver. I
>
> Hardware level is the only official supported way in Linux. Software =
toggling
> can easily fail due to preemption.
>
>> guess this is what i will finally have to do, i.e. to toggle RTS fro=
m
>> the driver myself.
>
> Why? If the hardware has support?
>
>> I am surprised that the RTS toggling issue for RS485 in Linux is
>> around for quite a while.
>
> It has come a long way, but all you need is there now (except for sof=
tware
> based direction control, see above).
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
