From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RESEND] serdev: ttyport: do not used keyed wakeup in
 write_wakeup
Date: Mon, 18 Dec 2017 12:28:39 +0100
Message-ID: <20171218112839.zh5d6m7yi7zqzmrs@earth>
References: <20171218110019.21934-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qi4mkd5vkkisyx4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171218110019.21934-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--7qi4mkd5vkkisyx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 18, 2017 at 12:00:19PM +0100, Johan Hovold wrote:
> Serdev does not use the file abstraction and specifically there will
> never be anyone polling a file descriptor for POLLOUT events.
>=20
> Just use plain wake_up_interruptible() in the write_wakeup callback and
> document why it's there.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>=20
> Here's a resend of the final patch from the series "[PATCH 0/8] serdev:
> receive_buf and locking fixes", which did not apply after the series was
> split over 4.15-rc and -next.
>=20
> Johan
>=20
>=20
>  drivers/tty/serdev/serdev-ttyport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index c2629ab1bbcf..a5abb05be67d 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -59,7 +59,8 @@ static void ttyport_write_wakeup(struct tty_port *port)
>  	    test_bit(SERPORT_ACTIVE, &serport->flags))
>  		serdev_controller_write_wakeup(ctrl);
> =20
> -	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
> +	/* Wake up any tty_wait_until_sent() */
> +	wake_up_interruptible(&tty->write_wait);
> =20
>  	tty_kref_put(tty);
>  }
> --=20
> 2.15.1
>=20

--7qi4mkd5vkkisyx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlo3pmQACgkQ2O7X88g7
+pr2Gw//b7FDLEmVPjk8sC/IXGNZS9aG6k7ktUFVxX4hWoJUvROtjAe6n9Eqw3TG
j5ZPLBj/A49llICoEFk4LgJsTDNwPZy4x0H8tRPYqgl5vH0ooup9wYpvAl0eVzIO
JI80H8WV7yeDkZb6NRsLgiTLxivoBQfWNBM2fvBu5uO5uL+deQGa1+njtU9bEt8V
qjp+3bhEEMmumMurW54BXbZn9Wzj1srb9YnUG2CKWuC3G8W6kb6oQh6HmjDXsBj4
fvK420jXGvY90RXXTr8uflPcRenRFW3k+mnTWCnq+DUIWDIcN6UcFwkRUqlH8D47
wvKRR60jkULRbZ6It9csEjptvfJGdXFP5/5FbyAqLA5888qMDOExIlUbpNp358eJ
mJ+J7b7wSZ80xboE3g0Q0qRnRAi+9Y98pE+SdhgHm6GqKazAiuQWDFj2JSckc36Z
aXJdb9a6dxu6szVZCPS7e5DkWxRTlpvV4eK3tyOGz6xhwFWJHmB6pKiH10XlqbSN
eaM3mnWBcGucUrL7seC0twzlNNWRCrVpuXDoXtKuQHkbDXBQSX3znmwJDwU6SPDK
M6wpyLjuQ+FAuhIrfZeijdCUaZ1PagLJ3fuJM2O91pqC/kuu3Z7O3SNZ0hxDvVK6
avtYITMjYsxa59WzaLsg3wOW2rMi1JUtiBX6Ra+P8ZPOXf0FORU=
=zvGX
-----END PGP SIGNATURE-----

--7qi4mkd5vkkisyx4--
