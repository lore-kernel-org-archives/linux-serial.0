From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] omap-serial high-speed fixes/improvements
Date: Mon, 18 Aug 2014 08:45:08 -0500
Message-ID: <20140818134507.GC9662@saruman.home>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406645577-18620-1-git-send-email-frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 29, 2014 at 04:52:54PM +0200, Frans Klaver wrote:
> Hi,
>=20
> Here's a couple of patches that should improve the behavior of the omap s=
erial
> driver at high data rates and baud rates.
>=20
> I was actually surprised to see that proper dma support isn't there yet, =
but
> there you go. Anyone got news on that, by the way?

please resend these patches and make sure you get the right Cc list.

You're missing linux-omap, Tony Lingren, linux-arm-kernel...
scripts/get_maintainer.pl would give you a more exaustive list of
people to Cc.

cheers

--=20
balbi

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT8gNjAAoJEIaOsuA1yqREXOkP/1Ntc/AGvt3iY4eiBRwfeTSs
+0n8iYZoO71BbenarsCVFZWE8Ri2NnACskVJ9LtOuAbNAr8pkbjuMnUSRoZZUTNf
3kM3CSnPFEYfUan6imURF9vbsivsjE99gej3AvQe0CsYKe1CXQ6DgkCrvOvPtHnA
QC9Utdo8j+J+gDyqvEOzXR8GI8aePdd+gbvmpDhLTB30+gteNZMVTx48VFu5wuYp
kzTeioeCNoieyvSkpTj2/rx0q7w5CwoPtKKUwCYG6IFR4u4R8Paanl8/i4kkYStS
QpHMZzgC1lNka7fA1/nZxEDBlR68YLoPbCgSsw7SFSVlo9XEWJm0LDJ1qZZZG9hB
f6MUiwjHR3Ze1nEObthzlDpZqHOAo6pTLEdFINwufvlzUGQPrb1rtA3w0I5orW6i
2FSjc8ANHZ4DQzUaexEDifmx/cOlI5euPsl3D1nZ5BwdRk5NLexmMGyY5K1WVP1Z
yrjo+vKqedb6YkEFZ7YMt+ghnocqiSAQgZqdkn1CzulBTs//FShrl6aRYl+tJMm2
nvgmZE6hQt3eOvEl5TqSNr8hWGW90ELvFmNfKHCfDn0dQNIR+msBLDXcmjONAzyC
xYT4X7X3aTC2XK0P7ZQ+JV75Et5nCbmQa0G4SK2xv7OiT1a/c0Tu5BoHC6fSABs6
/OkPhiVzPaGJtkw6bkFr
=rHAe
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
