From: Sven Brauch <mail@svenbrauch.de>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Thu, 23 Jul 2015 00:53:18 +0200
Message-ID: <55B01EDE.3050503@svenbrauch.de>
References: <55AC1883.4050605@svenbrauch.de>
 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>
 <1437486195.3823.13.camel@suse.com> <55AEBD06.6020402@svenbrauch.de>
 <55AED708.903@hurleysoftware.com> <55AEE805.9050204@svenbrauch.de>
 <55B01554.90201@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aHBa0c65wG0RCea0gbdNJ5cbXqNdpLoxA"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B01554.90201@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Oliver Neukum <oneukum@suse.com>, Johan Hovold <johan@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aHBa0c65wG0RCea0gbdNJ5cbXqNdpLoxA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/07/15 00:12, Peter Hurley wrote:
> The premature unthrottle actually leads to the data loss but the thrott=
ling
> with a mere 2K left is _way too late_.
Ok, yes, I think so too.

> 10ms is a _really_ long time for a cpu not to attend to a kworker.
> Which raises 2 questions:
> 1. What are the termios settings of the tty receiving input? Is it 'raw=
'
>    mode or typical terminal mode (icanon, echo, etc.) or something else=
?
In my test code, I open the tty like
  fd =3D open("/dev/ttyACM0", O_RDWR | O_NOCTTY | O_NONBLOCK);
I don't make any other changes to the default settings. To be honest,
I'm not sure in which mode it is operating then (I was assuming raw, but
I might be wrong?).

> 2. Are there RT threads that are hogging cpu time?
I can't see any, I think the only thing which occasionally goes to RT is
pulseaudio (but during at least some of the tests I wasn't even playing
audio, so that sounds very unplausible to me). I also cannot see a
correlation between failure rate and CPU load.

Best regards,
Sven


--aHBa0c65wG0RCea0gbdNJ5cbXqNdpLoxA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVsB7eAAoJEGjKjjjEuz9LRzAP/AgfCXWXfF5glUGvlfyIYT6v
gzIOJYXqPqLh/rIJlxmEbtj6YXyxS6WdfXXSxHl2KNbR5QFTNsdrqCpfwmkU8jf0
ClZ8pn+jKLV1YFrJHgqNkaSHNtQ7uK/O2rDgsqOwuMZvrZdFsmaufRYGy+dYRApE
3CO0xb028suvlmipUkLQGysRyeDsXPr8vSa4xmOcMxIKj9UWGSXGuXvXpxGdHYHl
xNLTUO7UW5IKQhnBMMr7sMfPL9hEyEiK97ELLaUd/ilQS6V4OPrZJHB64Lr4QP7M
8IORX8avyYlxcG/yrXen7npMsmSOz6F28+Mh6SBrDU1UWGUQUI7dvsb3puKWtjUX
UibYA3uu6sixTJKHj+iSRIfnuNab7azrwU28wLYNVDPZHFYxx9ofayaOnVVvQ66E
oEY405YvSR2DiNs5VXVuWi1k3wRJC+AhSVRdHOpmgnqjCiriRQPmZXtofYJ0Vhq5
P5/aHYZ1ZEq4k2lBe80sR4GJR0aDjGEGIy3iSTDQbMayDOy/AMoMUOZqn544aMMd
3ql4ADuffEJRrb1JPNhyp1xPoGHvouAkFwdYPV+SuldTwc/9j2aMsvoatjcPnnGQ
fdY7g49myxROquNWptllrdppnvms44Kml2rniRCf9ydjcbOtJJ/JhQQpNt2vlhjK
GrkThbdcLCK3984QizCI
=q8Yh
-----END PGP SIGNATURE-----

--aHBa0c65wG0RCea0gbdNJ5cbXqNdpLoxA--
