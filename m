From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Tue, 5 Aug 2008 11:23:36 +0200
Message-ID: <200808051123.39536.laurentp@cse-semaphore.com>
References: <200808041637.02058.laurentp@cse-semaphore.com> <015301c8f651$cfea6cd0$2e01a8c0@acksys.local> <g77f8p$plq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1869137.0GuVYgb3e8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:51958 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754432AbYHEJXn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Aug 2008 05:23:43 -0400
In-Reply-To: <g77f8p$plq$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grante@visi.com>
Cc: linux-serial@vger.kernel.org

--nextPart1869137.0GuVYgb3e8
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 August 2008, Grant Edwards wrote:
> On 2008-08-04, Tosoni <jp.tosoni@acksys.fr> wrote:
>=20
> > Last remark:
> >
> > Interestingly, the RTS envelope on the Oxford chips is
> > implemented with... the DTR pin. On our cards we have a piece
> > of hardware which redirect the uart DTR pin to the external
> > RTS in this case.
>=20
> Well, that's just plain wrong.  The RS-232 standard was quite
> clear that RTS is what's used to enable transmission.  ;)

UARTs are not restricted to RS-232. The pin labelled RTS in the 16850 datas=
heet is a dual purpose pin that can be used either as RTS in RS-232 mode or=
 as a bus direction signal in RS-485 mode.

Beside, even in RS-232 mode, RTS has at least two widely used modes. The hi=
storical usage asserts RTS when the DTE (computer) wants to send data. It t=
hen waits for the DCE (modem) to assert CTS and then sends data on the TX l=
ine. This was used with half-duplex modems. The newer flow-control usage as=
serts RTS when the DTE is ready to receive data. The DCE uses CTS for the s=
ame purpose in the opposite data flow direction.

This means we already have at least 3 hardware RTS/CTS modes that we need t=
o support in the serial API.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1869137.0GuVYgb3e8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiYHBsACgkQ8y9gWxC9vpeptgCg2ME/cB6njz9VJoCRv1NtH5Vy
MJ0AoNWRrcCyWkM3bdWvHhG40XhO13ed
=lIO2
-----END PGP SIGNATURE-----

--nextPart1869137.0GuVYgb3e8--
