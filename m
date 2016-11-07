From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC] serial: sh-sci: Fix unlocked access to SCSCR register
Date: Mon, 7 Nov 2016 16:52:09 +0100
Message-ID: <20161107155209.GC5140@katana>
References: <1478533373-10643-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478533373-10643-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2016 at 04:42:53PM +0100, Simon Horman wrote:
> From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
>=20
> The SCSCR register access in sci_break_ctl() is not locked.
>=20
> sci_start_tx() and sci_set_termios() changes the SCSCR register,
> but does not lock sci_port.

Maybe naive question: Shouldn't stop_tx and/or (start|stop)_rx be
protected, too? They change SCSCR as well?

> Therefore, this patch adds lock during register access.
>=20
> Also, remove the log output that leads to a double lock.
>=20
> Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutio=
ns.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYIKMpAAoJEBQN5MwUoCm2B1gP/0DdfxqYf88a2izUVETW5seF
LIbDGzTSQC/dyIlzzw5v7/7XjtMVWMjALq/mVk6eml5Ov5GvNQvpLNbxFjzbsykU
1fyaYUvUqywrtwi0Nl583B7fEgRHMuohTDIH77sGkerCCzbb06tPDLb0aRtUsHgL
6gkCARppa/B7HJSrlg+FJKMO0bK+4TYhaJ8LANyqohvwkIj2K7xtaEFkDnfgrfc+
9vvYXmnEwMenxTG4gXN28+pLo9uqPqVKfDTHhh4eLaD0a7Psqoc7qKheeDuPbS8j
AEqzfTezvPDqtUcS369fduvREd2VmRcSQEgzqahf0gCKK/Z4do538zlTX7E7MP6E
UK8LBuDDrHkYcdNurNYyrLmTT6NT0stvHLNeVOGV244mjV/Z9+kxCOP5zOSz7Gz9
uiQMD43zQGKgCMd9RV5HjWWW4zOlY3EU1QFa1DSq+rlE01nJOFQ4wBTizyQoVIOQ
6bqjmIdZpINqHv104MAw1YFXxcG2ZlmTSF4ixN3KK3wPxk6LptNJJSOMucyfYoNH
p8jDwN9cd062UHfGdrydbCgm/INtJQV0iKDlkH5FKAIupRp8qzabKMN/GdsPiBOk
rqiPW5Zdpf0pqXFddI8loR2cx+PxDXBNp3pqMPcwNQddegNMCHJRyIofoyvT8BsH
f5L9P25h++OkB0oANesx
=Z+80
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
