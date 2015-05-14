From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add R-Car SCIF DMA receive support
Date: Thu, 14 May 2015 15:32:55 +0200
Message-ID: <20150514133255.GB2126@katana>
References: <1430500294-23407-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdWE03xpqXtEGzORQF3_L1v-UMux_2v76vkM0=hoOKFEOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWE03xpqXtEGzORQF3_L1v-UMux_2v76vkM0=hoOKFEOg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
List-Id: linux-serial@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 11:18:59AM +0200, Geert Uytterhoeven wrote:
> Hi Kaneko-san,
>=20
> On Fri, May 1, 2015 at 7:11 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> =
wrote:
> > From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> >
> > Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>=20
> Thank you for your patch! I will give it a try...
>=20
> It would be nice to have some more information in the patch description.
> E.g. what it's doing, and why it's needed.

Yes, description is really needed.

=46rom looking at the code I recognize a few things. Reminder: I was invest=
igating
this issue last year and we spoke about it in Montpellier.

A quote from back then:

"Once I submit the RX descriptor, I don't get any irq anymore (which the
driver needs to detect timeouts). Before that, I got them.

SCIFA has a bit (SCSCR_RDRQE) to select if the interrupt should go to
the CPU or DMAC and the driver handles this correctly, so DMA works
again.

Plain SCIF does not have such a bit. The documentation has a chapter
"SCIF Interrupt Sources and the DMAC" (chapter 51.4 here in v0.9) which
is a little vague to me. But from what I understand, I should get an irq
along with the DMAC transferring data. The implementation of this driver
shows that earlier SH hardware worked this way. However, I don't get
interrupts, so the timeout mechanism fails. DMA works partly, you can
receive in 32 bytes chunks only."

So, I assume the third sg list with 1 byte in size is for dealing with
this issue.

Regards,

   Wolfram


--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVKQHAAoJEBQN5MwUoCm2RCwP/1t0JYueDWf6AZbVKf+5PILa
TYOAa9+xAvh3OpPoMQm2LVz1hsDOiwSfxyhmImm7xeJmtqdc7/XY84IyXSaZrL4U
blWT8QIOWPbfTuGR6iVTFsHeoGFq2cMUCDRm3sN6Pjques+sOQx+aeUZSRqTLvYl
4KAPGYSqvRuJQpXs0opSPWzcDFswghgqx0J6yQRMENo6XLQxvfXtvVhIMa/J8JzW
4zAKrT7uFJM1HFur0In1WZhr4uztXLuWxseGHDJWXHgMy8cE8ermmlYNb/zAZb+K
zZ/RVlv8NdS4l7smY4WWFiWpahcZMq4DdO86RBMM7pMsdzVb9zlSzL645JUy6TK6
/ohfkQ14M3deuljOdOnD1n5C+0NhhtnTJSaiUa9KKcgAdR+TYP3tQ2ep+vASqzZ7
CMDcL9WyzAUW/ICWUOMw+vPEbLVDj9YY572Hoo7xRbTSevtGWk2+eOtah9e9eqtm
29UbKOFLe0LJBfrs2AyvE285Cf5tSxSHaQx75f25sKQ+cHnpNCtY1U4LtI5YL4V2
cKJA/ZKCoRhZM50h67Oc23ZNfxymZMy/Dj+K+NKigvc8cBmYOAEl4lhm/uHNmDwM
fXrmSlN074pSPIB1Al1OvSYTfp7Em6ANUnrgqygFFGprrmkrrREKYFNqXkbd+liC
3A67XAKVAdkMpaSQBQEI
=kKQ+
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
