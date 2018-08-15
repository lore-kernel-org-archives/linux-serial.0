From: Sebastian Reichel <sre@kernel.org>
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
Date: Wed, 15 Aug 2018 20:21:50 +0200
Message-ID: <20180815182150.wsd5oxlucsox2qig@earth.universe>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u4rhdlaygnjezj5s"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Sender: netdev-owner@vger.kernel.org
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-usb@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, Xue Liu <liuxuenetmail@gmail.com>, Ben Whitten <ben.whitten@lairdtech.com>, devicetree@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, Alexander Graf <agraf@suse.de>, "LoRa_Community_Support@semtech.com" <LoRa_Community_Support@semtech.com>, Jian-Hong Pan <starnight@g.ncu.edu.tw>, Stefan Rehm <rehm@miromico.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


--u4rhdlaygnjezj5s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

+cc Johan Hovold <johan@kernel.org>

Johan told me, that he is working on this at ELCE 2017. Also he is
the subsystem maintainer of the USB serial subsystem.

-- Sebastian

On Tue, Aug 14, 2018 at 04:28:20AM +0200, Andreas F=E4rber wrote:
> Hi Rob et al.,
>=20
> For my LoRa network driver project [1] I have found your serdev
> framework to be a valuable help for dealing with hardware modules
> exposing some textual or binary UART interface.
>=20
> In particular on arm(64) and mips this allows to define an unlimited
> number of serdev drivers [2] that are associated via their Device Tree
> compatible string and can optionally be configured via DT properties.
>=20
> And in theory it seems serdev has also grown support for ACPI.
>=20
> Now, a growing number of vendors are placing such modules on a USB stick
> for easy evaluation on x86_64 PC hardware, or are designing mPCIe or M.2
> cards using their USB pins. While I do not yet have access to such a
> device myself, it is my understanding that devices with USB-UART bridge
> chipsets (e.g., FTDI) will show up as /dev/ttyUSBx and devices with an
> MCU implementing the CDC USB protocol (e.g., Pico-cell gateway =3D picoGW)
> will show up as /dev/ttyACMx.
> On the Raspberry Pi I've seen that Device Tree nodes can be used to pass
> information to on-board devices such as MAC address to Ethernet chipset,
> but that does not seem all that useful for passing a serdev child node
> to hot-plugged devices at unpredictable hub/port location (where it
> should not interfere with regular USB-UART cables for debugging), nor
> would it help ACPI based platforms such as x86_64.
>=20
> My idea then was that if we had some unique criteria like vendor and
> product IDs (or whatever is supported in usb_device_id), we could write
> a usb_driver with suitable USB_DEVICE*() macro. In its probe function we
> could call into the existing tty driver's probe function and afterwards
> try creating and attaching the appropriate serdev device, i.e. a fixed
> USB-to-serdev driver mapping. Problem is that most devices don't seem to
> implement any unique identifier I could make this depend on - either by
> using a standard FT232/FT2232/CH340G chip or by using STMicroelectronics
> virtual com port identifiers in CDC firmware and only differing in the
> textual description [3] the usb_device_id does not seem to match on.
>=20
> The obvious solution would of course be if hardware vendors could revise
> their designs to configure FTDI/etc. chips uniquely. I hear that that
> may involve exchanging the chipset, increasing costs, and may impact
> existing drivers. Wouldn't help for devices out there today either.
>=20
> For the picoGW CDC firmware, Semtech does appear to own a USB vendor ID,
> so it would seem possible to allocate their own product IDs for SX1301
> and SX1308 respectively to replace the generic STMicroelectronics IDs,
> which the various vendors could offer as firmware updates.
>=20
> All outside my control though.
>=20
> Oliver therefore suggested to not mess with USB drivers and instead use
> a line discipline (ldisc). It seems that for example the userspace tool
> slattach takes a tty device and performs an ioctl to switch the generic
> tty device into a special N_SLIP protocol mode, implemented in [4].
>=20
> However, the existing number of such ldisc modes appears to be below 30,
> with hardly any vendor-specific implementation, so polluting its number
> space seems undesirable? And in some cases I would like to use the same
> protocol implementation over direct UART and over USB, so would like to
> avoid duplicate serdev_device_driver and tty_ldisc_ops implementations.
>=20
> Long story short, has there been any thinking about a userspace
> interface to attach a given serdev driver to a tty device?
>=20
> Or is there, on OF_DYNAMIC platforms, a way from userspace to associate
> a DT fragment (!=3D DT Overlay) with a given USB device dynamically, to
> attach a serdev node with sub-nodes?
>=20
> Any other ideas how to cleanly solve this?
>=20
> In some cases we're talking about a "simple" AT-like command interface;
> the picoGW implements a semi-generic USB-SPI bridge that may host a
> choice of 2+ chipsets, which in turn has two further sub-devices with 3+
> chipset choices (theoretically clk output and rx/tx options etc.) each.
> (For the latter I'm thinking we'll need a serdev driver exposing a
> regmap_bus and then implement regmap_bus based versions of the SPI
> drivers like Ben and I refactored SX1257 in [2] last weekend.)
>=20
> Thanks,
> Andreas
>=20
> [1] https://patchwork.ozlabs.org/cover/937545/
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/t=
ree/drivers/net/lora?h=3Dlora-next
> [3]
> https://github.com/Lora-net/picoGW_mcu/blob/master/src/usb_cdc/Src/usbd_d=
esc.cpp#L59
> [4]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/slip/slip.c#n1281
>=20
> --=20
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=FCrnberg)
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--u4rhdlaygnjezj5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlt0bzoACgkQ2O7X88g7
+pqYHw/+JbG6lwpIBsvl/yv/S6MZZV153R7pJN02mqfm6gI8NS7uiQYz/X8l6Gjc
GGM+Gr7Bbd/+YtpWN//2UOD8hqCuCkrLyoZShFFl7hvdJd8ONmW2yNU33+7OuKWH
E1D7bvyETxjzagYLyKcKab03UxNQd1fPdmZd2zdz1oK4q5T9rGiR7KdAHxvZd5bB
WLnEBBhmAu8ygZlqBdxYVZopWxlf2I1M51ual/Ng7RPpbOhE5BAf3ISvbZeWF1tX
elrV3291+e4uwc/Ep+/Ki3S6SdUJUrP6Jm9GuKN/8mQuBL+2v/fcj02FCljhATKL
0E1WctRJJuhqCLBuOHEQqHipm5uCfHmdLN/HiY+u37Ds1t3Glf4EeMdxjrcgbFhO
CqAN/mETDeCmosKPmIvJor9mQa1Ba1BiSRNujg3PrhMeTMLzS3bM+UfBdUhyPF/Z
OdKT+/xXsO3Hmtd3oZ2NIIKlSYWs1SIq+V83sMwGXdh9N92ZnTAma6tjQUZ4EbA5
XxzAHp0FCJHRTFF2YqdYMukkpz/cFo6LlNyqCRxuP/avL8pTKt2TR5TR+772DC4s
xW/vrri4tXxmA71T+/Qi9Lyh25EWRCGdQ7gqJP/SM9UbJANnSh/yK2VR9Paqhd7g
DjZovY9855H+dmb9ZjurFbfWwe0fW0PNIZi5K3075sJckMrAXyU=
=4v2H
-----END PGP SIGNATURE-----

--u4rhdlaygnjezj5s--
