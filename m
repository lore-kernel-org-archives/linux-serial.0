From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] Fix oops in the 8250 serial driver when accessing a removed device
Date: Fri, 25 Jul 2008 13:40:13 +0200
Message-ID: <200807251340.16716.laurentp@cse-semaphore.com>
References: <200807221737.06224.laurentp@cse-semaphore.com> <200807221831.54473.laurentp@cse-semaphore.com> <20080725095128.GC21452@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2052566.mVqaaVZWvX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:38410 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752623AbYGYLkV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jul 2008 07:40:21 -0400
In-Reply-To: <20080725095128.GC21452@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

--nextPart2052566.mVqaaVZWvX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 25 July 2008, Russell King wrote:
> On Tue, Jul 22, 2008 at 06:31:50PM +0200, Laurent Pinchart wrote:
> > Hi Russell,
> >=20
> > On Tuesday 22 July 2008, Alan Cox wrote:
> > > > When a plug-and-play 8250 device is detected, the driver reuses one=
 of
> > > > the dummy ports. If that device is later removed, the port goes pack
> > > > to the dummy ports pool. The capabilities field is not reset, which
> > > > causes a oops when trying to access the port.
> > >=20
> > > Some day we need to allocate new dummy ports so there is always one
> > > free.=20
> > >=20
> > > > This patch resets the capabilities field when a 8250 device is
> > > > unregistered.=20
> > >=20
> > > Looks good to me. Would appreciate Russell's view though.
> >=20
> > Could you please review the patch (available at
> > http://marc.info/?l=3Dlinux-serial&m=3D121674107306179&w=3D2) ?=20
> > I'd like it to go into 2.6.27 if possible.
>=20
> Is there a link to the oops as well?

I'm afraid not. I had no copy of the oops so I tried to regenerate it. It t=
urned out the bug has been fixed in the meantime.

My patch can probably be dropped. I'm not sure if it's worth bisecting.

On the other hand, I ran into another issue caused by the WARN_ON in uart_f=
lush_buffer@drivers/serial/serial_core.c.

=2D-----------[ cut here ]------------
Badness at c0141288 [verbose debug info unavailable]
NIP: c0141288 LR: c013e1f0 CTR: 00000000
REGS: c39f3cc0 TRAP: 0700   Not tainted  (2.6.26-00040-g7f43ec9-dirty)
MSR: 00029032 <EE,ME,IR,DR>  CR: 24242422  XER: 00000000
TASK =3D c398d900[375] 'hciattach' THREAD: c39f2000
GPR00: 00000000 c39f3d70 c398d900 c39a1c00 00000000 00000001 c39f3d90 00000=
000
GPR08: c386b000 c023f5b4 00009032 c39a1c00 84044422 1001d9bc 03ff7000 c3fb9=
000
GPR16: 00000000 00000000 00000000 00000000 c39a1d28 c39a1d20 00000128 00000=
120
GPR24: c02d0000 00000000 00000000 00000001 00000000 c39f2000 c39a1c00 c39a1=
c00
NIP [c0141288] uart_flush_buffer+0x2c/0xbc
LR [c013e1f0] tty_driver_flush_buffer+0x34/0x44
Call Trace:
[c39f3d70] [c01370e8] tty_ldisc_flush+0x18/0x5c (unreliable)
[c39f3d80] [c013e1f0] tty_driver_flush_buffer+0x34/0x44
[c39f3d90] [c0183480] hci_uart_flush+0x34/0xb0
[c39f3da0] [c018354c] hci_uart_close+0x50/0x70
[c39f3db0] [c0183704] hci_uart_tty_close+0x38/0xa4
[c39f3dc0] [c0138cdc] release_dev+0x640/0x680
[c39f3e70] [c0138d3c] tty_release+0x20/0x3c
[c39f3e90] [c00724f4] __fput+0x190/0x1b0
[c39f3eb0] [c0070358] filp_close+0x54/0xac
[c39f3ed0] [c001efa8] put_files_struct+0xa0/0xec
[c39f3ef0] [c001f860] do_exit+0x164/0x688
[c39f3f30] [c001fe60] do_group_exit+0xa0/0xdc
[c39f3f40] [c00103d0] ret_from_syscall+0x0/0x38
=2D-- Exception: c01 at 0xff0e91c
    LR =3D 0xffb4b2c
Instruction dump:
4bffffe4 7c0802a6 9421fff0 93e1000c 7c7f1b78 90010014 81030144 2f880000
419e0010 80080010 2f800000 409e001c <0fe00000> 80010014 83e1000c 38210010

The hciattach process opens the serial port and sets the N_HCI line discipl=
ine. At some point the device is disconnected, and uart_remove_one_port is =
called by serial8250_unregister_port.

A comment in uart_remove_one_port states, right after calling tty_unregiste=
r_device,

"All users of this port should now be disconnected from this driver, and th=
e port shut down.  We should be the only thread fiddling with this port fro=
m now on."

This seems not to be true, at least with the N_HCI line disclipline. I've t=
ested the N_TTY line discipline by disconnecting the device while performin=
g a 'cat /dev/ttyS0' and no crash occurs.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2052566.mVqaaVZWvX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJu6AACgkQ8y9gWxC9vpcG1QCgmEYu9vVmf56PrLSGVIwQRigm
beYAoMSWanb+LaL5O5dOlA8xcWtOr/ci
=g2tv
-----END PGP SIGNATURE-----

--nextPart2052566.mVqaaVZWvX--
