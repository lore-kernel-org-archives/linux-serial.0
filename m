From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/9] Bluetooth: hci_uart_set_flow_control: Fix NULL deref
 when using serdev
Date: Tue, 3 Oct 2017 00:34:15 +0200
Message-ID: <20171002223415.jmbi4zw7edyuxccl@earth>
References: <20171002152356.4714-1-hdegoede@redhat.com>
 <20171002152356.4714-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a4vtalppzdfi5uwv"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171002152356.4714-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--a4vtalppzdfi5uwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 02, 2017 at 05:23:48PM +0200, Hans de Goede wrote:
> Fix a NULL pointer deref (hu->tty) when calling hci_uart_set_flow_control
> on hci_uart-s using serdev.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index a746627e784e..d02f6d029093 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -41,6 +41,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/skbuff.h>
>  #include <linux/firmware.h>
> +#include <linux/serdev.h>
> =20
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -298,6 +299,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, =
bool enable)
>  	unsigned int set =3D 0;
>  	unsigned int clear =3D 0;
> =20
> +	if (hu->serdev) {
> +		serdev_device_set_flow_control(hu->serdev, !enable);
> +		return;
> +	}

I think this should also control rts, so that the behaviour is the
same for serdev and ldisc implementation:

serdev_device_set_rts(serdev, enable);

> +
>  	if (enable) {
>  		/* Disable hardware flow control */
>  		ktermios =3D tty->termios;

-- Sebastian

--a4vtalppzdfi5uwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnSvuEACgkQ2O7X88g7
+ppKMw/+L8KxKyOIDnYr+OOoqaplzoDgOsr91ccJBh/DXXwz63T7LWiUcPQuYWiO
eZ0vG7VsYA+10YIfgiLLzesx4TrIv28+HZUK1a7lthGayq/zw5W8pLsoSPoHpx0h
wHBy+ZoL1JegC+/+OfaqojjVnoEgq0zOY+zt4EDmz4E1LmIpo2gsnOgOkH8xjhr/
2/P79GTJHHfyjpP9eU/qI2g+Doxpf1hLn0Zst+LlYF+/dR0Lf71eINmWJ5r38Y5Z
OA6tKA7yMiYvK4sjbYZplI8APzA6rxVUx0fB/oo6IhPoG3LWk9mN/D1htULPO4Hy
OuuIHTiIp68wn+LjFFBP+eulR42q2fppARTCLbvVLmebKS0yo9VmaW2iNBB7DSAf
Jgys38SNhmEeLZgFiCqCIXww1ihoMyBwhWerI0vLZE3V4iZm4HVuB6/C5LPNHBXd
zoMzsHj1NIGLiYEHjOIXZLlPVS0Pr03EAGUYtjfoFodWOR5sCh2Zb5DM/p74A/E4
Fmzg289zFrFYcPtjo3UZXB8P/crPS34BJbKpPxzO580y4Wpw4JPnIlpajKIdgliT
gzA4gsMstzaGDTym24VXcW6MEAhjmwU5lVIoeX6sjYR78PH7jYQLWx0412C5sots
F5PhziJiv6FNMDs21KMc6739PKZ74eWLoDgLVdu9ttSlZR3gRGI=
=3ZvC
-----END PGP SIGNATURE-----

--a4vtalppzdfi5uwv--
