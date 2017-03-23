From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2 09/11] Bluetooth: add nokia driver
Date: Thu, 23 Mar 2017 10:07:20 +0100
Message-ID: <20170323090720.yuzh4kao6vdpghev@earth>
References: <20170321223216.11733-1-sre@kernel.org>
 <20170321223216.11733-10-sre@kernel.org>
 <07cf4c22-b798-6e77-cca0-548e32e9de3f@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftfthg2oftcfmakd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <07cf4c22-b798-6e77-cca0-548e32e9de3f@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--ftfthg2oftcfmakd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 08:50:42AM +0100, Fr=E9d=E9ric Danis wrote:
> Le 21/03/2017 =E0 23:32, Sebastian Reichel a =E9crit :
> > This adds a driver for the Nokia H4+ protocol, which is used
> > at least on the Nokia N9, N900 & N950.
> >=20
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> > Changes since PATCHv1:
> >   * replace __u8 and uint8_t with u8
> >   * replace __u16 and uint16_t with u16
> >   * drop BT_BAUDRATE_DIVIDER and use btdev->sysclk_speed * 10 instead
> >   * fix wording of a sentence
> >   * fix error path of negotation & alive package receive functions
> >   * replaced nokia_wait_for_cts with newly introduced serdev function
> >   * use "nokia,h4p-bluetooth" as compatible string
> > ---
> >   drivers/bluetooth/Kconfig     |  12 +
> >   drivers/bluetooth/Makefile    |   2 +
> >   drivers/bluetooth/hci_nokia.c | 819 +++++++++++++++++++++++++++++++++=
+++++++++
> >   3 files changed, 833 insertions(+)
> >   create mode 100644 drivers/bluetooth/hci_nokia.c
> >=20
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > index c2c14a12713b..2e3e4d3547ad 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -86,6 +86,18 @@ config BT_HCIUART_H4
> >   	  Say Y here to compile support for HCI UART (H4) protocol.
> > +config BT_HCIUART_NOKIA
> > +	tristate "UART Nokia H4+ protocol support"
> > +	depends on BT_HCIUART
> > +	depends on SERIAL_DEV_BUS
> > +	depends on PM
> > +	help
> > +	  Nokia H4+ is serial protocol for communication between Bluetooth
> > +	  device and host. This protocol is required for Bluetooth devices
> > +	  with UART interface in Nokia devices.
> > +
> > +	  Say Y here to compile support for Nokia's H4+ protocol.
> > +
> >   config BT_HCIUART_BCSP
> >   	bool "BCSP protocol support"
> >   	depends on BT_HCIUART
> > diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> > index fd571689eed6..a7f237320f4b 100644
> > --- a/drivers/bluetooth/Makefile
> > +++ b/drivers/bluetooth/Makefile
> > @@ -25,6 +25,8 @@ obj-$(CONFIG_BT_BCM)		+=3D btbcm.o
> >   obj-$(CONFIG_BT_RTL)		+=3D btrtl.o
> >   obj-$(CONFIG_BT_QCA)		+=3D btqca.o
> > +obj-$(CONFIG_BT_HCIUART_NOKIA)	+=3D hci_nokia.o
> > +
> >   btmrvl-y			:=3D btmrvl_main.o
> >   btmrvl-$(CONFIG_DEBUG_FS)	+=3D btmrvl_debugfs.o
>=20
> This does not build as module with following error:
> ERROR: "hci_uart_tx_wakeup" [drivers/bluetooth/hci_nokia.ko] undefined!
> ERROR: "hci_uart_register_device" [drivers/bluetooth/hci_nokia.ko]
> undefined!
>=20
> Should not hci_nokia be part of the hci_uart module?

Yeah, I also received that from kbuild test robot after sending the
patchset. I intentionally did not add this to hci_uart, so that I can
use module_serdev_device_driver(). I think at least for serdev-only
based bluetooth drivers it makes sense to have them in their own module.
I already have added EXPORT_SYMBOL_GPL for those functions in the next
version of this patchset.

-- Sebastian

--ftfthg2oftcfmakd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTkEUACgkQ2O7X88g7
+pqHzw//S8VfPGWi0TCAw1EI5SRkBPZSVPM7aqufMYCKUJDsQEBRoJ+vUgOn+UIx
p8iAgFbX2R6Ue3sOaar91fQrqTeJqwczEkQQYWwEgWN1z/FN25uy5BO3rxOGC4Ei
0AmyIT7Vaos/hxuGllea4F7BWT9vqtYiWvdSnhSYFFIMoMn7Y8L84bK/j9gGOQ7H
anMGSAOLm6Vu/EuXzptkLfD/zJQuEVO1TEVpV56SqiOE45n0l3W3Tgr2by3b2zsm
1nzc7ZEnSlw+p8NqEuFUPto0GdiT1dWX038jVu7ULUgJrrMbIDvh4R3yrvgr6ZTU
KBkloVsR/0J/qsrfbsfIEr6PVPpLEFjp79QAogH4rG0s3e7LTiG2TFvJTVnAe4DP
BQrSgw+dZlU7asMUogdMC7Nn/Jy/QEbeECd1cRZLhBbMWRFXyGi1rKMYzLF8cw9R
1Kor/lJO1YhkWOOpyZsP4Vd2abApHXwrA9BZeiy5weiXBYO84gjBb/SFR35UkhH3
kJC94nJLO0JNbYnwQPkP0uedtDBnFY50jGHEqIHHIksdCDzfki5mf0pSWP5cAYy1
XjAhey9vcnNkB3hIl1u05Fpy8Lrzwlw5ufm0meUcxvV0LSIWcJc4rXc1mw2HcaEI
LR6+zLYH3wu63vjOA8IYdGkonM3ZuuJMYvRkXzA3thKGNaWfD84=
=CTa/
-----END PGP SIGNATURE-----

--ftfthg2oftcfmakd--
