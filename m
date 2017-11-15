From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] serial: sh-sci: Support for variable HSCIF hardware
 RX timeout
Date: Wed, 15 Nov 2017 16:06:15 +0100
Message-ID: <20171115150615.tg4gwh3ekfew6dcx@ninjato>
References: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1506690534-27302-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s5cqavwihootr57r"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506690534-27302-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-serial@vger.kernel.org


--s5cqavwihootr57r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2017 at 03:08:53PM +0200, Ulrich Hecht wrote:
> HSCIF has facilities that allow changing the timeout after which an RX
> interrupt is triggered even if the FIFO is not filled. This patch allows
> changing the default (15 bits of silence) using the existing sysfs
> attribute "rx_fifo_timeout".
>=20
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Can't this patch be resent independently of the other? With Geert's tag
added?


--s5cqavwihootr57r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloMV+MACgkQFA3kzBSg
KbZIeRAAnm4ApgmKvpyLzgiYepgpjO9y56R2lCutllsQFAe0okP4WMmotCgTaV5I
UqemZJ3CrHuUrWvpa0zYhKK5sZkfS6RRa3+ynQKqTL6BPy3T/o7jyCFgd8Hs2i1y
qmbu1fYERLVFt6ZlhGN1XSKcKtkRuP4Q6JWy9nsisvy6xL9qN+Jqp1M49zTqwAUQ
gN2xESt6b3uJGE72wPE5t9Lyr5zQwWKsM0YrJA3I5tQhbPXm2MxSdZl0rxeaXJNn
fqexkf3T06oAoFCSDcySapfa8qiKYXZjqzyICtVR7CCUOHvhBUY/aemjMxYVKDwI
QAyISg8ELO7TkTV5kNXIT+wYQgNCkxwUG8h+OAdQJKyQjk3NrBLfL2kMwHyag9QJ
YSCN8OiCovdFoIEN1h1rkkKcog2RxDh0HVZjb4l25U0J9rUkN12j9bvhRnkiPjqM
07rYe7PZgpHeBf0UVBdlZK+pBfT/HIsowNqc7OMz8RTz+TWEGt37sHi2zPDZE0xP
6rfIOjBl0Kahqd2WA5Lqfqmei+4dtzQ1pL6AOspqvdH8Je5g0cWiSHH7sHCcgHbU
fO0vSu9TiW65XFgoWvk834JKdGGz+DGRCAGLyjpBNqdXYpi2bnyZzoB8Dmoz4fiq
xmrfdfgCKme+IlLDjWE3CY0eyb/y8Cpz5BLy/y1MZ/XAGLCcX+c=
=Zxxi
-----END PGP SIGNATURE-----

--s5cqavwihootr57r--
