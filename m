From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PPC/MPC5200B] strange data loss on uart reception
Date: Tue, 02 Nov 2010 19:06:02 +0100
Message-ID: <1288721170.1923.0@antares>
References: <20101101031003.GA2903@kroah.com> <1288622520.1807.0@antares>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-AR5CWhIrtYIfmoPHqUMX"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp5.netcologne.de ([194.8.194.25]:45381 "EHLO
	smtp5.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab0KBSGM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Nov 2010 14:06:12 -0400
In-Reply-To: <1288622520.1807.0@antares> (from albrecht.dress@arcor.de on
	Mon Nov  1 15:41:53 2010)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

--=-AR5CWhIrtYIfmoPHqUMX
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.11.10 15:41 schrieb(en) Albrecht Dre=DF:
> Am 01.11.10 04:10 schrieb(en) Greg KH:
>> On Sun, Oct 31, 2010 at 06:27:00PM +0100, Albrecht Dre? wrote:
>>> Am I simply too dumb to use the uart correctly, or is there some issue =
in the kernel causing this effect?  I noticed that the function mpc52xx_uar=
t_int_rx_chars() does not check the return value of tty_insert_flip_char().=
  If the system runs out of space (actually, the maximum buffer size used s=
hould be limited, in particular on embedded systems!), might this go undete=
cted?  This might explain the bigger "chunks", as the '5200's uart has a ra=
ther big fifo (512 bytes).
>>=20
>> That might help, have you tried changing this and seeing if it fixes any=
thing?

Ummm.  Apparently this was a hardware problem.  No errors on a 2nd board, a=
nd re-soldering the chip on the 1st fixed it there, too.  Probably a "cold"=
 soldering.

Sorry for the noise!

Cheers, Albrecht.

--=-AR5CWhIrtYIfmoPHqUMX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBM0FMRn/9unNAn/9ERAnfFAJ9MMW9BcWIXEXfUe2jbvopMCBBHogCeO5yP
ijhVn/LT7vwW2q91L5eupYI=
=+YVy
-----END PGP SIGNATURE-----

--=-AR5CWhIrtYIfmoPHqUMX--
