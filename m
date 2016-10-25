From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/6] UART slave devices using serio
Date: Tue, 25 Oct 2016 23:55:22 +0200
Message-ID: <20161025215521.5a5uxjpujmoatgor@earth>
References: <20160824232437.9446-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oos4rvddas6w76gt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160824232437.9446-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--oos4rvddas6w76gt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 24, 2016 at 06:24:30PM -0500, Rob Herring wrote:
> This is a new approach to supporting UART slave devices using the
> existing serio bus. After Arnd's proding, I took another look at serio
> and decided extending it does make sense. Using serio primarily requires
> adding DT based device matching and supporting buffer based write and
> receive.
>=20
> Currently, I'm using the existing serio serport ldisc for testing. This
> requires using inputattach to open the tty and set the ldisc which in
> turn registers a serio port with the serio core:
>=20
> inputattach -bare /dev/ttyAMA1
>=20
> Once a tty_port based serio port driver is in place, this step will not
> be needed. Supporting cases like a USB UART will also work if the USB
> UART is described in DT. If not described in DT, I'm not sure if the
> existing serio manual binding is sufficient (Need to figure out how that
> works). Slave drivers also need other ways to specify additional data
> using module params perhaps. Getting DT overlays to work for
> non-discoverable devices behind discoverable buses (i.e. detached from
> a base DT) is another option, but that's not yet supported in general.
>=20
> I've done all the serio changes in place, but ultimately I think at
> least the core of serio should be moved out of drivers/input/. I don't
> think it belongs under drivers/tty/ or drivers/tty/serial/, so
> drivers/serio/?
>=20
> BT is working under QEMU to the point a slave driver can bind to a
> serio port device via DT, register as a BT device, start sending out
> initial packets and receive data (typed at a terminal). Now I need to
> find a real device.

I had a more detailed look at the series during the last two weeks.
For me the approach looks ok and it should work for the nokia bluetooth
use case. Actually my work on that driver is more or less stalled until
this is solved, so it would be nice to get this forward. Whose feedback
is this waiting from? I guess

 * Alan & Greg for the serial parts
 * Marcel for the bluetooth parts
 * Dmitry for the serio parts

Maybe you can try to find some minutes at the Kernel Summit to talk
about this?

Anyways, for the series:

Tested-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--oos4rvddas6w76gt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYD9TGAAoJENju1/PIO/qaRqAP/j4zrkQLbKdrC3HSAbtS4Nxa
x7rDhnT7+U+1XXGoSJH7D7+YS3xJmpencIeilmGU4JmD9dlHV1aR6QdYB+y7qtHr
PyRcEz8ZPrOk/UnQc2vf1rbfCRtupScGSE0Hno8S0WbXtHLszWoNmdXyuZCCg/pu
0lQ3sOtopzCxCEkQhrbpJUQzyXUk+kgfo2OVFVWElmtTobX+y10vG3gW473R+zEu
UMSMElaRMWqDDtuReNpbRx1vD6WttyYvxNaWQDNkwHE5nCWHUW4CVY1u+0lOMp+v
+/jQdkLHLCS0Y/M6MkrXhACghe72P4pBvR2zREvx1LzRHp9sykyukJ+u23xegToQ
8MOlXVOdZt8+ZDN4gKsO67yOoLU/ga/wpZrIW1qLyaDdRexikgf/abZ32mXOK70I
FK1259CbdhdhV2z9YyXqkxzS15c1+zi35cQ1HL3f5Y5xQUKDy+ABY665KeSBi5mP
XZmebGSHXAuVVZwCV+yzpAWM452W2s3Pv0XaGnmOXnNcaPv6DjJdDL1cudpCue9P
jJADYA71up63S84HlyCHY4fOMC+GLQHTH/dj32TelX9pVf3ep9ulWvZvlArby+TG
4sQZGr0tkT2Hys1/1ztEXAXX+SbsOIsn0Wdf0fOr1knotKaRvDv6tNwhtrjbaYS6
ap6OedlzwPAVS+6j+gBD
=4bvf
-----END PGP SIGNATURE-----

--oos4rvddas6w76gt--
