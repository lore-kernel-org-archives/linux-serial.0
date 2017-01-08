From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/9] tty: move the non-file related parts of tty_release
 to new tty_release_struct
Date: Sun, 8 Jan 2017 23:42:48 +0100
Message-ID: <20170108224248.pabp3z7jiclkzh5y@earth>
References: <20170106162635.19677-1-robh@kernel.org>
 <20170106162635.19677-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtms2tizvncbqqus"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170106162635.19677-2-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--vtms2tizvncbqqus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 06, 2017 at 10:26:27AM -0600, Rob Herring wrote:
> For in-kernel tty users, we need to be able to create and destroy
> 'struct tty' that are not associated with a file. The creation side is
> fine, but tty_release() needs to be split into the file handle portion
> and the struct tty portion. Introduce a new function, tty_release_struct,
> to handle just the destroying of a struct tty.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/tty/tty_io.c | 42 ++++++++++++++++++++++++------------------
>  include/linux/tty.h  |  1 +
>  2 files changed, 25 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 734a635e7363..5ebc090ec47f 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1744,6 +1744,29 @@ static int tty_release_checks(struct tty_struct *t=
ty, int idx)
>  	return 0;
>  }
> =20
> +void tty_release_struct(struct tty_struct *tty, int idx)
> +{
> +	/*
> +	 * Ask the line discipline code to release its structures
> +	 */
> +	tty_ldisc_release(tty);
> +
> +	/* Wait for pending work before tty destruction commmences */
> +	tty_flush_works(tty);
> +
> +	tty_debug_hangup(tty, "freeing structure\n");
> +	/*
> +	 * The release_tty function takes care of the details of clearing
> +	 * the slots and preserving the termios structure. The tty_unlock_pair
> +	 * should be safe as we keep a kref while the tty is locked (so the
> +	 * unlock never unlocks a freed tty).
> +	 */
> +	mutex_lock(&tty_mutex);
> +	release_tty(tty, idx);
> +	mutex_unlock(&tty_mutex);
> +}
> +EXPORT_SYMBOL_GPL(tty_release_struct);

tty_release_struct() is missing kernel docs.

> [...]

-- Sebastian

--vtms2tizvncbqqus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhywGgACgkQ2O7X88g7
+po2sw//dOn+ojzvvkd7XmoNtZ78A1R3J7CB1VqnTZCBQCi2zPGfm62NGx5veYOA
Z6n9sJYvP7A7Hia3RwoM7rStjNLDbbjhU1hDEHh1Iku6goiqEcqFZmemk2NMWSVp
bsnlxPHPbt8MfP+MsA+3PwRYOqkv04NCEyUNTSIF2NXKyl4xqI5GwLPEaOpnZYOn
X7tvPc+V5UcfaVpaMpu91QXcbvk+EV9HbOzsA+JmB1ei91n/hVl325mXdqVHaiX4
wcy5NSILy2X4+NC5WLwDCta6vEjzKmqbxrTVhk18itP8xbw29TntnyaaQXat23MF
6L4uyaK55EyGbSkWLrTw75ej4RTl1ubt4LAZ68J+uUs5/lRMnQ4KvDwjJ4SPR/F4
yzZlCVj/LpeNTXegVM/zm/0+HwCNQlT38/FCdc5tkhXLQhTAz2Asfd58pMQuliFv
g+m2MiJ9rEN+tqOiTuQi4su5m1nIb6Mr7MtpP1dtEh8BDxbMigc4a3tRNzpdEDyV
MD1/JmmpuaDBAz8S8g3BM+G40BDSh856/OJ6zXUmDeJPebHnvqevAbJjlzVTmeXN
ATqX2tqSwTtbysW0il49iP77O7cBk1qkO5jYNFN1J9lVEagA96JZ1W3iACb7Cm6Q
xmaKw+NrtL7MoNuQJpF6F347ntMcL1FICw9O1yncSrG/WVBlSV0=
=q+5A
-----END PGP SIGNATURE-----

--vtms2tizvncbqqus--
