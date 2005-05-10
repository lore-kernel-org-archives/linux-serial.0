From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Tue, 10 May 2005 08:44:59 +0100
Message-ID: <200505100845.03206.andyparkins@gmail.com>
References: <200505051650.38471.andyparkins@gmail.com> <200505090901.25433.andyparkins@gmail.com> <Pine.LNX.4.58.0505090825470.750@deadrat.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1369078.phfUPtjlGL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from host3.360visontechnology.com ([195.102.65.187]:24070 "EHLO
	369run02s.360vision.com") by vger.kernel.org with ESMTP
	id S261581AbVEJIiF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 04:38:05 -0400
Received: from dvr ([127.0.0.1])
	by dvr with esmtp (Exim 3.36 #1 (Debian))
	id 1DVPQN-0003z6-00
	for <linux-serial@vger.kernel.org>; Tue, 10 May 2005 08:45:03 +0100
In-Reply-To: <Pine.LNX.4.58.0505090825470.750@deadrat.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--nextPart1369078.phfUPtjlGL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2005 May 09 17:33, rich+ml@lclogic.com wrote:
> On Mon, 9 May 2005, Andy Parkins wrote:
> > Are you sure that RTSCTS flow control is what you think it is?  These
> > days RTS means "request to send to me" rather than "I request to send";
> > that allows RTS and CTS to be crossed over in null modem cables - and
> > puts the flow control in the receiver directly.
>
> Yep. RTS is an output from the PC, CTS is an input to the PC, weird
> cabling does not change this.

I wasn't suggesting otherwise; I think these days though, RTS doesn't mean=
=20
that the PC is requesting to send it means the PC is open to receiving.=20

http://www.pccompci.com/cable.html

Hence, when the RTS and CTS are crossed over in a null modem cable (which=20
isn't by any means weird) RTS from device 1 lights up CTS in device 2 and=20
vice versa -- exactly what would be required.  Although t

> > I'm coming to accept that what I'm after isn't possible.  How likely is
> > it that I could patch the serial_core kernel driver to do the RTS contr=
ol
> > for me?  Am I going to end up in the same situation?
>
> I believe you will end up in the same situation.

As it happens, Christer Weinigel in another part of the thread suggested a=
=20
solution that I've had great success with - so thankfully I don't have to g=
o=20
near the kernel :-)

> You might take a look at a usb-to-serial cable, kernel will 'mount' it as
> /dev/ttyUSB0 or something so the application doesn't have to know any
> better. However these cables contain PL2303 or similar uart which supports
> auto rts/cts if so enabled (the idea is to not push every control signal
> transient down the usb). Google for PL2303 spec, look for pl2303.c in the
> kernel.

That would be an excellent solution, and I still may look into that - the=20
option of lots of serial ports via USB has a certain appeal.

Again, thanks for your help on this.  It's all been (and continues to be) v=
ery=20
interesting.

Andy

=2D-=20
Dr Andrew Parkins, M Eng (hons), AMIEE


--nextPart1369078.phfUPtjlGL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCgGZ/wQJ9gE9xL20RAorEAJ0Ua/h+liJHgZCTO34oyYHMQBSqwgCgscdv
XKLV4G1ZIGKpjnMSc9C11+c=
=PAma
-----END PGP SIGNATURE-----

--nextPart1369078.phfUPtjlGL--
