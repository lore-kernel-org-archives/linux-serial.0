From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv3 02/10] serdev: add serdev_device_wait_until_sent
Date: Mon, 10 Apr 2017 19:10:45 +0200
Message-ID: <20170410171045.xzqr2n5hzyfzyyru@earth>
References: <20170328155939.31566-1-sre@kernel.org>
 <20170328155939.31566-3-sre@kernel.org>
 <20170408165740.GA20058@kroah.com>
 <CAL_JsqLK=pbF7Nx-2w98t62N53zbL1oGZpGEbZUK-xg5ms4AZw@mail.gmail.com>
 <20170410140313.GA31894@kroah.com>
 <CAL_JsqJCjob6NDfHe0r7X3dXPEniKh5vChXhBxfyHZRu7Fov7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qftuitvjemplad6x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJCjob6NDfHe0r7X3dXPEniKh5vChXhBxfyHZRu7Fov7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
List-Id: linux-serial@vger.kernel.org


--qftuitvjemplad6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 10, 2017 at 11:12:39AM -0500, Rob Herring wrote:
> On Mon, Apr 10, 2017 at 9:03 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Apr 10, 2017 at 08:46:57AM -0500, Rob Herring wrote:
> >> On Sat, Apr 8, 2017 at 11:57 AM, Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >> > On Tue, Mar 28, 2017 at 05:59:31PM +0200, Sebastian Reichel wrote:
> >> >> Add method, which waits until the transmission buffer has been sent.
> >> >> Note, that the change in ttyport_write_wakeup is related, since
> >> >> tty_wait_until_sent will hang without that change.
> >> >>
> >> >> Acked-by: Rob Herring <robh@kernel.org>
> >> >> Acked-by: Pavel Machek <pavel@ucw.cz>
> >> >> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> >> >> ---
> >> >> Changes since PATCHv2:
> >> >>  * Avoid goto in ttyport_write_wakeup
> >> >> ---
> >> >>  drivers/tty/serdev/core.c           | 11 +++++++++++
> >> >>  drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++----
> >> >>  include/linux/serdev.h              |  3 +++
> >> >>  3 files changed, 28 insertions(+), 4 deletions(-)
> >> >>
> >> >> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> >> >> index f4c6c90add78..a63b74031e22 100644
> >> >> --- a/drivers/tty/serdev/core.c
> >> >> +++ b/drivers/tty/serdev/core.c
> >> >> @@ -173,6 +173,17 @@ void serdev_device_set_flow_control(struct ser=
dev_device *serdev, bool enable)
> >> >>  }
> >> >>  EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
> >> >>
> >> >> +void serdev_device_wait_until_sent(struct serdev_device *serdev, l=
ong timeout)
> >> >> +{
> >> >> +     struct serdev_controller *ctrl =3D serdev->ctrl;
> >> >> +
> >> >> +     if (!ctrl || !ctrl->ops->wait_until_sent)
> >> >> +             return;
> >> >> +
> >> >> +     ctrl->ops->wait_until_sent(ctrl, timeout);
> >> >> +}
> >> >> +EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
> >> >
> >> > Is this still needed now that we have serdev_device_write() with an
> >> > unlimited timeout available?
> >>
> >> Yes, because only this waits until the data is on the wire.
> >
> > What "wire" is that?  The serial wire?  How do you know this?  Many usb
> > to serial devices have no way to determine this, given that there is
> > another uart hanging off of the end of a USB connection.
>=20
> Okay, maybe it's just out of linux s/w buffers for h/w which you don't
> know. It is the same semantics as tty_wait_until_sent which is
> documented as: "Wait for characters pending in a tty driver to hit the
> wire, or for a timeout to occur (eg due to flow control)"

For embedded h/w it usually means the serial wire. tty_wait_until_sent()
first waits for the tty buffer to be empty and then calls wait_until_sent()
in the driver providing the tty. In case of serial-core that is
implemented by uart_wait_until_sent(), which waits for the serial
driver's tx_empty() operation becoming true (grepping for
".tx_empty" returned 81 hits for me). Also at least some of the usb to
serial adapters seem to support this using usb_serial_generic_wait_until_se=
nt()
and ".tx_empty":

$ git grep "\.tx_empty"
cp210x.c:       .tx_empty               =3D cp210x_tx_empty,
f81534.c:       .tx_empty =3D             f81534_tx_empty,
ftdi_sio.c:     .tx_empty =3D             ftdi_tx_empty,
io_ti.c:        .tx_empty               =3D edge_tx_empty,
io_ti.c:        .tx_empty               =3D edge_tx_empty,
mxuport.c:      .tx_empty               =3D mxuport_tx_empty,
ti_usb_3410_5052.c:     .tx_empty               =3D ti_tx_empty,
ti_usb_3410_5052.c:     .tx_empty               =3D ti_tx_empty,

The other ones will only wait for empty s/w buffer, but that's
already the case for tty_wait_until_sent(), so IMHO a different
problem.

-- Sebastian

--qftuitvjemplad6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljrvJMACgkQ2O7X88g7
+pqfyQ//eRgPEGVb9ShFmv8yUuzo4/CiSl9cgKiDcOaDDw+NPYQ36FO5kbN4ScMy
mkCtpMzZi5BvX5c0fhDxCFsp9aQiLX5R5EvjmgYf2TSO5gNmgiglA1HFPOG85Xl8
TCY8g40W8knLD2pEfKPWrYOKTU5QmTBu/rgnBElv3IsUhE/sfTzJJNrfof6XhcPZ
VlMrjQvwnA6XBMTpIM+Wo3RHzD9cGub4inGYPoVCS7E5saZvIKdR1G0QYtSejp/i
edyJcTTJe+wnwTVxT+RL05orfBEffOpWWrOQQxwcOAJjdXobG3lp/mGmGzlvR5aU
5XLjfZPK8mjzmZuoGOX7fVEFtRqZ0m8P0fp2/YOcXmomUspmD7fYda7yv2SCrjzb
Fy2kbdpLoEQxbNQoKU7EZle2ffcI7WanAeV4iJO789NMoUV3Jf2KwnGTmHXY8sNS
nOLKs1DWuZQ5PKkC6pOMv1Bw3ZZeE9RLcujMihoaXCFdVaFh8T3yHS/x0DpRj1Rm
47EShWDWqWCA+FiWbgAY8Uo9ZkYcY1yX2ajAdjdXZj79XoYl0qd2UcM7lFnJi/g5
6zxgucgoRyMNl/xiUnUo3tQUJQ1WWaVmBW3lmHUBBv5ErydN0LU4NJOeRCfFDCIl
LrKgs+xktNSr+JPTE5+aPPIA996EsL5PlNUKEigK6ZYA35UdIeo=
=0rjz
-----END PGP SIGNATURE-----

--qftuitvjemplad6x--
