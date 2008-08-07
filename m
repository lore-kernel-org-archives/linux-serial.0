From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 7 Aug 2008 10:50:32 +0200
Message-ID: <200808071050.35380.laurentp@cse-semaphore.com>
References: <002101c8f6fa$9273ab10$2e01a8c0@acksys.local> <1218033008.6275.86.camel@thetriton.toftronix.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1396743.T17tens3LU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:48885 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751196AbYHGIui (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Aug 2008 04:50:38 -0400
In-Reply-To: <1218033008.6275.86.camel@thetriton.toftronix.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christopher Gibson <chris@toftronix.com.au>
Cc: linux-serial@vger.kernel.org

--nextPart1396743.T17tens3LU
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 06 August 2008, Christopher Gibson wrote:
> Been a few years since I ran into this issue, but are faced with it
> again.  Last time the timing wasn't to critical and I managed to use
> user space control of the RTS line to achieve RS485 buffer direction
> control.  In this case I had control of the response time of the slave
> processor, so got away with it.  This time I haven't got that much
> control over the timing of the slave units, and a bit more load on the
> Linux system, and a user space solution is just not cutting it.  Have
> hacked up a kernel to give me the RTS control I need, but started
> working on a more generic (and less CPU wasting) solution.  It was part
> of this work that lead me to this mail group, as I was looking for
> conventions on how to enable RTS direction control.  It would seem,
> looking through this mail list that any convention is yet to be defined
> for Linux.

That's right. Hopefully we should achieve a consensus on the API soon.

> On Tue, 2008-08-05 at 14:55 +0200, Tosoni wrote:
> > > -----Original Message-----
> > > From: Laurent Pinchart
> > (...)
> >=20
> > > We already have 3 distinct modes for RTS/CTS (see my mail
> > > from today 11:23:36 in this thread). If we add DSR/DTR
> > > hardware support we can easily get 5 or 6 modes. We will run
> > > out of bits in c_cflags.
> > >
> > The three modes which you identify are
> > (A) bus direction
> > (B) send data request (well... RTS=3DRequest To Send :-)) which should =
be
> > acknowledged by CTS
> > (C) input flow control
> > but, the RTS is widely used for (A)=3Dbus direction BECAUSE it is the s=
ame
> > behaviour than (B)=3Drequest to send... because RTS was initially made =
to
> > set the "bus direction" in the attached modem.
> > So the three modes are really 2.
> (--->8---)
>=20
> The only case above that is actually RS232 is (B), the rest are just
> asynchronous serial communications.

(C) has actually been standardized in TIA-232-E (formerly RS-232-E). See ht=
tp://en.wikipedia.org/wiki/RS-232

> Saying that (A) and (B) are the same negates the timing requirements
> that (A) may have that are unimportant in (B).
>=20
> In some situations you can get case (A) from a type (B) implementation
> by tying RTS and CTS together, but for other UARTS, this just doesn't
> work.  You can end up losing characters that are in the tx shift
> register and end of FIFO, or in the other timing extreme, losing the
> response from a RS485 slave unit.
>=20
> I would say that it's important to make the RS485 RTS direction control
> mode distinct from the RTS/CTS RS232 hand shaking mode.  I would foresee
> that it may be necessary to allow setup of different timing modes, to
> allow for example chewing up CPU resources for the sake of fast
> direction turn around when using ill conceived UARTS.  (Maybe an ill
> conceived UART is just an ART;)  Also if this is to also be useful for
> radio communications then it may be necessary to provide a mechanism
> where lead in and lead out times can be specified for the control.

This is getting more complex than I would have thought, although your point=
 is quite valid :-/ I don't think we should implement any hardware handshak=
e mode in software thought. Drivers should export the capabilities of the h=
ardware. If an UART doesn't support mode (A) it's quite pointless to try to=
 emulate it in the driver. Timing requirements will be violated at some poi=
nt, users will complain, and developers will point out that the software im=
plementation didn't come with any guarantee. Everybody will be disappointed=
 in the end.

Is there any UART that supports lead in/lead out timing configuration in ha=
rdware ?

> As far as IOCTL names go I dislike the CRTSTOGGLE, toggling the RTS line
> is an incorrect description of function.  I prefer CARTS as it is not an
> incorrect description of function.  CARTS - auto request to send is
> rather ambiguous though.  If I was to suggest a name it would be RTSADC
> - request to send auto direction control (maybe with a preceding C if it
> went into termios cflags).

Let's first decide where it should go, then we'll try to find appropriate n=
ames. The number of free bits in c_cflags is quite limited, so I think a ne=
w ioctl is probably required with a new data structure to pass additional d=
ata such as timing information in addition to the handshaking mode.

> From what I can gather through the man pages it seems inappropriate to
> add this to termios cflag, though the CRTSCTS flag does set a precedent.
> I'm an advocate of the idea of introducing a new IOCTL for setting up
> non standard hand-shaking settings.  I would suggest that things that
> should be considered in the interface are settings for lead-in and
> lead-out timing on the direction line (for the use of radio modems for
> example) and means to specify if it's appropriate to have the CPU spin
> on the shift register empty flag on the last byte of a block, if RTS
> timing really is that critical.

I don't think we want to introduce software emulation, but feel free to pro=
ve me wrong.

> I'm rather excited by the idea that a standard interface for RTS
> direction control is going to be introduced.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1396743.T17tens3LU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiat1sACgkQ8y9gWxC9vpdwiACeNtGUhdxMJH3TzMyo9PaESuLM
3YsAoJ/u/WUJA5/I+N9cY3ND/FmZsw/v
=J5uR
-----END PGP SIGNATURE-----

--nextPart1396743.T17tens3LU--
