From: Sven Brauch <mail@svenbrauch.de>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Mon, 20 Jul 2015 20:07:33 +0200
Message-ID: <55AD38E5.1090807@svenbrauch.de>
References: <55AC1883.4050605@svenbrauch.de>
 <20150720172546.GF20628@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C4E2ImN98bqg76DcxqtbvJglVvXAgKWve"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150720172546.GF20628@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>, Peter Hurley <peter@hurleysoftware.com>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C4E2ImN98bqg76DcxqtbvJglVvXAgKWve
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/07/15 19:25, Johan Hovold wrote:
> What kernel version are you using?
I'm using linux 4.1.2.

> The idea of adding another layer of buffering in the cdc-acm driver has=

> been suggested in the past but was rejected (or at least questioned).
> See for example this thread:
>=20
> 	https://lkml.kernel.org/r/20110608164626.22bc893c@lxorguk.ukuu.org.uk
Yes, that is indeed pretty much the same problem and the same solution.
Answering to the questions brought up in that thread:

> a) Why is your setup filling 64K in the time it takes the throttle
> response to occur
As far as I understand, the throttle happens only when there's less than
128 bytes of free space in the tty buffer. Data can already be lost
before the tty even decides it should start throttling, simply because
the throttle threshold is smaller than the amount of data potentially in
each urb. Also (excuse my cluelessness) it seems that when exactly the
throttling happens depends on some scheduling "jitter" as well.
Additionally, the response of the cdc_acm driver to a throttle request
is not very prompt; it might have a queue of up to 16kB (16 urbs) pending=
=2E

> b) Do we care (is the right thing to do to lose bits anyway at
> that point)
This I cannot answer, I don't know enough about the architecture or
standards. I can just say that for my case, there's a lot of losses;
this it not an issue which happens after hours when the system is under
heavy load, it happens after just a few seconds reproducably.

> The tty buffers are quite large these days, but could possibly be bumpe=
d
> further if needed to give the ldisc some more time to throttle the
> device at very high speeds.
I do not like this solution. It will again be based on luck, and you
will still be unable to rely on the delivery guarantee made by the USB
stack (at least when using bulk).
My suggestion instead stops the host system from accepting any more data
from the device when its buffers are full, forcing the device to wait
before sending out more data (which many kinds of devices might very
well be able to do).

Also note that this patch does not introduce an extra layer of
buffering. The buffers are already there; this change just alters the
process which decides when to submit the buffers to the tty, and when to
free them for more input data from the device.

Sven



--C4E2ImN98bqg76DcxqtbvJglVvXAgKWve
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVrTjlAAoJEGjKjjjEuz9Lc0gP/1td0TkhtP06g30dC3ZhBoUG
ZOU9Zt9YVbTzuczWfEHd6IW+znebNtsWBDt/HQWS2EqVKfjSfba/2mniZkfDnixP
Q08j0p8Y85I9Nr5g1bx05k8WCQxNsLNdiiAFD8/0mt/sL8Drweey86QPvtgCuXVe
LgWUKk1iw0m8pvnFlR+HoBj35wBVsp5rsfIUkgyWEyPxyRwcXf7kUrM5dop1zI8Q
8AmXDDlfy0okyQ98q5zLp2f2yjvmAYyJ3T0U5ypxNxtDbtw7FIANVvGdO/sjoHv6
pG39Edwe+WyeRLTAzQPTTU9+Pn/OIdcgzxPLdbl34AAC2llHEbZTScmUyZvR0+9s
i3hraqyxDrhUs6lEwr2VqrTEFs2SbGco7RxP2rTlo/w7v3dI3H0ezlH4k7TP/86u
PHX58zYjfQiuipUQe6kJZ/urI00wNmAbrwb4BTHGXFPj19hFB1UED2pY6OkdDd5o
Rnp6WnsZT2HIwfCOzisMJHHete7f7RWhuf/036CVC497s2EdhrefT3RyU08HZdOO
5nP+1qQsVb4idaYfPkKn5PKJrogw+yUj3+LaYijNKv1la/wvvRN2xhJPp3xXYmMi
EL1kKFCmorXKiYj82hc/UCQ+EoU0F3HdK2Au9hqYrzMYuMl3H3bxeKPnZDScyrMv
We8WPmLKT8I8zoUD6c7b
=FBe6
-----END PGP SIGNATURE-----

--C4E2ImN98bqg76DcxqtbvJglVvXAgKWve--
