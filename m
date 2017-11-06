From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] tty: fix tty_ldisc_receive_buf() documentation
Date: Mon, 6 Nov 2017 14:39:44 +0100
Message-ID: <20171106133944.2vkbbpl2tokhsabq@earth>
References: <20171103141805.20292-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fqsacfdl2mw4bsag"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171103141805.20292-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--fqsacfdl2mw4bsag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 03, 2017 at 03:18:05PM +0100, Johan Hovold wrote:
> The tty_ldisc_receive_buf() helper returns the number of bytes
> processed so drop the bogus "not" from the kernel doc comment.
>=20
> Fixes: 8d082cd300ab ("tty: Unify receive_buf() code paths")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/tty/tty_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index f8eba1c5412f..677fa99b7747 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -446,7 +446,7 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
>   *	Callers other than flush_to_ldisc() need to exclude the kworker
>   *	from concurrent use of the line discipline, see paste_selection().
>   *
> - *	Returns the number of bytes not processed
> + *	Returns the number of bytes processed
>   */
>  int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
>  			  char *f, int count)
> --=20
> 2.15.0
>=20

--fqsacfdl2mw4bsag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloAZhsACgkQ2O7X88g7
+pqWWA/+OmK4a63tP8goXKIMbMeEAkUAD1P5iMjTBydmBN2LyVaYXARPYCMy0P1T
/gmZjYXTgDQvyc1qsmuEEsTdI6L/crDLoGF0oYyOtG94RH27kWgheNAhl3BVJ0Lc
rWVOZsuQp1ZhhihZrGuZKEKvAWWULUn58FOEw3GqovXwr55TKVwt402pKk6tVF4d
54WTZFLtKum0F2w+Sbi4CIiKr2BCmEZhFpua8v/FtfHFzC3voWeRFuKu9ZLcknPs
1NRSdCtpCTA1ACgJ06KrPR93Ij348ELJr6vxmtbR3S7G7xWkzjfDBFa0bPU4fCzR
SFArKZFuYzbq55dVyvzTdaWmx5ajYtV6AM9XR3a8v8ebBmlmQaotuMBRAxOrZSyI
8qaGsxvlQRsCoNCtcQtv57NdOqpNIC1iff2K06G4/ZFJP4MUU57qCjT0etSdBKSA
iIB42ikPIYVJ5aiNNpp6k8SjPUlCWFj7U1EcjmTcj73c3mFQvYqmHUI+JaRudjZZ
EeudgAZsz1IE5JgrGZrA2QoeANjBNhT2rBpzfCrZ5ueefid4QIEmoa73Ak/Lq/A6
j9nRPMNOjbZHxe47pVNM/Kc5FUSl45uhjFqU3Sql15I9P0ebEo7NHciOnwjxRQe0
hTG/RaXOTQQ7yx0tA5LmgUrRBYo4AQNaAJPrrzCPN8BI4S9RhlQ=
=RHNP
-----END PGP SIGNATURE-----

--fqsacfdl2mw4bsag--
