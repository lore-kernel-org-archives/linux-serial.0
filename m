From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Tue, 19 Jan 2016 07:32:31 +0100
Message-ID: <20160119073231.19f16f28@kemnade.info>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
	<20160113191542.GA12086@leverpostej>
	<1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com>
	<20160115110106.GA3262@leverpostej>
	<69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com>
	<569913A1.80606@cogentembedded.com>
	<CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com>
	<56992959.2020204@hurleysoftware.com>
	<CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com>
	<744620565.20160116103445@cogentembedded.com>
	<20160116233157.GA7774@rob-hp-laptop>
	<3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com>
	<20160117141912.4aa2e46c@lxorguk.ukuu.org.uk>
	<1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com>
	<20160117193849.69d00c28@lxorguk.ukuu.org.uk>
	<37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com>
	<20160118111926.0882b422@lxorguk.ukuu.org.uk>
	<07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D@goldelico.com>
	<20160118220319.051c9cc0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OYnXFMivLR=1xwRbTpNqEea"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160118220319.051c9cc0@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Vostrikov Andrey <andrey.vostrikov@cogentembedded.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, NeilBrown <neil@brown.name>, Marek Belisko <marek@goldelico.com>, Jiri Slaby <jslaby@suse.cz>, tomeu@tomeuvizoso.net
List-Id: linux-serial@vger.kernel.org

--Sig_/OYnXFMivLR=1xwRbTpNqEea
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Jan 2016 22:03:19 +0000
One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> wrote:

> > > Your user space can do it (as most Android does).
> >=20
> > How can it do it in automatically in a standardized way without need fo=
r daemon support?
>=20
> You don't need to - it can be device specific. In Android it usually is.
> I've never understood why low end devices don't also abstract user space
> descriptions of power control into DT nodes as well as kernel properties ?
>=20
Well, on these android devices, they are only intended to run android and
have another abstraction layer where you can hide things.
If doing actions on opening or closing a tty should not be implemented in
kernel space, then an alternative I see would be to at least have proper
rfkill support for bluetooth and gps in kernel. Then userspace can at least
can talk to a standardised interface. So userspace just has to implement
generic things.

That would mean for the kernel drivers needed:


W2CBW003/bluetooth:
   map the rfkill to just a simple regulator

W2SG0004/gps:
   being notified about incoming data
     a) the nice way: getting it from the tty/tty_port layer
 	(but requiring changes at generic kernel code)
        or
     b) the ugly way:
        remux the data line as a gpio and simply look for state
        changes during rfkill call (probably only during unblock)
	The first characters after power on would probably be lost
        toggle a gpio depending on the desired and detected state

Regards,
Andreas

--Sig_/OYnXFMivLR=1xwRbTpNqEea
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWndjQAAoJEGGrpYhZ30HuNYUIAKnyBMwr340yNFiGbNcALLak
1/zp9u0OWq2/3fWTUrw353Gnzn+wvEfuqqSIliDqN9N9Dbr5S8oGiOcDBTreOsUT
P2CX6OZco/CpM4HPc2zDn1vLdX3BoWN8qEA97osPgJ41M5wXvctnOu1Vcl2j8MMl
y9dWGyQUS0jQ2G5Dt8dy8+gLKQmXtVnaAS6eiYgq4OqD7TeZAZq+PmG/M6AhZazL
8UJiGZpf0gr66wcRn5jQrcAm6K7aqqqfeDya9Rx3ZBkteL9/ObY6D2PC77NY8wxW
tEbPU2jpKdFUFezCZnUnpoSvmlbmqoZS+/vlg62e9mBed8tn36x2BqsLgG4769k=
=mECg
-----END PGP SIGNATURE-----

--Sig_/OYnXFMivLR=1xwRbTpNqEea--
