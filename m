From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC] serial: sh-sci: Fix deadlock caused by serial output
 request
Date: Mon, 7 Nov 2016 16:26:18 +0100
Message-ID: <20161107152618.GB5140@katana>
References: <1478531681-1561-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478531681-1561-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2016 at 04:14:41PM +0100, Simon Horman wrote:
> From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
>=20
> While spin is already locked, serial output request causes the deadlock,
> because serial output process also tries to lock the spin.
> This patch removes serial output with spin locked.
>=20
> Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutio=
ns.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> This is a patch from the Gen3 3.3.2 BSP.
> Geert, please consider it for mainline.
>=20
> Two approaches are mixed here: simply removing log messages that would
> cause a deadlock; and moving log messages to outside the lock. Some
> consideration was given (by Simon) to a more consistent approach of
> simply removing all log messages in question. However this was taken as
> logging ouside of the lock seems consistent with other logging in
> rx_timer_fn() and sci_dma_rx_complete().

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Simon, could you use the 'wsa+renesas' email address in the future? That
would make things a tad easier for me. Thanks!


--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYIJ0aAAoJEBQN5MwUoCm2A2AQAI2PeQojhgdBLnz31pKAtiha
FRLV+Rukp223w35vuCkiLcKwfgXeXFpnGkW6C1Rf33/vT1y22aZH0AIst+q8hHiZ
iSFH5N6zES5Hvd3ihJSKx6wKn3hNQWmIDo+kM8N7Pfcs9aRT6cKAncbjDL8Q74N2
e5xKRX/A+DI5yLONu74GDGBr95w/kE4dEYgfdf7/HD5oZPYc2qqSV9bmeXQTgEiS
G40pVzFSQd+vIT/ItD4m3XAdRD2v+X5WBelLwwqswojyF/Lxtqllw0iL9FdnH1Z8
/Eth8IiSGC7G10As167r7mGefIwtGkdAe1wwQ4UAmSg6CWEHmLf8Al4Mfx5zPa9N
/t8xCIOjrNURj9O4y131Vx05Jpw4ix2B2b9gyfpwOG2hkTpimrCcqOMkq9iOThdD
F6Q+vnOElkg+glR5NrNFlYtyUrwObGjrjVIBNPUmHDaRKeoqEez04IxLuPIEkcS7
hM7OMkLXWgIsH+LTDnSTO7T/DdORpbahjlMDO6KokzjUExSXZDUCLK+RaQCSfV/C
JQ3bNW5W212oGTswMtg6dwefcSnUESEMAE7cEFKuQE31w2dCt9KVpy7RYpLMOp2c
jB2eTfSKT6kEc75ky9jpkyR1bcglsZ6zmce8xbmWnVyfFJjIcviGh8l92WKhfopa
oXClGiYlCGW85JbiYYD7
=fkGI
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
