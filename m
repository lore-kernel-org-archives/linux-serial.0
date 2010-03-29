From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Mon, 29 Mar 2010 15:06:42 +0800
Message-ID: <20100329150642.4a94e78a@feng-i7>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	<1269340170-6558-1-git-send-email-chripell@fsfe.org>
	<20100329104838.49c18075@feng-i7>
	<cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39492 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677Ab0C2HBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Mar 2010 03:01:49 -0400
In-Reply-To: <cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: christian pellegrin <chripell@fsfe.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 29 Mar 2010 14:11:15 +0800
christian pellegrin <chripell@fsfe.org> wrote:

> > I modified the code a little and run it on our HW platform, it
> > really show some sigh of life: it can boots to console (the print
> > format is not so good), I can input command and it execute
> > correctly, but very slow, I type 3 characters and it takes about 2
> > seconds to echo back on screen and start the execution, and after
> > about 1 minute, the console hang there and input stopped to work.
>=20
> never seen such a behavior. Which platform are you using? Which SPI
> driver? Do you have a low level printk (printascii) that puts output
> somewhere else so I can send you a patch with some debugging output?
> Can you log in some other way (like via network) and see if the CPU
> load is at 100% for some reason?

Hi,

Our platform is Intel Moorestown platform, and use a spi controller cor=
e
from Designware (drivers/spi/dw_*.c). I know the problem may probably b=
e
caused by my setting, but the dw_spi driver works fine with our own
3110 driver.

=46or debug method, sadly I don't get another output port yet, but if y=
ou
have some debug patch, that's great, it will help when I find another d=
ebug
output than max3110.

>=20
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max3100_sr(s, tx, &rx)=
;
> >
> > It doesn't handle received characters here? If the console is
> > printing out a bulk of message while user input some command, the
> > command may be ignored. Myself have met the same problem in our
> > driver.
> >
>=20
> yes but I think it's quite difficult to solve this problem in every
> case. Console output is massively used only on boot when the user is
> not supposed to type a lot.

It's difficult but not impossible, actually our driver checks every wor=
d
read back and handle it if it contains a valid data

>=20
> >> + =C2=A0 =C2=A0 if (next !=3D s->console_tail) {
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->console_buf[next] =3D=
 ch;
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->console_head =3D ne=
xt;
> >> + =C2=A0 =C2=A0 }
> >
> > Also I saw max3100_sr() uses cpu_to_be16() and be16_to_cpu(), is it
> > really necessary, our platform is little-endian(x86), and I have to
> > disable them to make the code work. Is your test platform
> > big-endian?
> >
>=20
> Have you configured your SPI controller as LSB first somehow, haven't
> you? BTW my platform is a quite usual ARM9 S3C2440 which is little
> endian.
>
yeah, you hit the point that our spi controller is LSB naturally (not
configured to), here may need a check for whether to do a swap

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
