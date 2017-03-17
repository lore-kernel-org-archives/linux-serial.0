From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/10] Bluetooth: hci_serdev: do not open device in hci
 open
Date: Fri, 17 Mar 2017 16:26:10 +0100
Message-ID: <20170317152610.GE8723@amd>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-6-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170304115833.3538-6-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> @@ -366,5 +360,6 @@ int hci_uart_register_device(struct hci_uart *hu, con=
st struct hci_uart_proto *p
>  err_alloc:
>  	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>  	p->close(hu);
> +
>  	return err;
>  }

This could be removed, I guess.

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljMABIACgkQMOfwapXb+vKHAgCfWcwE0TOq5Yer5Uy3oWCSkoTU
0MgAoMA5mwRxkOvE2Hww5zS5MRjD8Paf
=fHOW
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
