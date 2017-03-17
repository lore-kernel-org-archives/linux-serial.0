From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 03/10] Bluetooth: hci_uart: add support for word alignment
Date: Fri, 17 Mar 2017 16:25:38 +0100
Message-ID: <20170317152538.GB8723@amd>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-4-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170304115833.3538-4-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This will be used by Nokia's H4+ protocol, which
> uses 2-byte aligned packets.
>=20
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

> --- a/drivers/bluetooth/hci_h4.c
> +++ b/drivers/bluetooth/hci_h4.c
> @@ -171,9 +171,20 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, st=
ruct sk_buff *skb,
>  			    const unsigned char *buffer, int count,
>  			    const struct h4_recv_pkt *pkts, int pkts_count)
>  {
> +	struct hci_uart *hu =3D hci_get_drvdata(hdev);
> +	uint8_t alignment =3D hu->alignment;

I'd do u8 here, too, for consistency with struct below (and becuase
uint8_t is somehow unusual in kernel).

> @@ -92,6 +92,9 @@ struct hci_uart {
> =20
>  	unsigned int init_speed;
>  	unsigned int oper_speed;
> +
> +	u8			alignment;
> +	u8			padding;
>  };
> =20

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljL//IACgkQMOfwapXb+vKVdgCfbmJvP9y9Up37bQKrjnr1ewkv
13oAn1M/GRkTaeFLnU+jCJUoMePOa4vA
=ZJTZ
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
