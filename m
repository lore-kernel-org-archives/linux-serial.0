From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC] serial: mxs-auart: fix baud rate range
Date: Tue, 11 Aug 2015 09:14:46 +0200 (CEST)
Message-ID: <2067120832.94984.1439277287039.JavaMail.open-xchange@oxbsltgw08.schlund.de>
References: <1439208767-29152-1-git-send-email-stefan.wahren@i2se.com> <CAOMZO5CscLv+v=8QA-zchR3EeNogpwGRRARJo8qPROLwcBXTUg@mail.gmail.com> <55C8D8E7.9090103@elpromaelectronics.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C8D8E7.9090103@elpromaelectronics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elpromaelectronics.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, Juergen Beisert <jbe@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hi Janusz,

> Janusz U=C5=BCycki <j.uzycki@elpromaelectronics.com> hat am 10. Augus=
t 2015 um
> 19:01 geschrieben:
>
>
>
>
> W dniu 2015-08-10 o 14:22, Fabio Estevam pisze:
> > On Mon, Aug 10, 2015 at 9:12 AM, Stefan Wahren <stefan.wahren@i2se.=
com>
> > wrote:
> >
> >> /* set baud rate */
> >> - baud =3D uart_get_baud_rate(u, termios, old, 0, u->uartclk);
> >> + baud_min =3D u->uartclk * 32 / 0x3fffc0;
> >> + baud_max =3D u->uartclk * 32 / 0xec;
> >> + baud =3D uart_get_baud_rate(u, termios, old, baud_min, baud_max)=
;
> > Looks good. It would be nice to replace 0x3fffc0 and 0xec with defi=
nes
> > though.
>
> I agree with Fabio.

i will name them AUART_LINECTRL_BAUD_DIV_MIN and AUART_LINECTRL_BAUD_DI=
V_MAX.

>
> In addition let's look at the example for uartclk =3D 24MHz:
> baud_max =3D 3,254,237.29 =3D> will be rounded down to 3,254,237bauds=
 and it
> is OK
> baud_min =3D 183.1 =3D> will be rounded to 183 bauds. To avoid div=3D=
0x400971
> it should be 184
> so DIV_ROUND_UP() macro could be used.

Thanks for pointing out. I will fix that.

Best regards
Stefan

>
> best regards
> Janusz
>
> >
> > Regards,
> >
> > Fabio Estevam
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
