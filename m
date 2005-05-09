From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Mon, 9 May 2005 09:01:18 +0100
Message-ID: <200505090901.25433.andyparkins@gmail.com>
References: <200505051650.38471.andyparkins@gmail.com> <200505071035.55508.andyparkins@gmail.com> <Pine.LNX.4.58.0505071011510.21399@deadrat.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3243809.tLWhuL0xBB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [195.102.65.187] ([195.102.65.187]:60648 "EHLO
	369run02s.360vision.com") by vger.kernel.org with ESMTP
	id S263074AbVEIIBd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 04:01:33 -0400
In-Reply-To: <Pine.LNX.4.58.0505071011510.21399@deadrat.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rich+ml@lclogic.com
Cc: linux-serial@vger.kernel.org

--nextPart3243809.tLWhuL0xBB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 2005 May 07 19:09, rich+ml@lclogic.com wrote:
> > > Have you tried hardware flow control, "stty crtscts < /dev/ttyX"?.=20
> > > With CTS strapped high, RTS should follow THRE||TE.
> >
> > That's an interesting idea - CTS is currently set by the RS485 converter
> > to indicate when it has successfully turned the buffer around.  So it
> > goes, RTS set high, wait for CTS, send...  Is what you're suggesting th=
at
> > I cut this wire and hold CTS high externally?
>
> Oh no, in that case you don't need to do anything. The transaction you
> described is exactly what happens automatically when crtscts is enabled.
>
> However if your uart doesn't actually support AFE then it will be done
> by the driver and have the timing characteristics you see already.
>
> Hook up your scope, "stty crtscts < /dev/ttyX; echo test > /dev/ttyX" and
> see what happens.

Are you sure that RTSCTS flow control is what you think it is?  These days =
RTS=20
means "request to send to me" rather than "I request to send"; that allows=
=20
RTS and CTS to be crossed over in null modem cables - and puts the flow=20
control in the receiver directly.

Of course in my case the RS485 converter is abusing the RTS line for its ow=
n=20
purposes, which is why I set -CRTSCTS.

Regardless of all that, I tried it anyway with no joy :-)

I'm coming to accept that what I'm after isn't possible.  How likely is it=
=20
that I could patch the serial_core kernel driver to do the RTS control for=
=20
me?  Am I going to end up in the same situation?


Andy

=2D-=20
Dr Andrew Parkins, M Eng (hons), AMIEE


--nextPart3243809.tLWhuL0xBB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCfxjVwQJ9gE9xL20RAnGsAKDh/UXqUluYRafWLaG5ZwQM8cnrcQCg25lw
MGPF4gsEeMcsWlnntjtDsgU=
=6Rev
-----END PGP SIGNATURE-----

--nextPart3243809.tLWhuL0xBB--
