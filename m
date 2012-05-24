From: Dmitriy Alekseev <alexeev6@yahoo.com>
Subject: Re: struct tty_flip_buffer replacement in newer kernels
Date: Thu, 24 May 2012 08:05:12 -0700 (PDT)
Message-ID: <1337871912.83081.YahooMailNeo@web44916.mail.sp1.yahoo.com>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com> <4FBB8742.7050504@fastmail.fm> <20120522151033.33ef577a@pyramind.ukuu.org.uk> <1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com> <20120522172700.02d7915d@pyramind.ukuu.org.uk> <1337855090.9672.YahooMailNeo@web44908.mail.sp1.yahoo.com> <1337855922.24203.YahooMailNeo@web44913.mail.sp1.yahoo.com> <20120524142219.6606e57a@pyramind.ukuu.org.uk>
Reply-To: Dmitriy Alekseev <alexeev6@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm9-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.196]:40569 "HELO
	nm9-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754055Ab2EXPFN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 May 2012 11:05:13 -0400
In-Reply-To: <20120524142219.6606e57a@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

The link I gave is original source, which I afterwards changed accordin=
g to my parameters - clock and processor memory map.

You right about offset 0x8, this is=A0offset between ports in my 68 mod=
e, I corrected, but it doesn't give any result.

=A0
Best regards,
Dmitriy Alekseev


----- Original Message -----
=46rom: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dmitriy Alekseev <alexeev6@yahoo.com>
Cc:=20
Sent: Thursday, May 24, 2012 5:22 PM
Subject: Re: struct tty_flip_buffer replacement in newer kernels

On Thu, 24 May 2012 03:38:42 -0700 (PDT)
Dmitriy Alekseev <alexeev6@yahoo.com> wrote:

> Hi, Alan.
>=20
> Thank You very much for the answer!
> So, if I understand correctly, I took for example this:=A0arch/arm/ma=
ch-omap1/board-voiceblue.c
> And made in my board specific file:
> static struct plat_serial8250_port exar_ports[] =3D {
> =A0 =A0 =A0 =A0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mapbase =A0 =A0 =A0 =A0=3D (unsigned=
 long)(0x30000300), // according to at91rm9200 CS2 memory map
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOO=
T_AUTOCONF | UPF_IOREMAP, // I don't know, what kind of flags is suitab=
le for me

That looks reasonable - UPF_IOREMAP tells the kernel to do the ioremap
for you, UPF_BOOT_AUTOCONF tries to autoconfigure the chip type

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM,=
 // similar problem
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .regshift =A0 =A0 =A0 =3D 1,=A0

And this guides the register spacing (1 =3D byte spaced, 2 =3D word spa=
ced, 3
=3D dword spaced etc)

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uartclk =A0 =A0 =A0 =A0=3D 14745600,=
 // Our chip clock frequency

UPIO_MEM is for MMIO, UPIO_PORT for port I/O

However the values don't look the same as the old driver you linked to =
-
that seems to be using 0x2800000 and then 8 byte spacing plus a 1843200
clock.

Alan

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
