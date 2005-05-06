From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Fri, 6 May 2005 09:01:06 +0100
Message-ID: <200505060901.10692.andyparkins@gmail.com>
References: <200505051650.38471.andyparkins@gmail.com> <Pine.LNX.4.58.0505051023210.21399@deadrat.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2315259.rD9eK4cCPJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from host3.360visontechnology.com ([195.102.65.187]:44406 "EHLO
	369run02s.360vision.com") by vger.kernel.org with ESMTP
	id S261169AbVEFIBS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 May 2005 04:01:18 -0400
In-Reply-To: <Pine.LNX.4.58.0505051023210.21399@deadrat.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rich+ml@lclogic.com
Cc: linux-serial@vger.kernel.org

--nextPart2315259.rD9eK4cCPJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 2005 May 05 18:51, rich+ml@lclogic.com wrote:

> > Is it unreasonable to expect Linux to do a 200us turnaround?
>
> Assuming you have 2.6 kernel? HZ=3D1000 and you'll only get 1mS resolution

Thanks for your response.  You'll have to forgive me, I'm only vaguely=20
familiar with the kernel internals.  I thought that because all of the work=
=20
is being done in the kernel that the HZ value wouldn't have an effect?  In=
=20
serial_core.c: uart_wait_until_sent() the character timeout is defined as

char_time =3D (port->timeout - HZ/50) / port->fifosize;
char_time =3D char_time / 5;

=46rom this I guess that port->timeout is the estimated time for the whole=
=20
transmit buffer, which is then divided by port->fifosize to make this a per=
=20
character time which is then divided by five to ensure that the check for=20
tx_empty() is done five times per character (the comments say this is to=20
satisfy NIST-PCTS, whatever that is).  I'm not sure what the HZ/50 is for.

These times will all be significantly smaller than 1ms; if the value of HZ=
=20
where going to affect this then why has the author bothered to calculate=20
these times at all?  1ms would drown these other timeouts out.

Apologies if these are all stupid questions; as I say, I don't really know=
=20
what I'm talking about.=20


Andy

=2D-=20
Dr Andrew Parkins, M Eng (hons), AMIEE


--nextPart2315259.rD9eK4cCPJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCeyRGwQJ9gE9xL20RAmCVAKCLC6tmKcr27PEAYUBcUqgAji+pCACg3a49
q+CIAQTdxsQOaeglWruwwXw=
=BXkP
-----END PGP SIGNATURE-----

--nextPart2315259.rD9eK4cCPJ--
