From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Sat, 7 May 2005 10:35:50 +0100
Message-ID: <200505071035.55508.andyparkins@gmail.com>
References: <200505051650.38471.andyparkins@gmail.com> <200505060901.10692.andyparkins@gmail.com> <Pine.LNX.4.58.0505061137590.21399@deadrat.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1561573.72MnWde18P";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ptb-relay02.plus.net ([212.159.14.213]:17294 "EHLO
	ptb-relay04.plus.net") by vger.kernel.org with ESMTP
	id S262909AbVEGJf5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 7 May 2005 05:35:57 -0400
In-Reply-To: <Pine.LNX.4.58.0505061137590.21399@deadrat.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rich+ml@lclogic.com
Cc: linux-serial@vger.kernel.org

--nextPart1561573.72MnWde18P
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 06 May 2005 20:14, rich+ml@lclogic.com wrote:

Thanks for your response.

> It only kicks in for sub-1200 baud.

Oh dear.

> In any case linux is not an RTOS, it does not guarantee maximum latency,
> so no matter what you are going to be intermittent at best.

I appreciate that, I was disappointed because I know that some other people=
=20
are doing this on Windows and I assumed Linux would be able to kick a**. =20
Considering the magic that Linux can do elsewhere, it didn't seem=20
unreasonable to expect 9600 half duplex.  :-(

> Have you tried hardware flow control, "stty crtscts < /dev/ttyX"?.  With
> CTS strapped high, RTS should follow THRE||TE.

That's an interesting idea - CTS is currently set by the RS485 converter to=
=20
indicate when it has successfully turned the buffer around.  So it goes, RT=
S=20
set high, wait for CTS, send...  Is what you're suggesting that I cut this=
=20
wire and hold CTS high externally?

Andy

=2D-=20
Dr Andrew Parkins, M Eng (hons), AMIEE


--nextPart1561573.72MnWde18P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCfIv7wQJ9gE9xL20RAm2qAJ9pSYThuzKOkBOOHUb2SV+4PKpIbQCgiFQR
Oz5kZmRhmCuKfxkL78HapQQ=
=NNtE
-----END PGP SIGNATURE-----

--nextPart1561573.72MnWde18P--
