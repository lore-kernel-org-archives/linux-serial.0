From: Tomas Lastovicka <tomas.lastovicka@gmail.com>
Subject: Re: RS-485 automatic RTS toggle in Linux (on Winbond W83627UHG)
Date: Tue, 29 Nov 2011 17:13:02 -0500
Message-ID: <CAFnDbmAAZZFNJAc=Y92xrkUujemTK63_2-H3TVkvbjVrsjUKgg@mail.gmail.com>
References: <CAFnDbmD-LG1O45d9s8GPxcbmjeFJ=vSp450oJ_75ooxBMtZFCg@mail.gmail.com>
	<20111129175728.GH5455@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:48299 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab1K2WNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Nov 2011 17:13:04 -0500
Received: by pzk36 with SMTP id 36so8410662pzk.1
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2011 14:13:03 -0800 (PST)
In-Reply-To: <20111129175728.GH5455@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>

Unless i have overlooked something, i do not see how to toggle the
automatic RTS mode from W83627UHG's datasheet. Have you found it?

Regarding 2.6.38+ drivers, Atmel supports RS485 on the hardware level
and Etrax is handling the RTS toggling directly from the driver. I
guess this is what i will finally have to do, i.e. to toggle RTS from
the driver myself.

I am surprised that the RTS toggling issue for RS485 in Linux is
around for quite a while.

Cheers,

Tomas


On Tue, Nov 29, 2011 at 12:57 PM, Wolfram Sang <w.sang@pengutronix.de> =
wrote:
>> supported. Googling this issue around, i found a couple of suggestio=
ns
>> but no solution (except drivers for Atmel and Etrax since kernel
>> 2.6.38).
>
> Judging from the datasheet, the device can do hardware based RS485,
> nice. So look at those drivers you mentioned above how they handle th=
e
> RS485-related IOCTLs and adapt the bits for the hardware configuratio=
n.
> Should be more fun with a newer kernel, but I think it is doable.
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
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk7VHQgACgkQD27XaX1/VRsO2wCfXOsvPoOtw8QV8YzkKHocp6K8
> lYEAnR/OExYTbdEtEqT8Dgl3Y/TCra83
> =3D0ZuI
> -----END PGP SIGNATURE-----
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
